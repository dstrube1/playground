package main //package names should be single word lower case

/*
//to run:
go run hello.go
//or
go run .
//^given that this is the only .go file in the directory with a main function

//to save as executable:
go build hello.go
//executables are OS specific

See also :
https://go.dev/play/
*/

/*
Interesting go commands:
go doc time
	wall clock is for displaying time; monotonic clock is for measuring time
go env
	current version: 1.24.2
go fix
go list
go version
	go version go1.24.2 darwin/amd64
*/

//1 import:
//import "fmt"

//multiple imports:
import (
	"fmt"
	"time"
	"rsc.io/quote" //external package; if running this for the first time, must first run:
	//go mod tidy
	//or 
	//go get rsc.io/quote
	"sort"
	"errors"
)

func unused(){
	//Does Go complain if a func isn't used, like it does with variables?
	//No
}

func variablesAndPrinting(){	
	fmt.Println("Hello, 世界") //Chinese for "world"

	//variables:
	var i int //default: 0
	//Go really doesn't like variables that are declared and not used
	var b bool //default: false
	var f float32 //default: 0
	var s string = "s" //must use ", not '; default: ""
	
	//can declare like one of these:
	//a- var varname [type] = value
	//b- var varname [type]
	//c- var varname = value
	//d- varname := value 
	//c & d: go figures out the type
	
	/*i0 := 1
	b0 := true
	f0 := 2.0
	s0 := "s0"*/
		
	//If you use the keyword for a type (e.g., int), it is only possible to declare one type of variable per line.
	//If the type is not specified, you can declare different types of variables on the same line:
	//var w, x = 6, "Hello"
	//y, z := 7, "World!"
	//Note, format is var varname1, varname2 = value1, value2
	//What about
	//var var1 = 1, var2 = "hey"
	//^: syntax error: unexpected = at end of statement
	//var var1 := 1, var2 := "hey"
	//^: unexpected :=, expected =
	
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
	//no, it must be given an initial value

	//using Printf:
	fmt.Printf("i has value: %v and type: %T\n", i, i)
	fmt.Printf("s has value: %v and type: %T\n", s, s)
	//more: https://www.w3schools.com/go/go_formatting_verbs.php
	
	//more Numerics:
	var u uint64 = 18446744073709551615 //18,446,744,073,709,551,615 =~ 18 quintillion
	fmt.Println("unsigned 64 bit integer:", u)
	//more:
	// uint8 uint16 uint32
	//  int8  int16  int32 int64
	// aliases: 
	// byte => 
	// uint => 32 or 64 bit depending on OS
	// int => 32 or 64 bit depending on OS
	// uintptr => 
	// float64
	// complex64 complex128
	var c64 complex64 //= 12.8i
	fmt.Println("complex64 default value:",c64) //(0+0i)
	c64 = 12.8i
	fmt.Println("complex64 assigned value:",c64) //(0+12.8i)
	var c128 complex128 
	fmt.Println("complex128 default value:",c128) //(0+0i)
	
	fmt.Printf("Value of c64: %v; data type of c64: %T\n", c64, c64)
	
	//The keyword `type` has multiple purposes. One is creating a new named (aka custom) type
	type MyInt int
	var mi MyInt = 1
	fmt.Println("MyInt mi:", mi)

	//Another is Type aliasing:
	type ID = int
	var id ID = 2
	fmt.Println("ID id:", id)
	//Here, ID is exactly the same as int, not a distinct type
	
	//Difference between a type alias and a custom type:
	i = 5
	mi = MyInt(i) //custom: conversion needed
	id = i //alias: no conversion needed
	/*
	Custom types let you:
		Add methods
		Prevent accidental mixing of values
		Make code more expressive
	*/

}

func arraysAndSlices(){
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
	var i = arr1[0]
	fmt.Println("arr1[0]:", i)
	fmt.Println("Length of arr2:", len(arr2))
	//We modify elements in an array
	arr1[0] = 10;
	fmt.Println("arr1 after modification:", arr1)
	
	//Slice, like array, but flexible size
	myslice := []int{} //values are optional; size mustn't be specified
	fmt.Println("Length of myslice:", len(myslice)) //0
	fmt.Println("Capacity of myslice:", cap(myslice)) //0
	
	//what if I try to initialize an array bigger than specified?
	var arr4 = [6]int{0,1,2,3,4,5}//,6} // index 6 is out of bounds (>= 6)
	fmt.Println("arr4:", arr4) 
	//define a slice by slicing an array:
	slic0 := arr4[1:4] //start inclusive, end exclusive
	fmt.Println("slic0:", slic0) //[1 2 3]
	
	//make a slice with make:
	//slice_name := make([]type, length, capacity)
	slic1 := make([]int,5,10)
	fmt.Println("slic1:", slic1) //[0 0 0 0 0]
	fmt.Println("Length of slic1:", len(slic1)) //5
	fmt.Println("Capacity of slic1:", cap(slic1)) //10
	//read and write elements the same way you would an array, via element subscript
	
	//Append to a slice:
	//One or more elements
	slic1 = append(slic1, 1)
	fmt.Println("slic1 after appending element(s):", slic1) //[0 0 0 0 0 1]
	fmt.Println("Length of slic1:", len(slic1)) //6
	fmt.Println("Capacity of slic1:", cap(slic1)) // still 10
	//Append slice to a slice:
	slic1 = append(slic1, slic0...) //must have '...' at the end
	fmt.Println("slic1 after appending slic0:", slic1) //[0 0 0 0 0 1]
	fmt.Println("Length of slic1:", len(slic1)) //6
	fmt.Println("Capacity of slic1:", cap(slic1)) // still 10
	
	//Copy:
	//If the array is large and you need only a few elements, 
	//then it is better to copy those elements using the copy() function.
	numbers := []int{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15}
	// Original slice
	fmt.Printf("numbers = %v\n", numbers)
	fmt.Printf("length = %d\n", len(numbers))
	fmt.Printf("capacity = %d\n", cap(numbers))

	// Create copy with only needed numbers
	neededNumbers := numbers[:len(numbers)-10] //slice / subset of numbers with more capacity than needed
	fmt.Printf("neededNumbers = %v\n", neededNumbers)
	fmt.Printf("length = %d\n", len(neededNumbers))
	fmt.Printf("capacity = %d\n", cap(neededNumbers))

	numbersCopy := make([]int, len(neededNumbers))
	fmt.Printf("numbersCopy, pre-copy = %v\n", numbersCopy)
	fmt.Printf("length = %d\n", len(numbersCopy))
	fmt.Printf("capacity = %d\n", cap(numbersCopy))
	copy(numbersCopy, neededNumbers)

	fmt.Printf("numbersCopy, post-copy = %v\n", numbersCopy)
	fmt.Printf("length = %d\n", len(numbersCopy))
	fmt.Printf("capacity = %d\n", cap(numbersCopy))
}

func operators(){
	//interesting way to declare multiple variables with one var:
	/*var (
		sum1 = 100 + 50 // 150 (100 + 50)
		sum2 = sum1 + 250 // 400 (150 + 250)
		sum3 = sum2 + sum2 // 800 (400 + 400)
	)*/
	
	var s0 = "s0"
	var s1 = "s1"
	var s2 = s0 + s1
	fmt.Println("What about string +?: " + s2)
	
	//Bitwise operator
	var i = 1
	fmt.Println("i before bitwise shift (<<2): ", i)
	i = i << 2
	fmt.Println("i after bitwise shift: ", i)
	fmt.Printf("i after bitwise shift in binary: %b \n", i)
}

func conditionsAndLoops(){
	//If / else if / else
	time := 22
	//Can a one line clause go without {}s? Nope
	//Also, can't have a close bracket on its own line
	if time < 10 {
		fmt.Println("Good morning.")
	} else if time < 20 {
		fmt.Println("Good day.")
	} else {
		fmt.Println("Good evening.")
	}
	
	/**
	//Can primitives be nil? 
	var i = 0
	var b bool //default: false
	var f float32 //default: 0
	var s string = "s" //must use ", not '; default: ""
	if i == nil || b == nil || f == nil || s == nil{
		fmt.Println("Something is nil")
	}else{
		fmt.Println("None of the vars is nil")
	}
	//Apparently no:
	./hello.go:198:10: invalid operation: i == nil (mismatched types int and untyped nil)
	./hello.go:198:22: invalid operation: b == nil (mismatched types bool and untyped nil)
	./hello.go:198:34: invalid operation: f == nil (mismatched types float32 and untyped nil)
	./hello.go:198:46: invalid operation: s == nil (mismatched types string and untyped nil)
	**/
	
	//Switch case 
	//Only executes one case, so break not required / is ignored
	day := 0
	switch day {
	/*
	Multiple case, executes if either value is true; 
	invalid if values are in some other case
	case 1,2:
		fmt.Println("Monday or Tuesday")*/
	case 1:
		fmt.Println("Monday")
	case 2:
		fmt.Println("Tuesday")
	case 3:
		fmt.Println("Wednesday")
	case 4:
		fmt.Println("Thursday")
	case 5:
		fmt.Println("Friday")
	case 6:
		fmt.Println("Saturday")
		break
	default:
		fmt.Println("Sunday")
	}
	
	//For
	//increment with continue
	for i:=0; i < 5; i++{
		if i >= 3 {
			continue
		}
		fmt.Print(i, " ")
	}
	fmt.Println()
	//decrement with break
	for i:=5; i >=0; i--{
		fmt.Print(i, " ")
		if i <= 3 {
			break
		}
	}
	fmt.Println()
	
	//Foreach index and value in array/slice/map:
	arr := [3]string{"a","b","c"}
	for index,value := range arr{ //to ignore index or value, replace it with _
		fmt.Printf("index: %v \t value: %v \n", index, value)
	}
	
	//no while (!?)
	//https://golangdocs.com/while-loop-in-golang
	//for-loop is the while-loop (and while-true and do-while):
	i := 0
	for i < 5{
		i++
		fmt.Print(i, " ")
	}
	fmt.Println()
}

func functionTests(){
	//Functions (defined below this one):
	i0f0 := 1
	i1f0 := 2
	i2f0 := function0(i0f0, i1f0)
	fmt.Println("i2f0:", i2f0)
	
	//Polymorphism:
	//same name (as another unused one) but different signatures
	i0f1 := 1
	i1f1 := 2
	i2f1 := 3
	i3f1 := function1(i0f1, i1f1, i2f1)
	fmt.Println("i3f1:", i3f1)
	
	//Multiple returns
	i4f2, i5f2 := function2(i0f0, i1f0) //returns can be ignored by replacing with _
	fmt.Println("i4f2:", i4f2, "i5f2:", i5f2)
	
	//Recursion
	recurse(1)
	//Why does this start breaking at 21?
	var i uint64
	for i = 1; i < 22; i++{
		fmt.Println(i,"factorial =", factorial(i))
	}

	result0 := compute(add, 2, 3)
	result1 := compute(multiply, 2, 3)
	fmt.Println("result0 =", result0)
	fmt.Println("result1 =", result1)
}

func function0(param0 int, param1 int) int {
	return param0 + param1
}

/*func function1(param0 int, param1 int) (result int) { //named return 
	result = param0 + param1
	return
}*/

//What if same name but different signatures? Error(!) No polymorphism?!
func function1(param0 int, param1 int, param2 int) (result int) { 
	result = param0 + param1 + param2
	return
}

//If same name but different number of returns, 
//then "assignment mismatch: 2 variables but function1 returns 1 value"
//So, no polymorphism here
func function2(param0 int, param1 int) (result int, msg string) { //multiple named returns 
	//values don't have to be set in the same order as their declarations
	msg = "Hey"
	result = param0 + param1
	return //what if return is commented out? error: missing return
}

func recurse(x int) int {
	if x >= 11{
		fmt.Println()
		return 0
	}
	fmt.Print(x," ")
	return recurse(x + 1)
}

func factorial(u uint64) (v uint64){
	if u > 0 {
		v = u * factorial(u-1)
	}else{
		v = 1
	}
	return
}

//Another purpose of `type` is defining custom function types:
type Operation func(a int, b int) int
//example usage:
func add(a,b int) int{
	return a + b
}
func multiply(a,b int) int{
	return a * b
}
func compute(op Operation, a, b int) int{
	return op(a, b)
}

func structs(){
	//The keyword `type` has multiple purposes. One is defining structs:
	type class struct{
		member1 int
		member2 string
	}
	var obj class
	obj.member1 = 1
	obj.member2 = "member2"
	
	fmt.Println("obj.member1:",obj.member1)
	fmt.Println("obj.member2:",obj.member2)
	
	//Another is grouping type declarations
	type (
		User struct {
			Name string
		}
		Product struct {
			Price float64
		}
	)
	//example usage
	var u User
	var p Product
	u.Name = "bob"
	p.Price = 1.5
	fmt.Println("User.Name:", u.Name)
	fmt.Println("Product.Price:", p.Price)
}

func maps(){
	//A map is an unordered and changeable collection that does not allow duplicates.
	//The length of a map is the number of its elements. You can find it using the len() function.
	//The default value of a map is nil.
	
	//Create Maps Using var or :=
	var a = map[int]string{0:"a", 1:"b"}
	b := map[string]int{"a":0, "b":1}
	
	//Using the make() Function:
	var c = make(map[int]string) //these are empty until something is added
	d := make(map[string]int)
	c[0] = "a"
	d["a"] = 0
	
	//does it still throw an error if nothing is done to them? yes
	fmt.Println("a:",a)
	fmt.Println("a[0]:",a[0])
	fmt.Println("b:",b)
	fmt.Println("b[a]:",b["a"])
	
	//the only other way to create an empty map:
	var e map[int]string
	fmt.Println("len(e):",len(e))
	//Note: The make()function is the right way to create an empty map. 
	//If you make an empty map in a different way and write to it, it will causes a runtime panic.
	//e[0] = "a"
	//=>
	//panic: assignment to entry in nil map ...
	
	//difference between declaring an empty map using with the make()function and without it:
	var f = make(map[string]string)
	fmt.Println("e == nil:",e == nil) //true
	fmt.Println("f == nil:",f == nil) //false
	
	/*
	Allowed Key Types:
	any data type for which the equality operator (==) is defined. These include:
Booleans
Numbers
Strings
Arrays
Pointers
Structs
Interfaces (as long as the dynamic type supports equality)

	Invalid key types are:
Slices
Maps
Functions
*/
	//(The map values can be any type.)
	
	//delete element from map:
	delete(a,1)
	fmt.Println("a after delete(a,1):",a)
	
	//check map for value by key:
	value, exists := b["a"]
	fmt.Println("value, exists = b[a]:", value, ",", exists)
	
	//Maps are references to hash tables.
	//If two map variables refer to the same hash table, 
	//changing the content of one variable affect the content of the other.
	
	//Iterate over maps using range:
	fmt.Println("Iterating over b:")
	for k, v := range b {
		fmt.Printf("%v, %v \n", k, v)
	}
	
	//Iterate Over Maps in a Specific Order:
	//must have a separate data structure that specifies the order
	/*
	Hmm, this doesn't illustrate the point as well as it does on w3schools.
	Maybe I need a bigger map...
	numbers := map[string]int{"one": 1, "two": 2, "three": 3, "four": 4}
	var order[]string
	order = append(order,"one", "two", "three", "four")
	//loop with no order:
	fmt.Println("Looping over a map unordered:")
	for k,v := range numbers{
		fmt.Printf("%v, %v, ", k, v)
	}
	fmt.Println()
	fmt.Println("Looping over a map ordered:")
	for _,v := range order{
		fmt.Printf("%v, %v, ", v, numbers[v])
	}
	fmt.Println()
	*/
	var numbers = make(map[int]int)
	var order[]int
	for i:=0; i <= 10; i++{
		numbers[i] = i * 2
		order = append(order,i)
	}
	fmt.Println("numbers:", numbers)
	fmt.Println("Looping over a map unordered:")
	for k,v := range numbers{
		fmt.Printf("[%v:%v] ", k, v)
	}
	fmt.Println()
	fmt.Println("Looping over a map ordered:")
	for _,v := range order{
		fmt.Printf("[%v:%v] ", v, numbers[v])
	}
	fmt.Println()

}

func timeStuff(){
	fmt.Println("The time is", time.Now())
	// See also :
	// go doc time
}

func extPkg(){
	//https://pkg.go.dev/rsc.io/quote
	//from import "rsc.io/quote"
	fmt.Println(quote.Hello())//Hello returns a greeting.
	//"Hello, world."
	fmt.Println(quote.Glass()) //Glass returns a useful phrase for world travelers.
	//"I can eat glass and it doesn't hurt me."
	fmt.Println(quote.Go()) //Go returns a Go proverb.
	//"Don't communicate by sharing memory, share memory by communicating."
	fmt.Println(quote.Opt())//Opt returns an optimization truth.
	//"If a program is too slow, it must have a loop."
}

func largestInt(numbers[]int) int{
	sort.Ints(numbers)
	return numbers[len(numbers)-1] //after sorted, largest is last
}

func testLargestInt(){
	numbers := []int{2,4,6,66,8}
	largest := largestInt(numbers)
	fmt.Println("largest in array:", largest)
}

func divideWithErrorHandling(numerator float32, denominator float32) (float32, error){
	if(denominator == 0){
		err := errors.New("Can't divide by zero")
		//This will also display the error, but fail out of the program ungracefully
		//panic(err)
		//See also recover - manages behavior of a panicking Goroutine / asynchronous processing
		//https://golang.org/pkg/builtin
		//=>
		//https://pkg.go.dev/builtin
		return 0, err
	}
	return (numerator / denominator), nil
}

func testDivideWithErrorHandling(){
	quotient, err := divideWithErrorHandling(1,2)
	if err == nil {
		fmt.Println("1 / 2:", quotient)
	}else{
		fmt.Println("Error",err)
	}
	
	quotient, err = divideWithErrorHandling(1, 0)
	if err == nil {
		fmt.Println("1 / 0:", quotient)
	}else{
		fmt.Println("Error",err)
	}
}

func testInterface(){
	//The keyword `type` has multiple purposes. One is defining an interface
	type Speaker interface {
		Speak() string
	}
	//var speaker Speaker
	/*
	speaker.Speak()
	If try to run an unimplemented method:
	panic: runtime error: invalid memory address or nil pointer dereference
	[signal SIGSEGV: segmentation violation code=0x2 addr=0x0 pc=0x
	
	Just commenting out speaker.Speak() won't fix the problem; must also comment out declaration of unused var speaker
	
	TODO: how to implement Speak()...
	*/
}

func main() {
	//statements are separaated by newlines or ;
	
	//weird quirk: a line cannot begin with an open bracket, ie, { 
	//eg, try commenting out the one above and uncommenting this:
	//{
	//=>
	//./hello.go:[line number]:[column number]: syntax error: unexpected semicolon or newline before {

	
	//0-definedAfterMain()
	
	//1-7: https://www.w3schools.com/go/
	//1-
	//variablesAndPrinting()
	//2-
	//arraysAndSlices()	
	//3-
	//operators()
	//4-
	//conditionsAndLoops()
	//5-
	functionTests()
	//6-
	//structs()
	//7-
	//maps()
	
	//8-
	//timeStuff()
	//9-Call code in an external package¶
	//extPkg()
	
	//testLargestInt()
	//testDivideWithErrorHandling()
	
	//https://go.dev/doc/tutorial/getting-started
	//Enable dependency tracking for your code:
	//go mod init example/hello
	//output:
	//go: creating new go.mod: module example/hello
	//go: to add module requirements and sums:
	//go mod tidy
	
	//TODO:
	//testInterface()
	//Channel
	//Pointer
	
	fmt.Println("Done.")
}

func definedAfterMain(){
	//What if a function is defined after it's called
	fmt.Println("definedAfterMain - this is fine.")
}

/*


*/