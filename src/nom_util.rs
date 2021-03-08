pub use nom::{
	branch::*, bytes::complete::*, character::complete::*, combinator::*, error::context,
	error::convert_error, error::VerboseError, multi::*, sequence::*, *,
};

pub type Src<'a> = &'a str;
pub type SrcError<'a> = VerboseError<Src<'a>>;
pub type Res<'a, T> = IResult<Src<'a>, T, SrcError<'a>>;
pub trait SrcParser<'a, T>: Parser<Src<'a>, T, SrcError<'a>> {}
impl<'a, T, P> SrcParser<'a, T> for P where P: Parser<Src<'a>, T, SrcError<'a>> {}
