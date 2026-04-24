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

func main() {
	fmt.Println("Hello from test1")
}

/*
Result:
# example/hello/test0
./test2.go:15:6: main redeclared in this block
	./test1.go:15:6: other declaration of main
*/