//
//  DataTypeSizes.cpp
//  0_hello
//
//  Created by David Strube on 11/6/18.
//  Copyright © 2018 David Strube. All rights reserved.
//

#include "DataTypeSizes.hpp"

using namespace std;

void DataTypeSizes::run(){
    /////////////////////////////////////////////////////////////////////////////////
    //tests of type Sizes
    /////////////////////////////////////////////////////////////////////////////////
    cout << "sizeof(bool): " << sizeof(boolean) << "\n\n";                          //1
    cout << "sizeof(char): " << sizeof(character) << "\n";                          //1
    cout << "sizeof(signed char): " << sizeof(signed_char) << "\n";                 //1
    cout << "sizeof(unsigned char): " << sizeof(unsigned_char) << "\n\n";           //1
    cout << "sizeof(short): " << sizeof(shorty) << "\n";                            //2
    cout << "sizeof(signed short): " << sizeof(signed_short) << "\n";               //2
    cout << "sizeof(unsigned short): " << sizeof(unsigned_short) << "\n\n";         //2
    cout << "sizeof(int): " << sizeof(integer) << "\n";                             //4
    cout << "sizeof(signed int): " << sizeof(signed_int) << "\n";                   //4
    cout << "sizeof(unsigned int): " << sizeof(unsigned_int) << "\n\n";             //4
    cout << "sizeof(long): " << sizeof(loong) << "\n";                              //8
    cout << "sizeof(signed long): " << sizeof(signed_long) << "\n";                 //8
    cout << "sizeof(unsigned long): " << sizeof(unsigned_long) << "\n\n";           //8
    cout << "sizeof(float): " << sizeof(floaty) << "\n\n";                          //4
    cout << "sizeof(double): " << sizeof(dooble) << "\n";                           //8
    cout << "sizeof(long double): " << sizeof(long_double) << "\n\n";               //16
    cout << "sizeof(wchar_t): " << sizeof(wchar) << "\n";                           //4
    cout << "sizeof(signed wchar_t): " << sizeof(signed_wchar) << "\n";             //4
    cout << "sizeof(unsigned wchar_t): " << sizeof(unsigned_wchar) << "\n\n";       //4
    cout << "sizeof(long long): " << sizeof(long_long) << "\n";                     //8
    cout << "sizeof(int long): " << sizeof(int_long) << "\n";                       //8
    cout << "sizeof(long int): " << sizeof(long_int) << "\n";                       //8
    cout << "sizeof(signed long long): " << sizeof(signed_long_long) << "\n";       //8
    cout << "sizeof(signed int long): " << sizeof(signed_int_long) << "\n";         //8
    cout << "sizeof(signed long int): " << sizeof(signed_long_int) << "\n";         //8
    cout << "sizeof(unsigned long long): " << sizeof(unsigned_long_long) << "\n";   //8
    cout << "sizeof(unsigned int long): " << sizeof(unsigned_int_long) << "\n";     //8
    cout << "sizeof(unsigned long int): " << sizeof(unsigned_long_int) << "\n\n";   //8
    cout << "sizeof(short int): " << sizeof(short_int) << "\n";                     //2
    cout << "sizeof(int short): " << sizeof(int_short) << "\n";                     //2
    cout << "sizeof(signed short int): " << sizeof(signed_short_int) << "\n";       //2
    cout << "sizeof(signed int short): " << sizeof(signed_int_short) << "\n";       //2
    cout << "sizeof(unsigned short int): " << sizeof(unsigned_short_int) << "\n";   //2
    cout << "sizeof(unsigned int short): " << sizeof(unsigned_int_short) << "\n\n"; //2
    cout << "sizeof(uint64): " << sizeof(uint64) << "\n";                           //8
    
    cout << "/////////////////////////////////////////////////////////////////////////////////\n\n";
}
