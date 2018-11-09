//
//  Maths.cpp
//  0_hello
//
//  Created by David Strube on 11/8/18.
//  Copyright © 2018 David Strube. All rights reserved.
//

#include "Maths.hpp"
#include <iostream>
#include <cmath>

using namespace std;

void Maths::tests(){
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

void Maths::intLongOverflows(){
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
    cout << "uint++: " << uint << endl;
    
    unsigned long long ull = 18446744073709551615ULL; //ULL suffix required for unsigned long long literal
    cout << "ull: " << ull << endl;
    ull++;
    cout << "ull++: " << ull << endl;
    cout << "Done"<< endl;
}
