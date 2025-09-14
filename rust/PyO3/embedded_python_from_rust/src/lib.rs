use pyo3::types::PyString;
use pyo3::{prelude::*, types::PyModeule};

/*
from https://www.linkedin.com/learning/using-rust-with-python/run-python-with-embedded-rust

Must use the {maturin init} command from the embedded_python_from_rust directory, already existing and empty.

*/

pub fn marco_python(input: &str) -> PyResult<String> {
	pyo3::prepare_freethreaded_python();
	Python::with_gil(|py| {
		let marco = PyModule::from_code(
			py,
			r#"
def marco(input):
	if input == "marco":
		return "python"
	else:
		return "no python"
"#,
			"marco.py",
			"marco",
		)?;
		let marco_func = marco.getattr("marco")?;
		let marco_result = marco_func.call1((input,))?;
		let marco_result: &PyString = marco_result.extract()?;
		Ok(marco_result.to_string())
		/*
error[E0599]: the method `to_string` exists for reference `&PyString`, but its trait bounds were not satisfied
   --> src/lib.rs:29:19
    |
29  |         Ok(marco_result.to_string())
    |                         ^^^^^^^^^ method cannot be called on `&PyString` due to unsatisfied trait bounds
    |
		*/
	})
}

// Unit testing:
//from https://www.linkedin.com/learning/using-rust-with-python/embedded-rust-cli-test
#[cfg(test)]
mod tests{
	use super::*;
	
	#[test]
	fn test_marco_python(){
		let input = "marco";
		let expected_output = "python".to_string();
		let output = marco_python(input).unwrap();
		assert_eq!(output, expected_output, "Failed for input: {}", input);
	}

	#[test]
	fn test_no_python(){
		let input = "not_marco";
		let expected_output = "no python".to_string();
		let output = marco_python(input).unwrap();
		assert_eq!(output, expected_output, "Failed for input: {}", input);
	}
}

/*
Commenting out after https://www.linkedin.com/learning/using-rust-with-python/embedded-rust-cli
fn main(){
	println!("From embedded Python: {}", marco_python("marco").unwrap());
	println!("From embedded Python: {}", marco_python("polo").unwrap());
}

*/

/*
TODO: above doesn't build, much less run

/// Formats the sum of two numbers as string.
#[pyfunction]
fn sum_as_string(a: usize, b: usize) -> PyResult<String> {
    Ok((a + b).to_string())
}

/// A Python module implemented in Rust.
#[pymodule]
fn embedded_python_from_rust(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(sum_as_string, m)?)?;
    Ok(())
}
*/