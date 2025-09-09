use pyo3::prelude::*;

//When `maturin init` created this file, it was called lib.rs

//from https://www.linkedin.com/learning/using-rust-with-python/call-python-from-rust
//In ^that video, this file is named main.rs

//cargo run doesn't work if this file is named lib.rs; what if it's named main?... 
//then must edit Cargo.toml to change [lib] node (see Cargo.toml for details), but still won't run -_-

fn main() -> PyResult<()> {
	pyo3::prepare_freethreaded_python();
	let values = vec![1,2,3];
	//print!("Passing values to Python to sum: {:?} \n",values);
	//println is better than print in this case
	println!("Passing values to Python to sum: {:?} \n",values);
	Python::with_gil(|py|{
		let builtins = PyModule::import(py, "builtins")?;
		let total: i32 = builtins.getattr("sum")?.call1((values,))?.extract()?;
		println!("Sum from Python: {} \n", total);
		let os = PyModule::import(py,"os")?;
		let user: String = os.getattr("getenv")?.call1(("USER",))?.extract()?;
		println!("User from Python: {} \n", user);
		Ok(())
	})
}

/*
TODO: Delete all this boilerplate once other code is confirmed working or at least building
/// Formats the sum of two numbers as string.
#[pyfunction]
fn sum_as_string(a: usize, b: usize) -> PyResult<String> {
    Ok((a + b).to_string())
}

/// A Python module implemented in Rust.
#[pymodule]
fn python_from_rust(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(sum_as_string, m)?)?;
    Ok(())
}
*/