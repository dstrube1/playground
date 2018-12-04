//
//  Maximums.hpp
//  0_hello
//
//  Created by David Strube on 11/6/18.
//  Copyright © 2018 David Strube. All rights reserved.
//

#ifndef Maximums_hpp
#define Maximums_hpp

//#include <stdio.h>
#include <iostream> //required for uint64_t

class Maximums{
public:
    void charMaximums();
    void shortMaximums();
    void intMaximums(bool isFast);
    void multiThreadedIntMax();
    void longMaximums();
    void floatMaximums();
    void doubleMaximums();
    void longDoubleMaximums();
private:
    ///////////////////////////////////////////////////////////////////////////////////////
    //VARIABLES
    ///////////////////////////////////////////////////////////////////////////////////////
    char character;
    signed char signed_char;
    unsigned char unsigned_char;
    
    char c_p;
    signed char sc_p;
    unsigned char uc_p;
    
    short shorty;
    signed short signed_short;
    unsigned short unsigned_short;
    
    short s_p;
    signed short ss_p;
    unsigned short us_p;
    
    int integer;
    signed int signed_int;
    unsigned int unsigned_int;
    int i_p;
    signed int si_p;
    unsigned int ui_p;
    
    unsigned long long count;
    
    //TODO Find the right way to do this
//    static /*volatile*/ bool waiting;
    //https://stackoverflow.com/questions/4557979/when-to-use-volatile-with-multi-threading
    
    ///////////////////////////////////////////////////////////////////////////////////////
    //METHODS
    ///////////////////////////////////////////////////////////////////////////////////////

    //INTS
    void slowIntMax();
    void fastIntMax();
    bool intMaxRecursive(int candidate, int factor);
    bool intMaxRecursiveAdd(int candidate, int addend);
    int getIntMaxEstimate();
    //Man!, this was tricky to find the right way to declare and implement this :(
    static void *threadedPrintDots(void *threadid);
    
    //LONGS
    long getLongMaxEstimate();
    bool recursiveLongMaxFinder(long candidate, int factor);
    bool recursiveLongMaxFinderAdd(long candidate, long addend);
    unsigned long long getUnsignedLongLongMaxEstimate();
    bool recursiveUnsignedLongLongMaxFinder(unsigned long long candidate, int factor);
    bool recursiveUnsignedLongLongMaxFinderAdd(unsigned long long candidate, unsigned long long addend);
    uint64_t getUint64MaxEstimate();
    
    //FLOATS
    float getFloatMaxEstimate();
    bool recursiveFloatMaxFinder(float candidate, float addend);
    double getDoubleMaxEstimate();
    bool recursiveDoubleMaxFinder(double candidate, double addend);
    long double getLongDoubleMaxEstimate();
    bool recursiveLongDoubleMaxFinder(long double candidate, long double addend);
};

#endif /* Maximums_hpp */
