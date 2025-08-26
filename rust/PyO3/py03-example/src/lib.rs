use pyo3::prelude::*;
//^ Required for: PyResult, pyfunction, pymodule, Bound, & wrap_pyfunction

/// Format the sum of two numbers as string.
#[pyfunction]
fn sum_as_string(a: usize, b: usize) -> PyResult<String> {
    Ok((a + b).to_string())
}

/// A Python module implemented in Rust.
#[pymodule]
fn py03_example(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(sum_as_string, m)?)?;
    m.add_function(wrap_pyfunction!(calculate_pi, m)?)?;
    Ok(())
}

//from "Basic Rust library" video

//If you have computationally or memory intensive logic, then build it in Rust and then export it to Python

//Calculate an approximation of Pi using the Leibniz formula.
//The more iterations, the more accurate the result
#[pyfunction]
fn calculate_pi(iterations: u32) -> PyResult<f64> {
	let mut pi = 0.0;
	for k in 0 .. iterations{
		pi += ((-1.0f64).powi(k as i32) / (2 * k + 1) as f64) * 4.0;
	}
    Ok(pi)
}

/*
//Is it okay to have two #[pyfunction] and two #[pymodule] in the same file? 
Two #[pyfunction], yes; two #[pymodule], no. Must move the call to m.add_function to the first pymodule
Interesting that the function signature of the first pymodule doesn't have to match the second

//TODO: Maybe if we also update the Cargo.toml file? 
I doubt it, because no modification to Cargo.toml was required to get calculate_pi working 
after adding its m.add_function to the first pymodule

#[pymodule]
fn libdigits_pi(_py: Python<'_>, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(calculate_pi, m)?)?;
    Ok(())
}
*/

/////////////////////////////////////////////////////////////////
//Data types example, 
//from "Using Rust with Python" - "Rust to Python"
// https://www.linkedin.com/learning/using-rust-with-python/rust-to-python
/////////////////////////////////////////////////////////////////
use pyo3::types::PyDict;

//Demonstrate conversion between Rust and Python data types
#[pyfunction]
fn data_types_example(py: Python<'_>) -> PyResult<PyObject>{
	let text: &str = "Hello";
	let integer: i32 = 42;
	let float: f64 = 3.14;		//In the future, don't name variables after keywords, 
	let boolean: bool = true;	//even if the keyword is in another language, if possible
	
	//Create Python dictionary
	let python_dict = PyDict::new(py);
	
	//Insert ley-value pairs
	python_dict.set_item("text", text)?;
	python_dict.set_item("integer", integer)?;
	python_dict.set_item("float", float)?;
	python_dict.set_item("boolean", boolean)?;
	
	//Leftoff: 0:18
}