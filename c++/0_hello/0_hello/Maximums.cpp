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
    integer = 0;
    signed_int = 0;
    unsigned_int = 0;
    
    count = 0;
    
    i_p = integer;
    
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
    si_p = signed_int;
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
    ui_p = unsigned_int;
    unsigned_int++;
    while (ui_p < unsigned_int){
        ui_p++;
        unsigned_int++;
        count++;
        if (count % INT_MOD == 0) cout << ".";
    }
    cout << "End of unsigned int range. count = " << count << "\n\n"; //4,294,967,295 - about 4 billion
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
