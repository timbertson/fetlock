use anyhow::*;
use futures::join;
use log::*;
use std::process::{ExitStatus, Stdio};
use std::str;
use tokio::io::{AsyncReadExt, AsyncRead, AsyncWriteExt};
use tokio::process::Command;

pub async fn run_raw<'a>(command: &'a mut Command, stdin: Option<&'a str>, stdout: Stdio)
	-> Result<(Option<String>, Option<String>, ExitStatus)> {
	debug!("{:?}", command);
	command.stdout(stdout);
	command.stderr(Stdio::piped());
	if stdin.is_some() {
		command.stdin(Stdio::piped());
	}
	command.kill_on_drop(true);
	let mut child = command.spawn()?;
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
				},
				(None, _) => Ok(()),
				(Some(_), None) => Err(std::io::Error::new(
					std::io::ErrorKind::Other,
					anyhow!("input given but stdin is not a pipe"))),
			}
		})(),
		read_io_opt(&mut stdout_pipe),
		read_io_opt(&mut stderr_pipe),
	);
	let status = child.wait().await?;
	wrote_stdin.with_context(||"writing to stdin")?;
	Ok((stdout?, stderr?, status))
}

pub async fn run<'a>(desc: &'static str, mut command: Command, stdin: Option<&'a str>, stdout: Stdio) -> Result<Option<String>> {
	let (stdout, stderr, status) = run_raw(&mut command, stdin, stdout).await?;
	if status.success() {
		Ok(stdout)
	} else {
		warn_output(desc, &Ok(stderr));
		Err(anyhow!("Process failed (code={:?}): {:?}", status.code(), command))
	}
}

pub async fn run_stdout<'a>(desc: &'static str, command: Command, stdin: Option<&'a str>) -> Result<String> {
	run(desc, command, stdin, Stdio::piped()).await.map(|stdout| stdout.expect("stdout is none"))
}


async fn read_io_opt<Pipe: AsyncRead + Unpin>(pipe: &mut Option<Pipe>) -> Result<Option<String>> {
	if let Some(mut pipe) = pipe.take() {
		let mut buf = String::new();
		let _len: usize = pipe.read_to_string(&mut buf).await?;
		Ok(Some(buf))
	} else {
		Ok(None)
	}
}

pub fn warn_output(desc: &'static str, output: &Result<Option<String>>) {
	match output {
		Ok(None) => (),
		Ok(Some(output)) => {
			if !output.is_empty() {
				for line in output.lines() {
					warn!("[{}]: {}", desc, line);
				}
			}
		}
		Err(e) => {
			warn!("[{}]: can't read stderr: {:?}", desc, e);
		}
	}
}

