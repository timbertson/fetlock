use anyhow::*;
use lazy_static::lazy_static;
use std::fmt;
// use std::fmt::Debug;
use std::iter::Iterator;
use data_encoding::{HEXLOWER_PERMISSIVE as HEX, BASE64, Specification, Encoding};

// Hash algorithms supported by nix
#[derive(Debug, Clone, PartialEq)]
pub enum HashAlg {
	Md5, Sha1, Sha256, Sha512
}

impl HashAlg {
	pub fn parse(s: &str) -> Result<Self> {
		match s {
			"sha256" => Ok(HashAlg::Sha256),
			"sha512" => Ok(HashAlg::Sha512),
			other => Err(anyhow!("Unknown hash algorithm: {:?}", other)),
		}
	}
}

impl fmt::Display for HashAlg {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		match self {
			Self::Md5 => f.write_str("md5"),
			Self::Sha1 => f.write_str("sha1"),
			Self::Sha256 => f.write_str("sha256"),
			Self::Sha512 => f.write_str("sha512"),
		}
	}
}

// All SRI hashes are stored in b64. We could store the bytes,
// but the b64 string is always needed anyway
#[derive(Debug, Clone, PartialEq)]
pub struct NixHash {
	alg: HashAlg,
	b64: String,
}

impl NixHash {
	pub fn parse_sri(s: &str) -> Result<Self> {
		let mut it = s.split('-');
		let err = || anyhow!("invalid SRI hash: {}", s);
		let alg = HashAlg::parse(it.next().ok_or_else(err)?)?;
		let b64 = it.next().ok_or_else(err)?.to_owned();
		if it.next().is_some() {
			// too many components
			return Err(err());
		}
		Ok(Self { alg, b64 })
	}
	
	pub fn from_hex(alg: HashAlg, hex: &str) -> Result<Self> {
		Ok(Self::from_bytes(alg, &HEX.decode(hex.as_bytes())?))
	}

	pub fn from_nix_b32(alg: HashAlg, b32: &str) -> Result<Self> {
		lazy_static! {
			static ref NIX_ENCODING: Encoding = {
				let mut spec = Specification::new();
				// https://github.com/NixOS/nix/blob/782837d9345b70023c682a177c074333d1cb7baa/src/libutil/hash.cc#L83-L107
				spec.symbols.push_str("0123456789abcdfghijklmnpqrsvwxyz");
				spec.encoding().unwrap()
			};
		}
		Ok(Self::from_bytes(alg, &NIX_ENCODING.decode(b32.as_bytes())?))
	}
	
	fn from_bytes(alg: HashAlg, bytes: &[u8]) -> Self {
		Self { alg, b64: BASE64.encode(bytes) }
	}

	pub fn sri(&self) -> SRIFormat {
		SRIFormat(self)
	}

	pub fn sri_string(&self) -> String {
		format!("{}", self.sri())
	}

	pub fn dummy() -> &'static Self {
		lazy_static! {
			static ref DUMMY: NixHash = {
				let bytes = std::iter::repeat::<u8>(0)
					.take(256 / 8)
					.collect::<Vec<u8>>();
				NixHash::from_bytes(HashAlg::Sha256, &bytes)
			};
		}
		&DUMMY
	}
	
	pub fn legacy_sha256_b32_len() -> u8 {
		53
	}
}

pub struct SRIFormat<'a>(&'a NixHash);

impl<'a> fmt::Display for SRIFormat<'a> {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		f.write_fmt(format_args!("{}-{}", self.0.alg, self.0.b64))
	}
}
