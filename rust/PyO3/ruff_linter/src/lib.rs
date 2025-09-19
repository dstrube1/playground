use pyo3::prelude::*;

// https://www.linkedin.com/learning/using-rust-with-python/using-rust-ruff-linter
// ->
// https://github.com/astral-sh/ruff?tab=readme-ov-file
// ->
// https://play.ruff.rs/

/// Formats the sum of two numbers as string.
#[pyfunction]
fn sum_as_string(a: usize, b: usize) -> PyResult<String> {
    Ok((a + b).to_string())
}

/// A Python module implemented in Rust.
#[pymodule]
fn ruff_linter(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(sum_as_string, m)?)?;
    Ok(())
}
