use pyo3::prelude::*;

/// Formats the sum of two numbers as string.
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

//Computationally or memory intensive logic? Build it in Rust and then export it to Python

//Calculates an approximation of Pi using the Leibniz formula.
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
