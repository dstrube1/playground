package main

/*
to run:
go run .
*/

import "fmt"

//Exploring how type interacts with methods and receivers:

//////////////////////////////////////////////////////////
//Methods on a struct
type Person struct{
	Name string
}

func (p Person) Greet() string{ //p Person is the receiver
	return "Hello, " + p.Name
}

func (p Person) RenameFalse(newName string){
	p.Name = newName
	//passing by value (aka value receiver) does not persist
}

func (p *Person) RenameTrue(newName string){
	p.Name = newName
	//pointer receiver modifies the original
}
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
//Methods on a custom type
type MyInt int
func (m MyInt) DoubleMyInt() int{
	return int(m) * 2
}
//Receiver must be a custom type, can't be a native ("non-local") type
//For example, this doesn't work:
/*func (i int) DoubleInt() int{
	return i * 2
}*/
//////////////////////////////////////////////////////////

//Mixing value and pointer receivers + interfaces
//Whether a type satisfies an interface depends on its method set, 
//and that changes based on value vs pointer receivers.
//1: an interface
type Renamer interface {
    RenameTrue(newName string)
}
//2: a struct with a pointer receiver
//defined above:
//type Person struct{ ... 
//func (p *Person) RenameTrue(newName string){...

func main() {
	p := Person{Name: "David"}
	fmt.Println(p.Greet())
	
	fmt.Println("Trying rename via value receiver:")
	p.RenameFalse("Bob")
	fmt.Println(p.Greet())
	
	fmt.Println("Trying rename via pointer receiver:")
	p.RenameTrue("Bob")
	//Note, Go automatically replaces this ^ with this:
	//(&p).RenameTrue("Bob")
	//aka automatic address taking
	
	fmt.Println(p.Greet())

	var x MyInt = 5
	fmt.Println("Method on a custom type:", x.DoubleMyInt())
	
	//From "Mixing value and pointer receivers + interfaces":
	//3: Use it
	var r Renamer
	//Already declared above:
	//p := Person{Name: "David"}
	
	//r = p //Error: cannot use p (variable of struct type Person) as Renamer value in 
	//assignment: Person does not implement Renamer (method RenameTrue has pointer receiver)
	r = &p// This compiles and works
	r.RenameTrue("Jack")
	fmt.Println("Renamer worked?:",p.Greet())
	/*
	Person (value) has:
		methods with value receivers only
	*Person (pointer) has:
		methods with value receivers AND pointer receivers
	*/

	fmt.Println("Done")
}

