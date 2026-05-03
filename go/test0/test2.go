package main

/*
from ../hello.go:
//to run:
[...]
go run .
//^assuming this is the only .go file in the directory? or the only one with a main function?

Let's test that assumption
*/

import "fmt"

/*func main() {
	fmt.Println("Hello from test2")
}*/

/*
Result:
# example/hello/test0
./test2.go:15:6: main redeclared in this block
	./test1.go:15:6: other declaration of main
*/

//what if one of the files in the same dir has only non-main function(s)?
func nonMain(){
	fmt.Println("Hello from test2, where there is no main()")
}
//Then this all builds and runs fine (except nonMain is never called so it never runs)