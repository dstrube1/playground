//https://www.rust-lang.org/learn/get-started

//to create this:
//cargo new hello-rust

//to build, from hello-rust dir:
//cargo build

//to run:
//cargo run

//https://www.youtube.com/watch?v=pTMvh6VzDls
//17:21
/**/
// 17:54 "And then if I was to compile this func_1 now, it would compile absolutely fine. No issues." 
//False

//...Fixed

/*
Compiler complains / warns about any unused code -_- which is why I comment out unused functions
*/
struct Bob{
	n: Vec<i32>
}
impl Bob{
	fn new() -> Bob {
		Bob { n: Vec::new() }
	}
}

fn func_1(){
	let bob = Bob::new();
	let bob1 = &bob;
	let bob2 = &bob;
	//Can't* do both mutable and immutable, 
	//	(*unless put into a special block that's marked "unsafe"? 22:27)
	//let bob3 = &mut bob;
	func_2(bob1);
	func_3(bob2);
	//func_4(bob3);
	
	//println!(); is a macro
	//macro is like a function but with a "!" and different rules
	if bob.n.len() > 0{
		println!("{}", bob.n[0]);
	}else{
		println!("func_1: bob.n.len()): {}", bob.n.len());
	}
}

fn func_2(bob: &Bob){
	if bob.n.len() > 0{
		println!("{}", bob.n[0]);
	}else{
		println!("func_2: bob.n.len()): {}", bob.n.len());
	}
}

fn func_3(bob: &Bob){
	if bob.n.len() > 1{
		println!("{}", bob.n[1]);
	}else{
		println!("func_3: bob.n.len()): {}", bob.n.len());
	}
}/**/

/*fn func_4(bob: &mut Bob){
	bob.n = Vec::new();
}*/

fn main() {
	func_1();
	basics();
}

fn basics(){
	let a = 1;
	//a = 2;
	//error^:
	//cannot assign twice to immutable variable
	
	//variables are constant by default
	//to make them really *variable* and mutable, must use mut
	let mut b = 1;
	println!("a: {}, b: {}", a, b); //cannot print / use variable before it is assigned
	b = 2;
	println!("new b: {}", b);
	
	/* 
	Declaring variables without specified type:
	
	let my_num = 5;         // integer
	let my_double = 5.99;   // float
	let my_letter = 'D';    // character
	let my_bool = true;     // boolean
	let my_text = "Hello";  // string
	
	Declaring variables with specified type:
	let my_num: i32 = 5;          // integer
	let my_double: f64 = 5.99;    // float
	let my_letter: char = 'D';    // character
	let my_bool: bool = true;     // boolean
	let my_text: &str = "Hello";  // string
	
	Constants:
	What's the difference between a constant and a variable that can't be changed?:
	"Unlike regular variables, constants must be defined with a type"
	Is that it?!
	
	const MINUTES_PER_HOUR: i32 = 60;
	*/
	
	//if / else if / else:
	let score = 85;

	if score >= 90 {
		println!("Grade: A");
	} else if score >= 80 {
		println!("Grade: B");
	} else if score >= 70 {
		println!("Grade: C");
	} else {
		println!("Grade: F");
	}
	
	//Using if / else as an expression (e.g., for assignment) - like ternary operator in other languages (? : );
	//must have an else, and both values must be of the same type:
	let time = 20;
	let greeting = if time < 18 {
		"Good day."
	} else {
		"Good evening."
	}; //must end with ;
	
	//Note, can't just do println!(greeting);
	println!("{}", greeting);
	
	//switch / case /default => match / => / _:
	//no break; only one case executes
	let day = 4;
	match day {
    	1 => println!("Monday"),
	    2 => println!("Tuesday"),
	    3 => println!("Wednesday"),
	    _ => println!("Invalid day."),
	}
	
	//Multiple matches
	match day {
    	1 | 2 | 3 | 4 | 5 => println!("Weekday"),
	    6 | 7 => println!("Weekend"),
	    _ => println!("Invalid day"),
	}
	
	//Similar to `if`, match can also return a value:
	let result = match day {
	    1 => "Monday",
	    2 => "Tuesday",
	    3 => "Wednesday",
	    _ => "Invalid day.",
	};
	println!("{}", result);
	 
	//Loops:
	loop{ //loops forever until broken or Ctrl+C
		if day == 1 {
			continue;//does continue work in a loop? yes
		}
		println!("day : {}", day);
		if day >= 4{ break; }
	}
	
	//loop can also return a value:
	b = loop{
		if day >= 4 {
			break day;
		}
	};
	println!("b after loop : {}", b);
	
	while b >= 0{
		println!("b in while loop : {}", b);
		b -= 1; //no -- or ++
	}
	println!("b after while loop : {}", b); //-1
	
	for b in 1..5{
		println!("b in for loop : {}", b);
	}
	println!("b after for loop : {}", b); //still -1 ?! 
	//explanation: this b is not the same as the b in the for loop
	
	//no need to declare counter for a for loop
	for i in 1..=4{ //`..=` : inclusive
		println!("i in for inclusive loop : {}", i);
	}
	
	println!("function_with_params_and_return0(1,2): {}", function_with_params_and_return0(1,2));
	println!("function_with_params_and_return1(2,3): {}", function_with_params_and_return1(2,3));
	
	//Strings
	let mut s0: &str = "created from s0";
	let mut s1: String = s0.to_string();
	let mut _s2: String = String::from(s0);
	
	s0 = "test";
	
	//this will append to s0
	s1.push_str(": s1"); 
	_s2.push_str(": s");
	
	//append a char
	_s2.push('2'); 
	
	//format!() macro concatenates `String`s and `&str`s
	let _s3 = format!("{} {}", s0, "s3"); 
	
	//Can also concatenate with +, but must use & prefix for any String var; eg:
	//let _s4 = s1 + &_s2;
	/*Note, this line^ gives this error:
	error[E0382]: borrow of moved value: `s1`
	move occurs because `s1` has type `String`, which does not implement the `Copy` trait
	value moved here: let _s4...
	note: this error originates in the macro `$crate::format_args_nl` which comes from the expansion of the macro `println`
	Instead do this:
	*/
	let _s4 = s1.clone() + &_s2;
	//but format!() is generally preferred
	
	//putting a _ at the beginning of an unused variable will suppress the warning about it being unused
	//and the rust compiler won't make a fuss if a used variable starts with _
	
	println!("s0: {}", s0);
	println!("s1: {}", s1);
	println!("s2: {}", _s2);
	println!("length of s2: {}", _s2.len());
	
	//Ownership
	let a0 = String::from("Hi");
	let b0 = a0;
	//This will give a similar error as above for _s4, 
	//because a0 is no longer the owner of the value assigned to it:
	//println!("a0: {}", a0);
	println!("b0: {}", b0);
	//This is only true for complex types; simple types like numbers, characters and booleans are copied, not moved:
	let a1 = 1;
	let b1 = a1;
	println!("a1: {}", a1);
	println!("b1: {}", b1);
	//This is why there is the above call to .clone() fixed the problem
	//Better than cloning is borrowing / reference (&):
	let a2 = String::from("Hi!");
	let b2 = &a2; //b2 is only borrowing; a2 still owns the value
	println!("a2: {}", a2);
	println!("b2: {}", b2);
	//To change a value thru a reference, must make both the source and reference mutable:
	let mut a3 = String::from("Hi there!");
	let b3 = &mut a3;
	b3.push_str(" Hello");
	//error: cannot borrow `a3` as immutable because it is also borrowed as mutable :
	//println!("a3: {}", a3);
	println!("b3: {}", b3);
	//Note: You can only have one mutable reference to a value at a time!

/*
Borrowing helps you reuse values safely, without giving them away.

It lets you use values without taking ownership
It avoids cloning, which can be slow for large data
It makes your programs safer and faster
*/

	
}

//Rust prefers snake case, not like this: functionWithParamsAndReturn0
fn function_with_params_and_return0(a: i32, b: i32) -> i32{
	return a + b;
}

fn function_with_params_and_return1(a: i32, b: i32) -> i32{
	a + b //alternative to using return: no return and no semicolon will return the value of the last line
}

/*leftoff: 
https://www.w3schools.com/rust/rust_data_structures.php
*/

/*

Ran into error when trying to run basic compile commands:
cargo build

=>

error: process didn't exit successfully: rustc -vV (signal: 6, SIGABRT: process abort signal)
--- stderr
dyld[17939]: Symbol not found: (__ZN4llvm10DataLayout5clearEv)
  Referenced from: '/usr/local/Cellar/rust/1.84.0/lib/librustc_driver-bdbb83dedb61a1bb.dylib'
  Expected in: '/usr/local/Cellar/llvm/20.1.6/lib/libLLVM.dylib'
  
Started trying to upgrade with brew, but that's taking all day (as brew usually does).
Possible fix: uninstall with brew and reinstall with rustup:
1-
brew uninstall rust
2-
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
3- 
(restart terminal, and:)
rustc --version

Gonna do that later as the brew reinstall seems to have worked for now...
*/
