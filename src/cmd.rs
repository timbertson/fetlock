use anyhow::*;
use futures::join;
use log::*;
use std::process::{ExitStatus, Stdio};
use std::str;
use tokio::io::{AsyncRead, AsyncReadExt, AsyncWriteExt};
use tokio::process::{Command, Child};

fn spawn(command: &mut Command) -> Result<Child> {
	command.kill_on_drop(true);
	debug!("{:?}", command);
	Ok(command.spawn().with_context(||format!("Spawning {:?}", command))?)
}

pub async fn run_raw(
	stdin: Option<&str>,
	stdout: Stdio,
	command: &mut Command,
) -> Result<(Option<String>, Option<String>, ExitStatus)> {
	command.stdout(stdout);
	command.stderr(Stdio::piped());
	if stdin.is_some() {
		command.stdin(Stdio::piped());
	}
	let mut child = spawn(command)?;
	let stdin_pipe = child.stdin.take();
	let mut stdout_pipe = child.stdout.take();
	let mut stderr_pipe = child.stderr.take();
	let (wrote_stdin, stdout, stderr) = join!(
		(|| async {
			match (stdin, stdin_pipe) {
				(Some(contents), Some(mut pipe)) => {
					debug!("writing stdin: {}", contents);
					let result = pipe.write(contents.as_bytes()).await;
					debug!("closing subprocess stdin");
					drop(pipe);
					result.map(|_: usize| ())
				}
				(None, _) => Ok(()),
				(Some(_), None) => Err(std::io::Error::new(
					std::io::ErrorKind::Other,
					anyhow!("input given but stdin is not a pipe"),
				)),
			}
		})(),
		read_io_opt(&mut stdout_pipe),
		read_io_opt(&mut stderr_pipe),
	);
	let status = child.wait().await.with_context(|| "process.wait()")?;
	wrote_stdin.with_context(|| "writing to stdin")?;
	Ok((stdout?, stderr?, status))
}

pub async fn run(
	desc: &str,
	stdin: Option<&str>,
	stdout: Stdio,
	mut command: &mut Command,
) -> Result<Option<String>> {
	let (stdout, stderr, status) = run_raw(stdin, stdout, &mut command)
		.await
		.with_context(|| format!("executing {}", desc))?;
	if status.success() {
		log_output(Level::Debug, desc, Ok(stderr));
		Ok(stdout)
	} else {
		log_output(Level::Warn, desc, Ok(stderr));
		Err(anyhow!(
			"Process failed (code={:?}): {:?}",
			status.code(),
			command
		))
	}
}

pub async fn run_stdout(desc: &str, stdin: Option<&str>, command: &mut Command) -> Result<String> {
	run(desc, stdin, Stdio::piped(), command)
		.await
		.map(|stdout| stdout.expect("stdout is none"))
}

fn check_status(
	desc: &str,
	command: &mut Command,
	status: ExitStatus,
	output: Result<Option<String>>,
) -> Result<()> {
	if status.success() {
		log_output(Level::Debug, desc, output);
		Ok(())
	} else {
		log_output(Level::Warn, desc, output);
		Err(anyhow!(
			"Process failed (code={:?}): {:?}",
			status.code(),
			command
		))
	}
}

pub async fn exec(command: &mut Command) -> Result<()> {
	let status = spawn(command)?.wait().await?;
	check_status("cmd", command, status, Ok(None))
}

async fn read_io_opt<Pipe: AsyncRead + Unpin>(pipe: &mut Option<Pipe>) -> Result<Option<String>> {
	if let Some(mut pipe) = pipe.take() {
		let mut buf = String::new();
		let _len: usize = pipe.read_to_string(&mut buf).await?;
		buf.truncate(buf.trim_end().len());
		Ok(Some(buf))
	} else {
		Ok(None)
	}
}

pub fn log_output(lvl: Level, desc: &str, output: Result<Option<String>>) {
	if log_enabled!(lvl) {
		match output {
			Ok(None) => (),
			Ok(Some(output)) => {
				if !output.is_empty() {
					for line in output.lines() {
						log!(lvl, "[{}]: {}", desc, line);
					}
				}
			}
			Err(e) => {
				warn!("[{}]: can't read stderr: {:?}", desc, e);
			}
		}
	}
}
