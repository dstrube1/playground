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
    //m.add_function(wrap_pyfunction!(data_types_example, m)?)?;
    //See below TODO for this function^
    
    //For Ownership example:
    //m.add_class::NumberList<>()?;
    //errors:
    //error: generic parameters without surrounding angle brackets
    //error: expected `<`
    //m.add_wrapped(wrap_pyfunction!(add_number))?;
    //m.add_wrapped(wrap_pyfunction!(len))?;
    //m.add_wrapped(wrap_pyfunction!(clear))?;
    
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
//use pyo3::types::PyDict;
//use pyo3::wrap_function;

//Demonstrate conversion between Rust and Python data types
/*
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
	
	//Return the Python dictionary
	Ok(python_dict.to_object(py))
	//error[E0599]: no method named `to_object` found for struct `pyo3::Bound<'_, PyDict>` in the current scope

//USAGE:
data_types = [library_project_name].data_types_example()}
print(data_types)

TODO: fix this; maybe it'll build in its own project?

*/
/////////////////////////////////////////////////////////////////
//END Data types example, 
/////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////
//Ownership example
//from "Rust ownership model"
// https://www.linkedin.com/learning/using-rust-with-python/rust-ownership-model
/////////////////////////////////////////////////////////////////
/*
use pyo3::wrap_pyfunction;
use pyo3::pyclass;

//Pyclass macro:
#[pyclass]
struct NumberList{
	numbers: Vec<i32>,
}

//Implementation of the struct / Pyclass macro
impl NumberList{
	fn new() -> Self{
		NumberList{
			numbers: Vec::new(),
		}
	}
	
	fn add_number(&mut self, num: i32){
		self.numbers.push(num);
	}
	
	fn len(&self) -> usize {
		self.numbers.len()
	}
	
	fn clear(&mut self) {
		self.numbers.clear()
	}
}

//In the "Rust ownership model" video, #[pymodule] goes here

#[pyfunction]
fn add_number(list: &mut NumberList, num: i32) -> PyResult<()> {
	list.add_number(num);
	Ok(())
}

#[pyfunction]
fn len(list: &NumberList) -> PyResult<usize> {
	Ok(list.len())
}

#[pyfunction]
fn clear(list: &mut NumberList) -> PyResult<()> {
	list.clear();
	Ok(())
}

//Implementation of NumberList (didn't we already do this above?)
#[pymethods]
impl NumberList{
	#[new]
	fn new_obj() -> Self{
		NumberList::new()
	}
	
	fn add(&mut self, value: i32){
		self.add_number(value);
	}
	
	fn length(&self) -> usize{
		self.len()
	}
	
	fn clear_list(&mut self){
		self.clear();
	}
}
*/

//Another pymodule?!
/*
#[pymodule]
fn ownership(_py: Python, m: &PyModule) -> PyResult<()>{
	m.add_class::<NumberList>()?;
	Ok(())
}
*/

//USAGE:
/*
import libownership_pyrust

print("Creating NumberList")
list_instance = libownership_pyrust.NumberList()
print("Inserting into NumberList")
list_instance.add(5)
list_instance.add(10)
print("Length of NumberList after inserts: ")
print(list_instance.length()) # 2
print("Clearing NumberList")
list_instance.clear()
print("Length of NumberList after clearing: ")
print(list_instance.length()) # 0

*/

//More breakage
//TODO: maybe works in a separate project?
/////////////////////////////////////////////////////////////////
//END Ownership example
/////////////////////////////////////////////////////////////////




















































