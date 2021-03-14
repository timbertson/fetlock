// https://github.com/rubygems/rubygems/blob/master/bundler/lib/bundler/lockfile_parser.rb
pub use crate::nom_util::*;
use crate::{Name, Version};

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct GemSpec {
	name: Name,
	version: Version,
	dependencies: Vec<Name>,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Section {
	Git(Vec<GitField>),
	Gem(Vec<GemField>),
	Dependencies(Vec<Name>),
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum GemField {
	Specs(Vec<GemSpec>),
	Remote(String),
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum GitField {
	Common(GemField),
	Revision(String),
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct File(Vec<Section>);

// convention: each field consumes any preceeding newline(s), we don't expect a newline at the
// end of any fields. We additionally accept any number of newlines at file end.

fn indent0(s: Src) -> Res<()> {
	map(take_while(|ch| ch == '\n'), |_| ())(s)
}

fn indent2(s: Src) -> Res<()> {
	map(tuple((newline, tag("  "))), |_| ())(s)
}

fn indent4(s: Src) -> Res<()> {
	map(tuple((newline, tag("    "))), |_| ())(s)
}

fn indent6(s: Src) -> Res<()> {
	map(tuple((newline, tag("      "))), |_| ())(s)
}

fn indented_line(s: Src) -> Res<()> {
	map(tuple((indent2, non_newline)), |_| ())(s)
}

fn non_newline(s: Src) -> Res<&str> {
	take_while(|ch| ch != '\n')(s)
}

fn non_space(s: Src) -> Res<&str> {
	take_while1(|ch| ch != ' ' && ch != '\t' && ch != '\n')(s)
}

fn non_space_string(s: Src) -> Res<String> {
	map(non_space, |s| s.to_owned())(s)
}

fn single_line(prefix: &'static str) -> impl Fn(Src) -> Res<String> {
	move |s| {
		map(
			tuple((indent2, tag(prefix), tag(": "), non_space_string)),
			|(_, _, _, value)| value,
		)(s)
	}
}

fn dependency_name(s: Src) -> Res<Name> {
	map(
		tuple((indent6, non_space_string, char(' '), non_newline)),
		|(_indent, name, _space, _suffix)| Name(name),
	)(s)
}

fn spec(s: Src) -> Res<GemSpec> {
	map(
		tuple((
			indent4,
			non_space_string,
			char(' '),
			delimited(char('('), take_while1(|ch| ch != ')'), char(')')),
			many0(dependency_name),
		)),
		|(_indent, name, _space, version, dependencies)| GemSpec {
			name: Name(name),
			version: Version(version.to_owned()),
			dependencies,
		},
	)(s)
}

fn specs(s: Src) -> Res<Vec<GemSpec>> {
	map(
		tuple((indent2, tag("specs:"), many0(spec))),
		|(_, _, specs)| specs,
	)(s)
}

fn dependency_field(s: Src) -> Res<Name> {
	map(
		tuple((
			indent2,
			take_while1(|ch| ch != '\n' && ch != ' ' && ch != '!'),
			non_newline,
		)),
		|(_, name, _)| Name(name.to_owned()),
	)(s)
}

fn gem_field(s: Src) -> Res<GemField> {
	alt((
		map(specs, GemField::Specs),
		map(single_line("remote"), GemField::Remote),
	))(s)
}

fn git_field(s: Src) -> Res<Option<GitField>> {
	alt((
		map(gem_field, |f| Some(GitField::Common(f))),
		map(single_line("revision"), |f| Some(GitField::Revision(f))),
		// discard these
		map(single_line("tag"), |_| None),
		map(single_line("ref"), |_| None),
	))(s)
}

fn section(s: Src) -> Res<Option<Section>> {
	preceded(
		indent0,
		alt((
			map(preceded(tag("GIT"), many0(git_field)), |fields| {
				Some(Section::Git(fields.into_iter().filter_map(|x| x).collect()))
			}),
			map(preceded(tag("GEM"), many0(gem_field)), |fields| {
				Some(Section::Gem(fields))
			}),
			map(
				preceded(tag("DEPENDENCIES"), many0(dependency_field)),
				|fields| Some(Section::Dependencies(fields)),
			),
			map(
				// discard these
				preceded(
					alt((
						tag("RUBY VERSION"),
						tag("BUNDLED WITH"),
						tag("PLATFORMS"),
						tag("DEPENDENCIES"),
					)),
					many0(indented_line),
				),
				|_| None,
			),
		)),
	)(s)
}

pub fn file_contents(s: Src) -> Res<File> {
	map(many0(section), |sections| {
		File(sections.into_iter().filter_map(|x| x).collect())
	})(s)
}

pub fn entire_file(s: Src) -> Res<File> {
	all_consuming(terminated(file_contents, indent0))(s)
}

#[cfg(test)]
mod tests {
	use super::*;
	pub use crate::nom_util::test::*;

	#[test]
	fn test_git_section() {
		assert_eq!(
			p(
				section,
				r#"
GIT
  remote: https://github.com/alloy/peiji-san.git
  revision: eca485d8dc95f12aaec1a434b49d295c7e91844b
  specs:
    peiji-san (1.2.0)"#
			),
			Some(Section::Git(vec!(
				GitField::Common(GemField::Remote(
					"https://github.com/alloy/peiji-san.git".to_owned()
				)),
				GitField::Revision("eca485d8dc95f12aaec1a434b49d295c7e91844b".to_owned()),
				GitField::Common(GemField::Specs(vec!(GemSpec {
					name: Name("peiji-san".to_owned()),
					version: Version("1.2.0".to_owned()),
					dependencies: vec!(),
				},))),
			)))
		)
	}

	#[test]
	fn test_entire_file() {
		valid(
			entire_file,
			r#"
GIT
  remote: https://github.com/alloy/peiji-san.git
  revision: eca485d8dc95f12aaec1a434b49d295c7e91844b
  specs:
    peiji-san (1.2.0)
GEM
  remote: https://rubygems.org/
  specs:
    rake (10.3.2)
PLATFORMS
  ruby
DEPENDENCIES
  peiji-san!
  rake
RUBY VERSION
   ruby 2.1.3p242
BUNDLED WITH
   1.12.0.rc.2
"#
			.trim(),
		);
	}
}
