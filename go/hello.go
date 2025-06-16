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
	fmt.Println("unsigned 64 bit integer:", u)
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

func timeStuff(){
	fmt.Println("The time is", time.Now())
}

func main() {
	//statements are separaated by newlines or ;
	
	//weird quirk: a line cannot begin with an open bracket, ie, { 
	//eg, try commenting out the one above and uncommenting this:
	//{
	//=>
	//./hello.go:[line number]:[column number]: syntax error: unexpected semicolon or newline before {

	
	//definedAfterMain()
	//variablesAndPrinting()
	//arraysAndSlices()	
	//operators()
	conditionsAndLoops()
	//timeStuff()
	
}

func definedAfterMain(){
	//What if a function is defined after it's called
	fmt.Println("definedAfterMain - this is fine.")
}

/*


*/