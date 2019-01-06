/*
 file:  main.cpp
 project:  0_hello

Created by David Strube on 2018-11-01.
Copyright © 2018 David Strube. All rights reserved.

 If opening on a Mac without Xcode:
 
 g++ main.cpp
 ./a.out
 or (if using cin)
 ./a.out < in.txt
 or
 ./a.out < in.txt > out.txt
 
 https://www.cs.drexel.edu/~mcs171/Sp07/extras/g++/index.html
 */

#include <iostream>
#include <ctime>
//#include "classA.hpp"
//#include "DataTypeSizes.hpp"
//#include "DataTypeInitialValues.hpp"
#include "Maximums.hpp"
//#include "Maths.hpp"

using namespace std;

////////////////////////////////////////////////////////////////////
//method declarations
void strangerThingsS2();
//Pointers and references
void pointerTest();
void passPtrs(int *ptr1, int *ptr2, int *ptrA[], int a[], int size);
int * returnArray();
void referenceTest();
void refAsParam(int & a);
int & returnRef();
int & returnRef0();

//Time and streams
void timeTest();
void streamTest();
////////////////////////////////////////////////////////////////////

//These are useful for multithreading from main:
//#define NUM_THREADS 1
//volatile bool waiting;

int main(int argc, const char * argv[]) {
//    pointerTest();
//    referenceTest();
//    timeTest();
    streamTest();
    
    /* MISC:
     //cout << "??="; //this outputs: warning: trigraph ignored [-Wtrigraphs]

     //print alarm
     for (a = 0; a < 2; a++){
     cout << '\a';
     }

     long myLong = 1;
     typeof(myLong) x = 0;
     cout << "typeof(myLong) x : " << x << endl;

     //for char, '',"", and 0 all print as blank
     
     //END MISC */
    //cout<<"running from main" << endl;
//    classA myClassA;
//    myClassA.myMethod();

//    DataTypeSizes sizes;
//    sizes.run();
    
//    DataTypeInitialValues values;
//    values.run();
    
    //Maximums maximums;
//    maximums.charMaximums();
//    maximums.shortMaximums();
//    bool isFast = true;
//    maximums.intMaximums(isFast);
//    isFast = false;
//    maximums.intMaximums(isFast);
//    maximums.multiThreadedIntMax();
//    maximums.longMaximums();
//    maximums.floatMaximums();
//    maximums.doubleMaximums();
    //maximums.longDoubleMaximums();

//    Maths maths;
//    maths.tests();
//    maths.intLongOverflows();

    return 0;
}

void strangerThingsS2(){
        cout<<"Stranger Things, S2: "<<endl;
        for (int i = 0; i <= 9; i++){
            for (int j = 0; j <= 9; j++){
                for (int k = 0; k <= 9; k++){
                    for (int k0 = 0; k0 <= 9; k0++){
                        cout<<i<<j<<k<<k0<<endl;
                    }
                }
            }
        }
        cout<<"Stranger Things, S2 ^"<<endl;
}

void pointerTest(){
    //with non-array:
    int * p;
    int j = 10;
    p = & j;
    cout<< "j = " << * p << endl;
    
    int * null = NULL;
    cout<< "null=" << null << endl; // 0x0
    //if we tried to print *null, get this error at runtime: Segmentation fault: 11
    //cout<< "*null=" << *null << endl;
    //nothing special here, just the address of the null pointer variable, not the null value (which causes segmentation fault)
    //cout<< "&null=" << &null << endl; // 0x0
    
    //with array:
    const int SIZE = 3;
    int var[SIZE] = {2,4,6};
    //this says "I am a pointer, give me something to point to"
    //note, it's not good to declare and define a pointer on the same line like this, as explained below
    int * ptr = var;
    
    for (int i = 0; i < SIZE; i++){
        cout<< "var[" << i << "]=" << var[i] << endl;
        //this says "here's not what I am, but what I point to."
        cout<< "* ptr=" << * ptr << endl;
        ptr++;
    }
    cout<< "* ptr=" << * ptr << endl;
    ptr--;
    cout<< "* ptr=" << * ptr << endl;
    
    cout<< "* var: " << * var << endl;
    *var = 0;
    cout<< "* var: " << * var << endl;
    for (int i = 0; i < SIZE; i++){
        cout<< "var[" << i << "]=" << var[i] << endl; //prints 0 4 6
    }
    
    //this resets ptr back to the beginning of var;
    //this is why it's a good idea to not assign pointer on the same line as declaring it-
    //it confuses the assignment / declaration syntax
    ptr = var;
    cout<< "*ptr=" << * ptr << endl;
    
    //neat indexed assignment trick, assigns last item
    cout<< "neat indexed assignment trick:" << endl;
    *(var + (SIZE - 1)) = 8;
    for (int i = 0; i < SIZE; i++){
        cout<< "var[" << i << "]=" << var[i] << endl; //prints 0 4 8
    }
    
    //array of pointers
    cout<< "array of pointers test:" << endl;
    int * ptrA[SIZE];
    for (int i = 0; i < SIZE; i++){
        ptrA[i] = & var[i];//assign the address of the int
    }
    for (int i = 0; i < SIZE; i++){
        cout<< "var[" << i << "]=" << * ptrA[i] << endl; //prints 0 4 8
    }
    
    //which leads us to an array of char*, aka string
    /*
     cout<< "char* test:" << endl;
     char *strings[SIZE] = {"string 1","string 2","string 3"};
     for (int i = 0; i < SIZE; i++){
     cout<< "strings[" << i << "]=" << strings[i] << endl; //prints 0 4 8
     }
     //BUT this is deprecated (and throws compiler warning), so leaving it out for now
     */
    
    //huh! string no longer requires its own include
    string s = "s1";
    cout<< "string s=" << s << endl; //prints 0 4 8
    
    passPtrs(& j, p, ptrA, var, SIZE);
    //can't do this: int a[] = returnArray();
    //must do this:
    int * a = returnArray();
    //printing something out with int * a so the compiler doesn't whine about it being unused
    cout << "int * a = returnArray() : " << a << endl;
    cout << "a[0] : " << a[0] << endl;
    a[0] = 2;
    cout << "a[0] = 2 : " << a[0] << endl;
    a = returnArray();
    cout << "a = returnArray() : " << a << endl;
    cout << "a[0] : " << a[0] << endl;
}

void passPtrs(int * ptr1, int * ptr2, int * ptrA[], int a[], int size){
}

int * returnPtr0(){//return int pointer
    int j = 0;
    int * p;
    p = & j;
    return p;
}

int * returnArray(){//return array- looks a lot like returning a pointer
    //should be static because:
    //C++ does not advocate to return the address of a local variable to outside of the function
    static int a[3];
    a[0] = 1;
    a[1] = 2;
    a[2] = 3;
    return a;
}

int * returnPtrA(){//return array of pointers
    int * ptrA[0];
    return * ptrA; //must have * here; using static won't help
}

void referenceTest(){
    //reference must not be null, and must be defined upon declaration,
    //and cannot be reassigned
    int i = 0;
    //int & r = r; //won't throw an error, but will throw a warning,
    //and trying to print it will cause Segmentation fault
    int & r = i;
    r = r; //this is fine;
    //int & b = b;//this will throw a warning,
    //but the subsequent (and presumably illegal but apparently legal)
    //assignment on the next line
    //to r makes it not crash at runtime; interesting
    //b = r;
    cout << "i = " << i << endl;
    cout << "r = " << r << endl;
    //cout << "b = " << b << endl;
    
    refAsParam(i);
    cout << "i after refAsParam = " << i << endl;
    
    r = returnRef();
    cout << "r after returnRef = " << r << endl;
}

void refAsParam(int & a){
    a = 1;
}

int & returnRef(){
    int j = 2; //compiler throws warning without static here
    static int & i = j; //or here
    return i;
}

int & returnRef0(){
    static int j = 2; //interesting- don't have to declare variable as reference
    //in order to return it as a reference but you do have to declare it as static
    return j;
}

void timeTest(){
    //four time-related types:
    //clock_t,
    //time_t,
    //size_t,
    //and tm
    
    time_t now = time(0);
    cout << "now : " << now << endl;
    
    string nows = ctime(&now);
    cout << "now string : " << nows << endl;
    
    tm *gmtm = gmtime(&now);
    nows = asctime(gmtm);
    cout << "now string GMT : " << nows << endl;
    
    const time_t * t0 = & now;
    tm * local_time = localtime(t0); //"Segmentation fault" if t0 isn't assigned
    //or assigned to NULL
    //    cout << "local_time : " << * local_time << endl; // LONG error
    //    cout << "local_time : " << local_time << endl; // memory location?
    //    cout << "local_time : " << & local_time << endl; // memory location?
    cout << "local_time hour : " << local_time->tm_hour << endl; //
}

void streamTest(){
    char s[] = "this is a character array not needing a size.";
    cout << s << endl;
    
    char input[0];
    cout << "Enter some text: " ;
    cin >> input; //this will expand larger as needed
    cout << "You entered: " << input << "." << endl;
    
    //TODO: fstream
}
