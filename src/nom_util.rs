use anyhow::*;

pub use nom::{
	branch::*, bytes::complete::*, character::complete::*, combinator::*, error::context,
	error::convert_error, error::VerboseError, multi::*, sequence::*, *,
};

pub type Src<'a> = &'a str;
pub type SrcError<'a> = VerboseError<Src<'a>>;
pub type Res<'a, T> = IResult<Src<'a>, T, SrcError<'a>>;
pub trait SrcParser<'a, T>: Parser<Src<'a>, T, SrcError<'a>> {}
impl<'a, T, P> SrcParser<'a, T> for P where P: Parser<Src<'a>, T, SrcError<'a>> {}

/// A combinator that takes a parser `inner` and produces a parser that also consumes both leading and
/// trailing whitespace, returning the output of `inner`.
pub fn ws<'a, I: 'a, O, F>(filler: F, inner: I) -> impl FnMut(Src<'a>) -> Res<O>
where
	I: SrcParser<'a, O>,
	F: SrcParser<'a, ()> + Copy,
{
	delimited(filler, inner, filler)
}

pub fn parse<'a, T, F>(mut p: F, contents: &'a str) -> Result<T>
where
	F: FnMut(Src<'a>) -> Res<T>,
{
	let (_, ret) = p(contents).map_err(|e| {
		let msg: String = match e {
			Err::Incomplete(_) => {
				panic!()
			}
			Err::Error(e) | Err::Failure(e) => {
				format!("Parse error - trace:\n{}", convert_error(contents, e))
			}
		};
		anyhow!(msg)
	})?;
	Ok(ret)
}

#[cfg(test)]
pub mod test {
	use super::*;
	use log::*;

	pub fn valid<'a, T, F>(p: F, contents: &'a str) -> ()
	where
		F: FnMut(Src<'a>) -> Res<T>,
		T: std::fmt::Debug,
	{
		match parse(all_consuming(p), contents) {
			Ok(result) => info!("{:?}", result),
			Err(p) => panic!(format!("{}", p)),
		}
	}

	pub fn p<'a, T, F>(p: F, contents: &'a str) -> T
	where
		F: FnMut(Src<'a>) -> Res<T>,
		T: std::fmt::Debug,
	{
		match parse(all_consuming(p), contents) {
			Ok(result) => {
				info!("{:?}", result);
				result
			}
			Err(p) => panic!(format!("{}", p)),
		}
	}
}
