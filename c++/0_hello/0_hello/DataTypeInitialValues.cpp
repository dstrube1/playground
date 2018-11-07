//
//  DataTypeInitialValues.cpp
//  0_hello
//
//  Created by David Strube on 11/6/18.
//  Copyright © 2018 David Strube. All rights reserved.
//

#include "DataTypeInitialValues.hpp"

using namespace std;

void DataTypeInitialValues::run(){
    /////////////////////////////////////////////////////////////////////////////////
    //Initial values
    /////////////////////////////////////////////////////////////////////////////////
    
    //0*: non-zero if declared outside main and called inside main;
    //if declared outside and called from a method in the main file but outside main method, 0
    
    //be careful about declaring methods (before main) before calling them
    
    cout << "initial value of bool: " << boolean << "\n\n";                        //0
    cout << "initial value of char: " << character << "\n";                        //0*
    cout << "initial value of signed char: " << signed_char << "\n";               //0*
    cout << "initial value of unsigned char: " << unsigned_char << "\n\n";         //0*
    cout << "initial value of short: " << shorty << "\n";                          //0
    cout << "initial value of signed short: " << signed_short << "\n";             //0
    cout << "initial value of unsigned short: " << unsigned_short << "\n\n";       //0
    cout << "initial value of int: " << integer << "\n";                           //0
    cout << "initial value of signed int: " << signed_int << "\n";                 //0
    cout << "initial value of unsigned int: " << unsigned_int << "\n\n";           //0
    cout << "initial value of long: " << loong << "\n";                            //0
    cout << "initial value of signed long: " << signed_long << "\n";               //0
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
