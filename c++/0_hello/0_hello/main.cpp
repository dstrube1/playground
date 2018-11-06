/*
  main.cpp
  0_hello

  Created by David Strube on 2018-11-01.
  Copyright © 2018 David Strube. All rights reserved.

 If opening without Xcode:
 
 g++ 0_hello.cpp
 ./a.out
 or (if using cin)
 ./a.out < in.txt
 or
 ./a.out < in.txt > out.txt
 
 https://www.cs.drexel.edu/~mcs171/Sp07/extras/g++/index.html
 */

#include <iostream>
#include <pthread.h>
//#include <cstdlib>
#include <cmath>
#include <ctime>

using namespace std;

////////////////////////////////////////////////////////////////////
//method declarations
//Maths and datatypes:
void mathsTest();
void sizes();
void initialValues();

void maximums();
void charMaximums();
void shortMaximums();
void intMaximums();
void intLongOverflow();
void multiThreadedIntMax();
void *threadedPrintDots(void *threadid);
void longMaximums();
long getLongMaxEstimate();
bool recursiveLongMaxFinder(long candidate, int factor);
bool recursiveLongMaxFinderAdd(long candidate, long addend);
unsigned long long getUnsignedLongLongMaxEstimate();
bool recursiveUnsignedLongLongMaxFinder(unsigned long long ull, int factor);
bool recursiveUnsignedLongLongMaxFinderAdd(unsigned long long ull, unsigned long long addend);
uint64_t getUint64MaxEstimate();

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


////////////////////////////////////////////////////////////////////
//variable declarations
//https://en.cppreference.com/w/cpp/language/types
bool boolean;
//signed bool sb; //invalid

char character;
signed char signed_char;
unsigned char unsigned_char;

short shorty;
signed short signed_short;
unsigned short unsigned_short;

int integer;
signed int signed_int;
unsigned int unsigned_int;

long loong;
signed long signed_long;
unsigned long unsigned_long;

float floaty;
//signed float sf;//invalid
//unsigned float uf;//invalid

double dooble;
//signed double sd;//invalid
//unsigned double ud;//invalid
long double long_double;

//void v; //error: variable has incomplete type 'void'

wchar_t wchar;
signed wchar_t signed_wchar;
unsigned wchar_t unsigned_wchar;

long long long_long;
int long int_long;
long int long_int;
//long long long lll;//invalid
signed long long signed_long_long;
signed int long signed_int_long;
signed long int signed_long_int;
unsigned long long unsigned_long_long;
unsigned int long unsigned_int_long;
unsigned long int unsigned_long_int;

//short long shl;//invalid
//long short lsh;//invalid
short int short_int;
int short int_short;
signed short int signed_short_int;
signed int short signed_int_short;
unsigned short int unsigned_short_int;
unsigned int short unsigned_int_short;

//modulus values for printing progress of data type ranges
//const int CHAR_MOD = 10;
//const int SHORT_MOD = 1000;
//const int INT_MOD = 10000000;
//preprocessor, no specific type
#define CHAR_MOD 10
#define SHORT_MOD 1000 //1,000
#define INT_MOD 100000000 //100,000,000
//TODO #define LONG_MOD 1000000000 //1,000,000,000

#define NUM_THREADS 1
volatile bool waiting;
////////////////////////////////////////////////////////////////////

int main(int argc, const char * argv[]) {
//    std::cout << "Hello, World!\n";
    //int a = 0;
    //int _1 = 1;
    //cin >> a;
    //cout << "Hello " << a << "!\n";
    
    //cout << "??="; //this outputs: warning: trigraph ignored [-Wtrigraphs]
    
    //more info: https://www.tutorialspoint.com/cplusplus/cpp_data_types.htm
    //    mathsTest();
//        sizes();
//        initialValues();
    
//    maximums();

    //    pointerTest();
//    referenceTest();
//    timeTest();
//    streamTest();
    
    /* MISC:
     //print alarm
     for (a = 0; a < 2; a++){
     cout << '\a';
     }

     long myLong = 1;
     typeof(myLong) x = 0;
     cout << "typeof(myLong) x : " << x << endl;

     */
    return 0;
}

void mathsTest(){
    cout<< "pow(0,0): " << pow(0,0) << "\n"; //0^0 = 1
    cout<< "1/0: " << (1/(pow(0,0)-1)) << "\n"; //1/0 = inf; done this way to avoid "division by zero" warning
    cout<< "pow(0,-1): " << pow(0,-1) << "\n"; // 0^-1 = 1/(0^1) = inf
    cout<< "hypot(4,3): " << hypot(4,3) << "\n"; //5
    cout<< "hypot(4,1): " << hypot(4,1) << "\n"; //4.something
    cout<< "sqrt(-1): " << sqrt(-1) << "\n\n"; //nan
    
    cout<< "time( NULL ): " << time( NULL ) << "\n";
    cout<< "(unsigned)time( NULL ): " << (unsigned)time( NULL ) << "\n";
    srand( (unsigned)time( NULL ) );
    cout<< "rand(): " << rand() << "\n";
    
}

void sizes(){
    /////////////////////////////////////////////////////////////////////////////////
    //tests of type Sizes
    /////////////////////////////////////////////////////////////////////////////////
    uint64_t uint64;
//    cout << "sizeof(bool): " << sizeof(boolean) << "\n\n";                          //1
//    cout << "sizeof(char): " << sizeof(character) << "\n";                          //1
//    cout << "sizeof(signed char): " << sizeof(signed_char) << "\n";                 //1
//    cout << "sizeof(unsigned char): " << sizeof(unsigned_char) << "\n\n";           //1
//    cout << "sizeof(short): " << sizeof(shorty) << "\n";                            //2
//    cout << "sizeof(signed short): " << sizeof(signed_short) << "\n";               //2
//    cout << "sizeof(unsigned short): " << sizeof(unsigned_short) << "\n\n";         //2
    cout << "sizeof(int): " << sizeof(integer) << "\n";                             //4
//    cout << "sizeof(signed int): " << sizeof(signed_int) << "\n";                   //4
//    cout << "sizeof(unsigned int): " << sizeof(unsigned_int) << "\n\n";             //4
    cout << "sizeof(long): " << sizeof(loong) << "\n";                              //8
//    cout << "sizeof(signed long): " << sizeof(signed_long) << "\n";                 //8
//    cout << "sizeof(unsigned long): " << sizeof(unsigned_long) << "\n\n";           //8
//    cout << "sizeof(float): " << sizeof(floaty) << "\n\n";                          //4
//    cout << "sizeof(double): " << sizeof(dooble) << "\n";                           //8
//    cout << "sizeof(long double): " << sizeof(long_double) << "\n\n";               //16
//    cout << "sizeof(wchar_t): " << sizeof(wchar) << "\n";                           //4
//    cout << "sizeof(signed wchar_t): " << sizeof(signed_wchar) << "\n";             //4
//    cout << "sizeof(unsigned wchar_t): " << sizeof(unsigned_wchar) << "\n\n";       //4
    cout << "sizeof(long long): " << sizeof(long_long) << "\n";                     //8
    cout << "sizeof(int long): " << sizeof(int_long) << "\n";                       //8
    cout << "sizeof(long int): " << sizeof(long_int) << "\n";                       //8
    cout << "sizeof(signed long long): " << sizeof(signed_long_long) << "\n";       //8
    cout << "sizeof(signed int long): " << sizeof(signed_int_long) << "\n";         //8
    cout << "sizeof(signed long int): " << sizeof(signed_long_int) << "\n";         //8
    cout << "sizeof(unsigned long long): " << sizeof(unsigned_long_long) << "\n";   //8
    cout << "sizeof(unsigned int long): " << sizeof(unsigned_int_long) << "\n";     //8
    cout << "sizeof(unsigned long int): " << sizeof(unsigned_long_int) << "\n\n";   //8
//    cout << "sizeof(short int): " << sizeof(short_int) << "\n";                     //2
//    cout << "sizeof(int short): " << sizeof(int_short) << "\n";                     //2
//    cout << "sizeof(signed short int): " << sizeof(signed_short_int) << "\n";       //2
//    cout << "sizeof(signed int short): " << sizeof(signed_int_short) << "\n";       //2
//    cout << "sizeof(unsigned short int): " << sizeof(unsigned_short_int) << "\n";   //2
//    cout << "sizeof(unsigned int short): " << sizeof(unsigned_int_short) << "\n\n"; //2
    cout << "sizeof(uint64): " << sizeof(uint64) << "\n";                           //8
    
    cout << "/////////////////////////////////////////////////////////////////////////////////\n\n";
}

void initialValues(){
    /////////////////////////////////////////////////////////////////////////////////
    //Initial values
    /////////////////////////////////////////////////////////////////////////////////
    uint64_t uint64;
    //0*: non-zero if declared outside main and called inside main;
    //if declared outside and called from outside main, 0
    
    //be careful about declaring methods (before main) before calling them
    
//    cout << "initial value of bool: " << boolean << "\n\n";                        //0
//    cout << "initial value of char: " << character << "\n";                        //0*
//    cout << "initial value of signed char: " << signed_char << "\n";               //0*
//    cout << "initial value of unsigned char: " << unsigned_char << "\n\n";         //0*
//    cout << "initial value of short: " << shorty << "\n";                          //0
//    cout << "initial value of signed short: " << signed_short << "\n";             //0
//    cout << "initial value of unsigned short: " << unsigned_short << "\n\n";       //0
//    cout << "initial value of int: " << integer << "\n";                           //0
//    cout << "initial value of signed int: " << signed_int << "\n";                 //0
//    cout << "initial value of unsigned int: " << unsigned_int << "\n\n";           //0
//    cout << "initial value of long: " << loong << "\n";                            //0
//    cout << "initial value of signed long: " << signed_long << "\n";               //0
    cout << "initial value of unsigned long: " << unsigned_long << "\n\n";         //0*
    cout << "initial value of float: " << floaty << "\n\n";                        //0*
    cout << "initial value of double: " << dooble << "\n\n";                       //0*
    cout << "initial value of wchar_t: " << wchar << "\n";                         //0*
    cout << "initial value of signed wchar_t: " << signed_wchar << "\n";           //0*
    cout << "initial value of unsigned wchar_t: " << unsigned_wchar << "\n\n";     //0*
    cout << "initial value of long long: " << long_long << "\n";                   //0*
    cout << "initial value of int long: " << int_long << "\n";                     //0*
    cout << "initial value of long int: " << long_int << "\n";                     //0*
    cout << "initial value of signed long long: " << signed_long_long << "\n";     //0*
    cout << "initial value of signed int long: " << signed_int_long << "\n";       //0*
    cout << "initial value of signed long int: " << signed_long_int << "\n";       //0*
    cout << "initial value of unsigned long long: " << unsigned_long_long << "\n"; //0*
    cout << "initial value of unsigned int long: " << unsigned_int_long << "\n";   //0*
    cout << "initial value of unsigned long int: " << unsigned_long_int << "\n";   //0*
    cout << "initial value of uint64: " << uint64 << "\n\n";                       //0 -- warning because not initialized
    cout << "/////////////////////////////////////////////////////////////////////////////////\n\n";
}

void maximums(){
    
    //for char, '',"", and 0 all print as blank
    
     charMaximums();
    
     shortMaximums();
     
     intMaximums();

    longMaximums();
    
    getUint64MaxEstimate();
}

void charMaximums(){
    char c_p = character;
    signed char sc_p = signed_char;
    unsigned char uc_p = unsigned_char;
    
    int count = 0;
    character++;
    while (c_p < character){
        c_p++;
        character++;
        count++;
        if (count % CHAR_MOD == 0) cout << ".";
    }
    cout << "\nEnd of char range. count = " << count << "\n"; //127
    
    count = 0;
    signed_char++;
    while (sc_p < signed_char){
        sc_p++;
        signed_char++;
        count++;
        if (count % CHAR_MOD == 0) cout << ".";
    }
    cout << "\nEnd of signed char range. count = " << count << "\n"; //127
    
    count = 0;
    unsigned_char++;
    while (uc_p < unsigned_char){
        uc_p++;
        unsigned_char++;
        count++;
        if (count % CHAR_MOD == 0) cout << ".";
    }
    cout << "\nEnd of unsigned char range. count = " << count << "\n"; //255
}

void shortMaximums(){
    short s_p = shorty;
    signed short ss_p = signed_short;
    unsigned short us_p = unsigned_short;
    
    int count = 0;
    shorty++;
    while (s_p < shorty){
        s_p++;
        shorty++;
        count++;
        if (count % SHORT_MOD == 0) cout << ".";
    }
    cout << "\nEnd of short range. count = " << count << "\n"; //32,767
    
    count = 0;
    signed_short++;
    while (ss_p < signed_short){
        ss_p++;
        signed_short++;
        count++;
        if (count % SHORT_MOD == 0) cout << ".";
    }
    cout << "\nEnd of signed short range. count = " << count << "\n"; //32,767
    
    count = 0;
    unsigned_short++;
    while (us_p < unsigned_short){
        us_p++;
        unsigned_short++;
        count++;
        if (count % SHORT_MOD == 0) cout << ".";
    }
    cout << "\nEnd of unsigned short range. count = " << count << "\n"; //65,535
}

void intMaximums(){
    long count = 0;
    
    int i_p = integer;
    
    cout << "Calculating int range";
    integer++;
    while (i_p < integer){
        i_p++;
        integer++;
        count++;
        //this should update the program in realtime, but instead
        //this halts the program until the while loop is done.
        //        if (count % INT_MOD == 0) cout << ".";
        //that's because cout is buffered;
        //solution: cerr is not buffered:
        if (count % INT_MOD == 0) cerr << ".";
    }
    cout << "\nEnd of int range. count = " << count << "\n"; //2,147,483,647
    
    cout << "Calculating signed int range";
    count = 0;
    signed int si_p = signed_int;
    signed_int++;
    while (si_p < signed_int){
        si_p++;
        signed_int++;
        count++;
        if (count % INT_MOD == 0) cout << ".";
    }
    cout << "End of signed int range. count = " << count << "\n"; //2,147,483,647 - about 2 billion
    
    cout << "Calculating unsigned int range";
    count = 0;
    unsigned int ui_p = unsigned_int;
    unsigned_int++;
    while (ui_p < unsigned_int){
        ui_p++;
        unsigned_int++;
        count++;
        if (count % INT_MOD == 0) cout << ".";
    }
    cout << "End of unsigned int range. count = " << count << "\n\n"; //4,294,967,295 - about 4 billion
    
    multiThreadedIntMax();
}

void intLongOverflow(){
    //Testing overflow between int and long - part 1
    int itemp = 1;
    int ltemp = 2147483647;                     //int max
    int itemp0 = itemp + ltemp;                 //overflow
    cout << "itemp0 = " << itemp0 << endl;
    long ltemp0 = itemp + ltemp;                //just fine IF ltemp is declared as a long; else, still overflows
    cout << "ltemp0 = " << ltemp0 << endl;
    itemp0--;                                   //back within range
    cout << "itemp0 - 1 = " << itemp0 << endl;
    itemp0++;                                   //back out of range
    cout << "itemp0 + 1 = " << itemp0 << endl;
    itemp0 /= 10;                               //can't get back into range this way
    cout << "itemp0 / 10 = " << itemp0 << endl;
    
    //Testing overflow between int and long - part 2
    int ifactor = 10;
    int imax = 2147483647;                     //int max
    int iproduct = ifactor * imax;
    long lproduct = ifactor * imax;
    cout << "int iproduct = int ifactor (10) * int imax (2147483647) = " << iproduct << endl; //-10, weird, but ok
    cout << "long lproduct = int ifactor * int imax = " << lproduct << endl; //-10; wtf?
    long limax = imax;
    long lifactor = ifactor;
    lproduct = limax * lifactor;    //long * long
    cout << "lproduct = long limax * long lifactor = " << lproduct << endl; //21474836470, good
    lproduct = limax * ifactor;     //long * int
    cout << "lproduct = long limax * int ifactor = " << lproduct << endl; //21474836470, good
    
    //Overflow illustrated:
    unsigned int uint = 4294967295;
    cout << "uint: " << uint << endl;
    uint++;
    cout << "uint: " << uint << endl;
    
    unsigned long long ull = 18446744073709551615ULL; //ULL suffix required for unsigned long long literal
    cout << "ull: " << ull << endl;
    ull++;
    cout << "ull: " << ull << endl;
    cout << "Done"<< endl;

}

void multiThreadedIntMax(){
    //https://www.tutorialspoint.com/cplusplus/cpp_multithreading.htm
    unsigned long long count;
    waiting = true;
    pthread_t threads[NUM_THREADS];
    pthread_attr_t attr;
    void *status;
    
    // Initialize and set thread joinable
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
    
    int rc = pthread_create(&threads[0], &attr, threadedPrintDots, (void *)0);
    
    if (rc){
        cout << "Error:unable to create thread," << rc << endl;
        exit(-1);
    }
    
    count = 0;
    cout << "Calculating a maximum with multithreading." << endl;
    cout << "(# is the main thread waiting)" << endl;
    while(waiting){
        count++;
        if (count % INT_MOD == 0) cerr << "#";
    }
    
    // free attribute and wait for the other threads
    pthread_attr_destroy(&attr);
    
    rc = pthread_join(threads[0], &status);
    
    if (rc){
        cout << "Error:unable to join," << rc << endl;
        exit(-1);
    }
    
    cout << "Joined thread." << endl;
    //Forgot what this is supposed to do:
    //pthread_exit(NULL);
}

void *threadedPrintDots(void *threadid) {
    long threadID = (long)threadid;
    cout << "Beginning thread " << threadID << endl;
    
    unsigned long long count = 0;
    
    int i_p = integer;
//    signed int si_p = signed_int;
//    unsigned int ui_p = unsigned_int;
    
    integer++;
    while (i_p < integer){
        i_p++;
        integer++;
        count++;
        //this should update the program in realtime, but instead
        //this halts the program until the while loop is done.
        //        if (count % INT_MOD == 0) cout << ".";
        //that's because cout is buffered;
        //solution: cerr is not buffered:
        if (count % INT_MOD == 0) cerr << ".";
    }
    cout << "\nEnd of int range. count = " << count << "\n"; //2,147,483,647
    
    waiting = false;
    
    cout << "Exiting thread " << threadID << endl;
    pthread_exit(NULL);
//    cout << "Exited thread " << threadID << endl; //this doesn't print; thread's dead, baby
}

void longMaximums(){
    cout << "long max approximately = " << getLongMaxEstimate() << "\n";

    cout << "Recursively calculating long range...\n";
    recursiveLongMaxFinder(1,10);
    
    cout << "calculating unsigned long long max estimate : \n";
    recursiveUnsignedLongLongMaxFinder(1,10);
}

long getLongMaxEstimate(){
    //Brute force counting one increment at a time is acceptable for determining the maximum of ints and shorts, but not longs.
    //This method estimates the range of the data type long, and does so with a multiplying loop, and not with brute force.
    //This won't get us the exact number, but it will get us in the ballpark with the order of magnitude, assuming overflow behaves as expected.
    long myLong = 1;
    long ltemp = myLong;
    while (ltemp > 0){ //when ltemp exceeds the maximum, it loops around to a negative
        myLong = ltemp;
        ltemp *= 10;
        //cout << "long max guess = " << myLong << "\n";
    }
    return myLong; //1,000,000,000,000,000,000 : 1 quintillion
}

bool recursiveLongMaxFinder(long candidate, int factor){
    //This method finds the range of the data type long, and does so recursively, and not with brute force
    //    because calculating with brute force would take too *long* (ha!)
    if (factor < 2){
        if (candidate < 0){
            cout << "something went wrong; candidate is " << candidate << endl;
            return false;
        }else{
            //cout << "Narrowed down to factor " << factor << " and candidate is " << candidate << endl;
            long estimate = getLongMaxEstimate();
            return recursiveLongMaxFinderAdd(candidate, estimate);
        }
    }
    long product = candidate * factor;
    if (product > 0){
        return recursiveLongMaxFinder(product, factor);
    }
    else{
        return recursiveLongMaxFinder(candidate, factor-1);
    }
}

bool recursiveLongMaxFinderAdd(long candidate, long addend){
    if (addend == 1){
        if (candidate < 0){
            cout << "something went wrong; candidate is " << candidate << endl;
            return false;
        }else{
            long count = 0;
            long ltemp = candidate;
            while (ltemp > 0){
                candidate = ltemp;
                ltemp++;
                count++;
            }
            cout << "long max found: " << candidate << endl; //9,223,372,036,854,775,807 - about 9 quintillion
            return true;
        }
    }
    long sum = candidate + addend;
    if (sum > 0){
        return recursiveLongMaxFinderAdd(sum, addend);
    }
    else{
        //cout << candidate << " + " << addend << " is too much; trying " << candidate << " + " << (addend / 2) << endl;
        return recursiveLongMaxFinderAdd(candidate, addend / 2);
    }
}

unsigned long long getUnsignedLongLongMaxEstimate(){
    //This method estimates the range of the data type unsigned long long, and does so with a multiplying loop, and not with brute force.
    //Note, since it's unsigned, it must be done a little differently from getLongMaxEstimate()
    
    unsigned long long myULL = 1;
    unsigned long long factor = 10L;
    unsigned long long uLLtemp = myULL * factor;
    
    while (uLLtemp > myULL){
        myULL = uLLtemp;
        uLLtemp *= factor;
//        cout << "long max guess = " << myULL << "\n";
    }
    
    return myULL;
    //              10,000,000,000,000,000,000: 10 quintillion
}

bool recursiveUnsignedLongLongMaxFinder(unsigned long long candidate, int factor){
    //This method finds the range of the data type unsigned long long, and does so recursively, and not with brute force
    //    because calculating with brute force would take too *long* (ha!)
    //Because the data type is unsigned, overflow won't go negative, so this must be done a little differently from recursiveLongMaxFinder()
    if (factor < 2){
        unsigned long long estimate = getUnsignedLongLongMaxEstimate();
        if (candidate < estimate){
            cout << "something went wrong; candidate is " << candidate << endl;
            return false;
        }else{
//            cout << "Narrowed down to factor " << factor << " and candidate is " << candidate << endl;
            return recursiveUnsignedLongLongMaxFinderAdd(candidate, estimate);
        }
    }
    unsigned long long product = candidate * factor;
    if (product > candidate){
        return recursiveUnsignedLongLongMaxFinder(product, factor);
    }
    else{
        return recursiveUnsignedLongLongMaxFinder(candidate, factor-1);
    }
}

bool recursiveUnsignedLongLongMaxFinderAdd(unsigned long long candidate, unsigned long long addend){
    if (addend == 1){
        unsigned long long estimate = getUnsignedLongLongMaxEstimate();
        if (candidate < estimate){
            cout << "something went wrong; candidate is " << candidate << endl;
            return false;
        }else{
            unsigned long long count = 0;
            unsigned long long ltemp = candidate+1;
//            cout << "candidate is " << candidate << " and ltemp is" << ltemp << endl;
            while (ltemp > candidate){
                candidate = ltemp;
                ltemp++;
                count++;
//                if (count % INT_MOD == 0) cerr << ".";
//                cout << "candidate is " << candidate << " and ltemp is" << ltemp << endl;
            }
            cout << "unsigned long long max found: " << candidate << endl;
            //18,446,744,073,709,551,615 - about 18 quintillion
            return true;
        }
    }
    unsigned long long sum = candidate + addend;
    if (sum > candidate){
//        cout << candidate << " + " << addend << " is < " << sum << endl;
        return recursiveUnsignedLongLongMaxFinderAdd(sum, addend);
    }
    else{
//        cout << candidate << " + " << addend << " is too much ("<<sum<<"); trying " << candidate << " + " << (addend / 2) << endl;
        return recursiveUnsignedLongLongMaxFinderAdd(candidate, addend / 2);
    }
}

uint64_t getUint64MaxEstimate(){
    
    uint64_t uint64 = 1;
    uint64_t factor = 10L;
    uint64_t uint64temp = uint64 * factor;
    
    while (uint64temp > uint64){
        uint64 = uint64temp;
        uint64temp *= factor;
        cout << "uint64 max guess = " << uint64 << "\n";
    }
    
    return uint64;//10,000,000,000,000,000,000 - 10 quintillion, just like UnsignedLongLong
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
    
}
