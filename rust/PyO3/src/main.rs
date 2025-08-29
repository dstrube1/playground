//Starting from here:
// https://www.linkedin.com/learning/using-rust-with-python/pyo3-installation

/*
Documentation sites:

1-
https://lib.rs/crates/pyo3
PyO3 v0.25.1	(as of Jun 12, 2025)
Requires Rust 1.63+
and the following Python distributions:
	CPython 3.7 or greater
	PyPy 7.3 (Python 3.9+)
	GraalPy 24.2 or greater (Python 3.11+)

2-
https://pyo3.rs/ 
redirects to ->
https://pyo3.rs/v0.25.1/

3-
https://github.com/PyO3/pyo3
	Requires Rust 1.74 or greater (?)

4-
https://docs.rs/pyo3/
redirects to ->
https://docs.rs/pyo3/latest/pyo3/

END Documentation sites
*/

/*
Create, build, and run:
to create this from `~/playground/rust` (with no pre-existing PyO3 dir):
cargo new PyO3

to check the version of ...
rust:
rustc --version
[as of 2025-08-19:
rustc 1.88.0
]

python --version
[Python 3.11.5]

	to create python virtual environment:
python -m venv ~/.venv
	
	to activate the python virtual environment:
source ~/.venv/bin/activate
	#alternatively, add this^ to bashrc (or whatever) so it happens automatically every time, but we might not want to do this every time
	
	to add the maturin package into the virtual environment:
pip install maturin
	
	= REPEAT THIS PART FOR EACH NEW PROJECT =
	to initialize a new py03 project (the proper way, not with cargo new...):
mkdir pyo3-example
cd pyo3-example
maturin init
	[select pyo3 option, this will create (among other things) lib.rs]
	
	to build, from pyo3-example dir:
maturin develop
 	if you get an error like this:
		💥 maturin failed
		  Caused by: Both VIRTUAL_ENV and CONDA_PREFIX are set. Please unset one of the
	then run this
		conda deactivate
	and try `maturin develop` again

	to run what was built:
python
	then in the python interpreter:
import py03_example
	(as specified here: PyO3/py03-example/Cargo.toml)
py03_example.sum_as_string(5,20)
	confirm output: '25', using Python code from Rust


*/

fn main() {
    println!("Hello, world!");
}
