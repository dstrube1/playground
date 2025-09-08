use pyo3::prelude::*;
use pyo3::

/// Formats the sum of two numbers as string.
#[pyfunction]
fn sum_as_string(a: usize, b: usize) -> PyResult<String> {
    Ok((a + b).to_string())
}

#[pyfunction]
fn diff_as_string(a: usize, b: usize) -> PyResult<String> {
    Ok((a - b).to_string())
}

#[pyfunction]
fn product_as_string(a: usize, b: usize) -> PyResult<String> {
    Ok((a * b).to_string())
}

#[pyfunction]
fn quotient_as_string(a: f64, b: f64) -> PyResult<String> {
	// What if b == 0? Raise an error / throw an exception:
	if b == 0.0 {
		//https://www.linkedin.com/learning/using-rust-with-python/pyo3-exceptions
		//Example in the video requires a working pycalc project -_-
		return Err(PyValueError::new_err("Can't divide by zero'"))
		// PyErr::new_instance(PyExc_ValueError,("Invalid value",)).unwrap().raise(py)
	}
    Ok((a / b).to_string())
}

/// A Python module implemented in Rust.
#[pymodule]
fn pycalc(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(sum_as_string, m)?)?;
    m.add_function(wrap_pyfunction!(diff_as_string, m)?)?;
    m.add_function(wrap_pyfunction!(product_as_string, m)?)?;
    m.add_function(wrap_pyfunction!(quotient_as_string, m)?)?;
    Ok(())
}
