use lazy_static::lazy_static;
use regex::Regex;
use std::fmt;
use std::fmt::Debug;
use std::iter::Iterator;

// Union of all the hash algorithms supported by
// package managers we import from
pub enum HashAlg {
	Md5, Sha256, Sha512
}

// Hash algorithms supported by nix
pub enum NixHashAlg {
	Md5, Sha1, Sha256, Sha512
}


#[derive(Debug, Clone, PartialEq)]
pub enum NixHash {
	SRI(SRIHash),
	Sha256(Sha256),
}

impl NixHash {
	pub fn parse(s: String) -> NixHash {
		if s.contains('-') {
			NixHash::SRI(SRIHash::new(s))
		} else {
			let digest_only = s.strip_prefix("sha256:").map(|slice| slice.to_string()).unwrap_or(s);
			NixHash::Sha256(Sha256::new(digest_only))
		}
	}

	pub fn dummy() -> &'static Self {
		lazy_static! {
			static ref DUMMY: NixHash = NixHash::Sha256(Sha256::new(
				std::iter::repeat("0")
					.take(Sha256::default_len())
					.collect::<String>()
			));
		}
		&DUMMY
	}

	pub fn hash_repr(&self) -> String {
		format!("{}", self)
	}
}

impl fmt::Display for NixHash {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		match self {
			Self::SRI(x) => f.write_str(&x.0),
			Self::Sha256(x) => {
				f.write_str("sha256:")?;
				f.write_str(&x.0)
			},
		}
	}
}

#[derive(Debug, Clone, PartialEq)]
pub struct Sha256(String);

impl Sha256 {
	// classic (base32) hashes
	// If we want to support nix <2.4, we'd need to parse nix' custom b32 and rewrite in base64.
	// So for now we just accept both
	pub fn new(s: String) -> Sha256 {
		lazy_static! {
			static ref SHA256_RE: Regex = Regex::new(r"^[0-9a-zA-Z]{52}$").unwrap();
		}
		if !SHA256_RE.is_match(&s) {
			panic!("invalid sha256: {:?}", s);
		}
		Sha256(s)
	}

	pub fn default_len() -> usize {
		52
	}

	pub fn into_string(self) -> String {
		self.0
	}
}

#[derive(Debug, Clone, PartialEq)]
pub struct SRIHash(String);

impl SRIHash {
	pub fn new(s: String) -> Self {
		lazy_static! {
			static ref SRI_RE: Regex = Regex::new(r"^sha[0-9]+-[^ ]+$").unwrap();
		}
		if !SRI_RE.is_match(&s) {
			panic!("invalid SRI hash: {:?}", s);
		}
		Self(s)
	}

	pub fn into_string(self) -> String {
		self.0
	}
}
