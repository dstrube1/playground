package main

//to run:
//go run hello.go
//to save as executable:
//go build hello.go

//1 import:
//import "fmt"

//multiple imports:
import (
	"fmt"
	"time"
)

func main() {
	//statements are separaated by newlines or ;
	//line cannot begin with {; eg, try commenting out the one above and uncommenting this:
	//{
	fmt.Println("Hello, 世界") //Chinese for "world"
	fmt.Println("The time is", time.Now())
	
	//variables:
	var i int //default: 0
	//Go really doesn't like variables that are declared and not used
	var b bool //default: false
	var f float32 //default: 0
	var s string = "s" //must use ", not '; default: ""
	
	//can declare like one of these:
	//a- var varname type = value
	//b- var varname type
	//c- var varname = value
	//d- varname := value 
	//c & d: go figures out the type
	
	//If you use the type keyword, it is only possible to declare one type of variable per line.
	//If the type keyword is not specified, you can declare different types of variables on the same line:
	//var w, x = 6, "Hello"
	//y, z := 7, "World!"
	
	/*i0 := 1
	b0 := true
	f0 := 2.0
	s0 := "s0"*/
	
	
	fmt.Print("i: ")
	fmt.Println(i)
	//concatenate string with +
	//arguments to Print separated by ,
	fmt.Print("s: " + s, "\n")
	//if not all arguments are string, then Print will insert a space between each
	fmt.Print("Default values of bool and float32: ")
	fmt.Print(b,f)
	//neither Print nor Println require an argument:
	fmt.Println() //good
	fmt.Print() //weird
	
	//constant:
	//const PI = 3.14
	//is it possible to declare a constant with a type and without a value, as long as it's used?	
	/*const PI float32
	fmt.Print("PI: ")		
	fmt.Println(PI)*/
	//no

	//using Printf:
	fmt.Printf("i has value: %v and type: %T\n", i, i)
	fmt.Printf("s has value: %v and type: %T\n", s, s)
	//more: https://www.w3schools.com/go/go_formatting_verbs.php
	
	//more Numerics:
	var u uint64 = 18446744073709551615 //18,446,744,073,709,551,615 =~ 18 quintillion
	fmt.Println("u:", u)
	
	//Arrays
	//with var / =
	var arr0 = [3]int{0,1,2}
	var arr1 = [...]int{1,2,3}
	//with :=
	arr2 := [3]int{2,3,4}
	arr3 := [...]int{3,4,5}
	fmt.Println("arr0:", arr0)
	fmt.Println("arr1:", arr1)
	fmt.Println("arr2:", arr2)
	fmt.Println("arr3:", arr3)
	//element access:
	i = arr1[0]
	fmt.Println("arr1[0]:", i)
	fmt.Println("Length of arr2:", len(arr2))
	
	//Slice, like array, but flexible size
	myslice := []int{} //values are optional; size mustn't be specified
	fmt.Println("Length of myslice:", len(myslice)) //0
	fmt.Println("Capacity of myslice:", cap(myslice)) //0
	
	//LEFTOFF:
	//https://www.w3schools.com/go/go_slices.php
	
}

/*


*/