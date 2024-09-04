//https://www.rust-lang.org/learn/get-started

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
	println!("{}", bob.n[0]);
}

fn func_2(bob: &Bob){
	println!("{}", bob.n[0]);
}

fn func_3(bob: &Bob){
	println!("{}", bob.n[1]);
}

/*fn func_4(bob: &mut Bob){
	bob.n = Vec::new();
}*/

fn main() {
	func_1();
}


