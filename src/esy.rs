// esy.lock backend

use anyhow::*;
use crate::lock;
use crate::{Lock};

pub fn load(path: &str) -> Result<Lock> {
  let context = lock::Context::new(lock::Type::Esy);
  let lock = Lock::new(context);
  panic!("nah")
}