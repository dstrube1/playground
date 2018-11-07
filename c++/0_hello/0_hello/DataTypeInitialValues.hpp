//
//  DataTypeInitialValues.hpp
//  0_hello
//
//  Created by David Strube on 11/6/18.
//  Copyright © 2018 David Strube. All rights reserved.
//

#ifndef DataTypeInitialValues_hpp
#define DataTypeInitialValues_hpp

//#include <stdio.h>

#include <iostream> //required for uint64_t

class DataTypeInitialValues{
public:
    void run();
private:
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

    uint64_t uint64;
};

#endif /* DataTypeInitialValues_hpp */
