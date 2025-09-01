use pyo3::prelude::*;

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
fn quotient_as_string(a: usize, b: usize) -> PyResult<String> {
	//TODO: What if b == 0?
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
