use anyhow::*;

pub fn split_one<'a>(sep: &'static str, s: &'a str) -> (&'a str, Option<&'a str>) {
	let mut it = s.splitn(2, sep);
	let start = it.next().expect("split returned no results");
	let end = it.next();
	(start, end)
}

pub fn split_one_or_else<'a, FnErr: FnOnce() -> Error>(
	sep: &'static str,
	s: &'a str,
	err: FnErr,
) -> Result<(&'a str, &'a str)> {
	let (start, end) = split_one(sep, s);
	let end = end.ok_or_else(err)?;
	Ok((start, end))
}
