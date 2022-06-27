use percent_encoding::*;

pub fn encode<'a>(input: &'a str) -> PercentEncode<'a> {
	utf8_percent_encode(input, CONTROLS)
}
