use anyhow::*;
use std::env;
use std::writeln;
use std::io::Write;
use getopts::Options;

use fetlock::esy;

fn print_usage(program: &str, opts: Options) {
    let brief = format!("\
Usage: {} LOCKFILE [options]
", program);
    print!("{}", opts.usage(&brief));
}

fn main() -> Result<()> {
  env_logger::from_env(env_logger::Env::default().default_filter_or("info"))
    .format(|buf, record| {
      let level = buf.default_styled_level(record.level());
      writeln!(buf, "{}: {}", level, record.args())
    })
    .init();
  let args: Vec<String> = env::args().collect();
  let program = args[0].clone();

  let mut opts = Options::new();
  opts.optflag("h", "help", "print this help menu");
  opts.optflag("", "full", "reload all track metadata, ignoring `mtime`");
  opts.optflagopt("", "export-limit", "per-playlist export limit, in GB (not applied to entire export)", "SIZE");
  opts.optflagopt("", "min-tracks", "minimum track filter for artist subcommand", "NUM");
  let matches = opts.parse(&args[1..])?;
  if matches.opt_present("h") {
    return Ok(print_usage(&program, opts));
  }
  println!("Hello, world");
  
  let lock = esy::load("sample/esy.json")?;
  println!("{:?}", lock);
  Ok(())
}
