//from https://www.linkedin.com/learning/using-rust-with-python/embedded-rust-cli

use clap::Parser;
use marco_python_cli::marco_python;

#[derive(Parser)]
#[command(
	author,
	version,
	about,
	long_about = "A CLI tool that wraps PyO3 embedded Python code"
)]

struct Cli{
	#[clap(short, long)]
	input: String,
}

fn main(){
	let args : Cli = Cli::parse();
	let input : String = args.input;
	let output : String = marco_python(&input).unwrap();
	println!("output: {}", output)
}
