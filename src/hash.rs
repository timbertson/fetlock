use anyhow::*;
use lazy_static::lazy_static;
use std::fmt;
// use std::fmt::Debug;
use std::iter::Iterator;
use data_encoding::{HEXLOWER_PERMISSIVE as HEX, BASE64, Specification, Encoding};

// Hash algorithms supported by nix
#[derive(Debug, Copy, Clone, PartialEq, Eq, PartialOrd, Ord)]
pub enum HashAlg {
	// Definition order controls sort order. Last is better (we take the maximum)
	Md5, Sha1, Sha256, Sha512
}

impl HashAlg {
	pub fn parse(s: &str) -> Result<Self> {
		match s {
			"md5" => Ok(HashAlg::Md5),
			"sha1" => Ok(HashAlg::Sha1),
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
		let bytes = HEX.decode(hex.as_bytes())
			.with_context(|| format!("decoding hex digest: {:?}", hex))?;
		Ok(Self::from_bytes(alg, &bytes))
	}

	pub fn from_nix_b32(alg: HashAlg, b32: String) -> Result<Self> {
		lazy_static! {
			static ref NIX_ENCODING: Encoding = {
				let mut spec = Specification::new();
				// https://github.com/NixOS/nix/blob/782837d9345b70023c682a177c074333d1cb7baa/src/libutil/hash.cc#L83-L107
				spec.symbols.push_str("0123456789abcdfghijklmnpqrsvwxyz");
				spec.bit_order = data_encoding::BitOrder::LeastSignificantFirst;
				spec.encoding().unwrap()
			};
		}
		// Nix treats the entire input as a sequence of u8, with least significant bit first.
		// The NIX_ENCODING allows us to specify a bit order (not byte order), so we still
		// have to manually reverse the bytes.
		let mut b32_rev = b32.into_bytes();
		b32_rev.reverse();
		Ok(Self::from_bytes(alg, &NIX_ENCODING.decode(&b32_rev).with_context(|| "decoding base32 digest")?))
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
}

pub struct SRIFormat<'a>(&'a NixHash);

impl<'a> fmt::Display for SRIFormat<'a> {
	fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
		f.write_fmt(format_args!("{}-{}", self.0.alg, self.0.b64))
	}
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn test_hash_alg_order() {
		use HashAlg::*;
		let mut all = vec!(Sha1, Sha512, Sha256, Md5);
		all.sort();
		assert_eq!(all, vec!(Md5, Sha1, Sha256, Sha512));
		assert_eq!(all.into_iter().max(), Some(Sha512));
	}

	#[test]
	fn test_sri() {
		NixHash::parse_sri("sha256-uwehbMgcghqFcnaTyrlF5KI7QvLTdUMERuAopgTdm7A=").unwrap();
	}

	#[test]
	fn test_base32_hex_equivalence() {
		assert_eq!(
			NixHash::from_hex(HashAlg::Sha256, "ab335240fd942ab8191c5e628cd4ff3903c577bda961fb75df08e0303a00527b").unwrap(),
			NixHash::from_nix_b32(HashAlg::Sha256, "0ysj00x31q08vxsznqd9pmvwa0rrzza8qqjy3hcvhallzm054cxb".to_owned()).unwrap(),
		);
	}
}
