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

//Solution: ask ChatGPT to debug, and it gave the answer!

/*
Compiler complains / warns about any unused code -_- which is why I comment out unused functions

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
	
	//println!("{}", bob.n[0]);
	println!("todo: fix func_1...");
}

fn func_2(bob: &Bob){
	//println!("{}", bob.n[0]);
	//println!(bob.n.len());
	println!("todo: fix func_2...");
}

fn func_3(bob: &Bob){
	//println!("{}", bob.n[1]);
	println!("todo: fix func_3...");
}*/

/*fn func_4(bob: &mut Bob){
	bob.n = Vec::new();
}*/

fn main() {
	//func_1();
	basics();
}

fn basics(){
	let a = 1;
	//a = 2;
	//error^:
	//cannot assign twice to immutable variable
	
	//variables are constant by default
	//to make them really *variable*, must use mut
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
	
	//Using if / else as an expression - like ternary operator in other languages (? : );
	//must have an else, and both values must be of the same type:
	let time = 20;
	let greeting = if time < 18 {
		"Good day."
	} else {
		"Good evening."
	};
	//Note, can't just do println!(greeting);
	println!("{}", greeting);
	
	//switch / case /default => match / _:
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
	
	//Like if, match can also return a value:
	let result = match day {
	    1 => "Monday",
	    2 => "Tuesday",
	    3 => "Wednesday",
    _ => "Invalid day.",
	};
	println!("{}", result);
	 
	//leftoff:
	//https://www.w3schools.com/rust/rust_loops.php
}

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
ChatGPT says to uninstall with brew and reinstall with rustup:
1-
brew uninstall rust
2-
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
3- 
(restart terminal, and:)
rustc --version

Gonna do that later as the brew reinstall seems to have worked for now...
*/
