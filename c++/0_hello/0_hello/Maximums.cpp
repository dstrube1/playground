//
//  Maximums.cpp
//  0_hello
//
//  Created by David Strube on 11/6/18.
//  Copyright © 2018 David Strube. All rights reserved.
//

#include "Maximums.hpp"
#include <iostream>
#include <pthread.h>

//modulus values for printing progress of data type ranges
//const int CHAR_MOD = 10;
//const int SHORT_MOD = 1000;
//const int INT_MOD = 10000000;
//preprocessor, no specific type
#define CHAR_MOD 10
#define SHORT_MOD 1000 //1,000
#define INT_MOD 100000000 //100,000,000
#define NUM_THREADS 1

using namespace std;

////////////////////////////////////////////////////////////////////
//PUBLICS
////////////////////////////////////////////////////////////////////

/*public*/ void Maximums::charMaximums(){
//    cout << "count at beginning of charMaximums: " << count << endl;
    count = 0;
    character = 0;
    signed_char = 0;
    unsigned_char = 0;
    
    c_p = character;
    sc_p = signed_char;
    uc_p = unsigned_char;
    
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

/*public*/ void Maximums::shortMaximums(){
//    cout << "count at beginning of shortMaximums: " << count << endl;
    count = 0;
//    cout << "shorty at beginning of shortMaximums: " << shorty << endl;
    shorty = 0;
    signed_short = 0;
    unsigned_short = 0;
    s_p = shorty;
    ss_p = signed_short;
    us_p = unsigned_short;
    
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

/*public*/ void Maximums::intMaximums(bool isFast){
    if (isFast){
        fastIntMax();
    }else{
        slowIntMax();
    }
}

/*public*/ void Maximums::multiThreadedIntMax(){
    //https://www.tutorialspoint.com/cplusplus/cpp_multithreading.htm
//    waiting = true;
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
    
//    cout << "(# is the main thread waiting)" << endl;
//    while(waiting){
//        count++;
//        if (count % INT_MOD == 0) cerr << "#";
//    }
    
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

/*public*/ void Maximums::longMaximums(){
    cout << "long max approximately = " << getLongMaxEstimate() << "\n";
    
    cout << "Recursively calculating long maximum...\n";
    recursiveLongMaxFinder(1,10);
    
    cout << "calculating unsigned long long max estimate... \n";
    recursiveUnsignedLongLongMaxFinder(1,10);
    
    cout << "uint64 max estimate: " << getUint64MaxEstimate() << "\n";
}

/*public*/ void Maximums::floatMaximums(){
    cout << "authoritative float max " << numeric_limits<float>::max() << endl; //3.40282e+38
    
    cout << "float max approximately = " << getFloatMaxEstimate() << "\n"; //1e+38
    
    cout << "Recursively calculating float maximum...\n";
    float estimate = getFloatMaxEstimate();
    recursiveFloatMaxFinder(estimate, estimate / 10); //3.40282e+38
}

/*public*/ void Maximums::doubleMaximums(){
    cout << "authoritative double max " << numeric_limits<double>::max() << endl; //1.79769e+308
    
    cout << "double max approximately = " << getDoubleMaxEstimate() << "\n"; //1e+308
    
    cout << "Recursively calculating double maximum...\n";
    double estimate = getDoubleMaxEstimate();
    recursiveDoubleMaxFinder(estimate, estimate / 10); //1.79769e+308

}

/*public*/ void Maximums::longDoubleMaximums(){
    cout << "authoritative long double max " << numeric_limits<long double>::max() << endl; //1.18973e+4932

    cout << "long double max approximately = " << getLongDoubleMaxEstimate() << "\n"; //1e+4932
    
    cout << "Recursively calculating double maximum...\n";
    long double estimate = getLongDoubleMaxEstimate();
    recursiveLongDoubleMaxFinder(estimate, estimate / 10); //1.18973e+4932
}
////////////////////////////////////////////////////////////////////
//PRIVATES
////////////////////////////////////////////////////////////////////

//So weird that this must be declared as static, but must not be implemented as static
/*private static */ void *Maximums::threadedPrintDots(void *threadid) {
    int integer = 0;
    
    long threadID = (long)threadid;
    cout << "Beginning thread " << threadID << endl;
    
    unsigned long long count = 0;
    
    int i_p = integer;
    
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
    
//    waiting = false;
    
    cout << "Exiting thread " << threadID << endl;
    pthread_exit(NULL);
//    cout << "Exited thread " << threadID << endl; //this doesn't print; thread's dead, baby. thread's dead.
}

/*private*/ void Maximums::slowIntMax(){
    integer = 0;
    signed_int = 0;
    unsigned_int = 0;
    
    count = 0;
    
    i_p = integer;
    
    cout << "Calculating int maximum (slowly)";
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
    cout << "\nEnd of int maximum. count = " << count << "\n"; //2,147,483,647
    
    /*Signed and unsigned int maximums:
     
    cout << "Calculating signed int maximum";
    count = 0;
    si_p = signed_int;
    signed_int++;
    while (si_p < signed_int){
        si_p++;
        signed_int++;
        count++;
        if (count % INT_MOD == 0) cout << ".";
    }
    cout << "\nEnd of signed int maximum. count = " << count << "\n"; //2,147,483,647 - about 2 billion
    
    cout << "Calculating unsigned int maximum";
    count = 0;
    ui_p = unsigned_int;
    unsigned_int++;
    while (ui_p < unsigned_int){
        ui_p++;
        unsigned_int++;
        count++;
        if (count % INT_MOD == 0) cout << ".";
    }
    cout << "\nEnd of unsigned int maximum. count = " << count << "\n\n"; //4,294,967,295 - about 4 billion
    */
}

/*private*/ void Maximums::fastIntMax(){
    intMaxRecursive(1,10);
}

/*private*/ bool Maximums::intMaxRecursive(int candidate, int factor){
    if (factor < 2){
        if (candidate < 0){
            cout << "something went wrong; candidate is " << candidate << endl;
            return false;
        }else{
            //cout << "Narrowed down to factor " << factor << " and candidate is " << candidate << endl;
            int estimate = getIntMaxEstimate();
            return intMaxRecursiveAdd(candidate, estimate);
        }
    }
    int product = candidate * factor;
    if (product > 0){
        return intMaxRecursive(product, factor);
    }
    else{
        return intMaxRecursive(candidate, factor-1);
    }
}

/*private*/ bool Maximums::intMaxRecursiveAdd(int candidate, int addend){
    if (addend == 1){
        if (candidate < 0){
            cout << "something went wrong; candidate is " << candidate << endl;
            return false;
        }else{
            int ltemp = candidate;
            while (ltemp > 0){
                candidate = ltemp;
                ltemp++;
            }
            cout << "int max found (quickly): " << candidate << endl;
            return true;
        }
    }
    int sum = candidate + addend;
    if (sum > 0){
        return intMaxRecursiveAdd(sum, addend);
    }
    else{
        //cout << candidate << " + " << addend << " is too much; trying " << candidate << " + " << (addend / 2) << endl;
        return intMaxRecursiveAdd(candidate, addend / 2);
    }
}

/*private*/ int Maximums::getIntMaxEstimate(){
    int myInt = 1;
    int iTemp = myInt;
    while (iTemp > 0){ //when iTemp exceeds the maximum, it loops around to a negative
        myInt = iTemp;
        iTemp *= 10;
        //cout << "int max guess = " << myInt << "\n";
    }
    return myInt;
}

/*private*/ long Maximums::getLongMaxEstimate(){
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

/*private*/ bool Maximums::recursiveLongMaxFinder(long candidate, int factor){
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

/*private*/ bool Maximums::recursiveLongMaxFinderAdd(long candidate, long addend){
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

/*private*/ unsigned long long Maximums::getUnsignedLongLongMaxEstimate(){
    //This method estimates the range of the data type unsigned long long, and does so with a multiplying loop, and not with brute force.
    //Note, since it's unsigned, it must be done a little differently from getLongMaxEstimate()
    
    unsigned long long myULL = 1ULL;
    unsigned long long factor = 10ULL;
    unsigned long long uLLtemp = myULL * factor;
    
    while (uLLtemp > myULL){
        myULL = uLLtemp;
        uLLtemp *= factor;
        //        cout << "long max guess = " << myULL << "\n";
    }
    
    return myULL;
    //              10,000,000,000,000,000,000: 10 quintillion
}

/*private*/ bool Maximums::recursiveUnsignedLongLongMaxFinder(unsigned long long candidate, int factor){
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

/*private*/ bool Maximums::recursiveUnsignedLongLongMaxFinderAdd(unsigned long long candidate, unsigned long long addend){
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

/*private*/ uint64_t Maximums::getUint64MaxEstimate(){
    uint64_t uint64 = 1ULL;
    uint64_t factor = 10ULL;
    uint64_t uint64temp = uint64 * factor;
    
    while (uint64temp > uint64){
        uint64 = uint64temp;
        uint64temp *= factor;
//        cout << "uint64 max guess = " << uint64 << "\n";
    }
    
    return uint64;//10,000,000,000,000,000,000 - 10 quintillion, just like UnsignedLongLong
}

/*private*/ float Maximums::getFloatMaxEstimate(){
    float myFloat = 1.0f;
    float fTemp = myFloat;
    //https://en.cppreference.com/w/cpp/types/numeric_limits/infinity
    while (fTemp != numeric_limits<float>::infinity()){
        myFloat = fTemp;
        fTemp *= 10;
        //cout<<"float max guess: " << myFloat << endl;
    }
    //cout<<"float max estimate: " << myFloat << endl;;
    return myFloat; //1e+38
}

/*private*/ bool Maximums::recursiveFloatMaxFinder(float candidate, float addend){
    if (addend <= 1){
        
        float estimate = getFloatMaxEstimate();
        
        if (candidate < estimate){
            cout << "something went wrong; candidate: " << candidate << "; estimate: " << estimate << endl;
            return false;
        }else{
            unsigned long long count = 0;
            float fTemp = candidate + 1;
            //            cout << "candidate is " << candidate << " and fTemp is" << fTemp << endl;
            while (fTemp > candidate){
                candidate = fTemp;
                fTemp++;
                count++;
//                if (count % INT_MOD == 0) cerr << ".";
//                cout << "candidate is " << candidate << " and fTemp is" << fTemp << endl;
                if (fTemp == fTemp - 1){
                    cout << "something went wrong; incrementig fTemp doesn't work at fTemp: " << fTemp << endl;
                    return false;
                }
            }
            cout << "float max found: " << candidate << endl; ////3.40282e+38
            return true;
        }
    }
    
    float sum = candidate + addend;
    
    //cout << "sum: " << sum << " = " << candidate << " + " << addend << endl;
    
    if (sum != numeric_limits<float>::infinity() && sum > candidate){
//        cout << candidate << " + " << addend << " is < " << sum << endl;
        return recursiveFloatMaxFinder(sum, addend);
    }
    else{
//        cout << candidate << " + " << addend << " is too much ("<<sum<<"); trying " << candidate << " + " << (addend / 2) << endl;
        return recursiveFloatMaxFinder(candidate, addend / 2);
    }
}

/*private*/ double Maximums::getDoubleMaxEstimate(){
    double myDouble = 1.0f;
    double dTemp = myDouble;
    //https://en.cppreference.com/w/cpp/types/numeric_limits/infinity
    while (dTemp != numeric_limits<double>::infinity()){
        myDouble = dTemp;
        dTemp *= 10;
        //cout<<"double max guess: " << myDouble << endl;
    }
//    cout<<"double max estimate: " << myDouble << endl;;
    return myDouble; //
}

/*private*/ bool Maximums::recursiveDoubleMaxFinder(double candidate, double addend){
    if (addend <= 1){
        
        double estimate = getDoubleMaxEstimate();
        
        if (candidate < estimate){
            cout << "something went wrong; candidate: " << candidate << "; estimate: " << estimate << endl;
            return false;
        }else{
            unsigned long long count = 0;
            double dTemp = candidate + 1;
//            cout << "candidate is " << candidate << " and dTemp is " << dTemp << endl;
            while (dTemp > candidate){
                candidate = dTemp;
                dTemp++;
                count++;
                if (count % INT_MOD == 0) cerr << ".";
//                cout << "candidate is " << candidate << " and dTemp is" << dTemp << endl;
                if (dTemp == dTemp - 1){
                    cout << "something went wrong; incrementing dTemp doesn't work at dTemp: " << dTemp << endl;
                    return false;
                }
            }
            cout << "double max found: " << candidate << endl; //
            return true;
        }
    }
    
    double sum = candidate + addend;
    
//    cout << "sum: " << sum << " = " << candidate << " + " << addend << endl;
    
    if (sum != numeric_limits<double>::infinity() && sum > candidate){
//        cout << candidate << " + " << addend << " is < " << sum << endl;
        return recursiveDoubleMaxFinder(sum, addend);
    }
    else{
//        cout << candidate << " + " << addend << " is too much (" << sum << "); trying " << candidate << " + " << (addend / 2) << endl;
        return recursiveDoubleMaxFinder(candidate, addend / 2);
    }
}

/*private*/ long double Maximums::getLongDoubleMaxEstimate(){
    long double myLDouble = 1.0f;
    long double dTemp = myLDouble;
    //https://en.cppreference.com/w/cpp/types/numeric_limits/infinity
    while (dTemp != numeric_limits<long double>::infinity()){
        myLDouble = dTemp;
        dTemp *= 10;
        //cout<<"double max guess: " << myLDouble << endl;
    }
    //    cout<<"double max estimate: " << myLDouble << endl;;
    return myLDouble; //
}

/*private*/ bool Maximums::recursiveLongDoubleMaxFinder(long double candidate, long double addend){
    if (addend <= 1){
        
        long double estimate = getLongDoubleMaxEstimate();
        
        if (candidate < estimate){
            cout << "something went wrong; candidate: " << candidate << "; estimate: " << estimate << endl;
            return false;
        }else{
            unsigned long long count = 0;
            long double dTemp = candidate + 1;
            //            cout << "candidate is " << candidate << " and dTemp is " << dTemp << endl;
            while (dTemp > candidate){
                candidate = dTemp;
                dTemp++;
                count++;
                if (count % INT_MOD == 0) cerr << ".";
                //                cout << "candidate is " << candidate << " and dTemp is" << dTemp << endl;
                if (dTemp == dTemp - 1){
                    cout << "something went wrong; incrementing dTemp doesn't work at dTemp: " << dTemp << endl;
                    return false;
                }
            }
            cout << "long double max found: " << candidate << endl; //
            return true;
        }
    }
    
    long double sum = candidate + addend;
    
    //    cout << "sum: " << sum << " = " << candidate << " + " << addend << endl;
    
    if (sum != numeric_limits<long double>::infinity() && sum > candidate){
        //        cout << candidate << " + " << addend << " is < " << sum << endl;
        return recursiveLongDoubleMaxFinder(sum, addend);
    }
    else{
        //        cout << candidate << " + " << addend << " is too much (" << sum << "); trying " << candidate << " + " << (addend / 2) << endl;
        return recursiveLongDoubleMaxFinder(candidate, addend / 2);
    }
}
