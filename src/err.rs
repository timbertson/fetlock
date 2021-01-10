pub fn into_serde<T, E: serde::de::Error>(input: anyhow::Result<T>) -> Result<T, E> {
	input.map_err(|err| E::custom(format!("{:?}", err)))
}
