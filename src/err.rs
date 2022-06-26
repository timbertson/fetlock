use std::io;

pub fn into_serde<T, E: serde::de::Error>(input: anyhow::Result<T>) -> Result<T, E> {
	input.map_err(|err| E::custom(format!("{:?}", err)))
}

pub fn into_io<T>(input: anyhow::Result<T>) -> Result<T, io::Error> {
	input.map_err(|err| io::Error::new(io::ErrorKind::Other, err))
}
