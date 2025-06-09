//from:
// https://www.linkedin.com/posts/maximusalee_i-understand-how-this-syntax-might-seem-a-activity-7332897534740234241-MDFR?utm_source=share&utm_medium=member_desktop&rcm=ACoAABWrXXEBXv5TVBPwYgjKWp_vQytpw9guOpk

//to build, from sudoku dir:
//cargo build

/*
TODO:
error: process didn't exit successfully: `rustc -vV` (signal: 6, SIGABRT: process abort signal)
--- stderr
dyld[6584]: Symbol not found: (__ZN4llvm10DataLayout5clearEv)
  Referenced from: '/usr/local/Cellar/rust/1.84.0/lib/librustc_driver-bdbb83dedb61a1bb.dylib'
  Expected in: '/usr/local/Cellar/llvm/20.1.3/lib/libLLVM.dylib'
*/

//to run:
//cargo run

use std::collections::HashSet;

impl Solution{
	pub fun is_valid_sudoku(board: Vec<Vec<char>>) - bool {
		//Using a mutable hashset: if we run into duplicates, return false
		let mut rowcheck_hs : HashSet<&char> = HashSet::with_capacity(10);
		let mut squares : Vec<HashSet::<&char>> = vec![HashSet::with_capacity(10); 9];
		let mut cols : Vec<HashSet::<&char>> = vec![HashSet::with_capacity(10); 9];
		for (r_idx, row) in board.iter().enumerate(){
			for (s_idx, rowcol_value) in row.iter().enumerate(){
				let sq_idx = (r_idx / 3) * 3 + (s_idx / 3);
				if *rowcol_value != '.' {
					if !rowcheck_hs.insert(rowcol_value){	
						return false;
					}
					if !squares[sq_idx].insert(rowcol_value){
						return false;
					}
					if !cols[s_idx].insert(rowcol_value){
						return false;
					}
				}
			}
			rowcheck_hs.clear();
		}
		true
	}
}

fn main() {
    println!("Hello, world!");
}
