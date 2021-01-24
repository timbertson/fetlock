use serde::Deserialize;

#[derive(Debug, Clone, Deserialize)]
struct PackageJson {
  esy: EsySpec,
}

type Script = Vec<Vec<String>>;

// see:
// https://esy.sh/docs/en/configuration.html
// https://esy.sh/docs/en/environment.html#variable-substitution-syntax
#[derive(Debug, Clone, Deserialize)]
struct EsySpec {
  build: Script
}
