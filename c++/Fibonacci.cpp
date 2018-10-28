

/**
 *  Time a function to compute Fibonacci numbers.
 *  Created: 12:04, 09/06/03
 *  Modified: 22:36, 09/19/03
 *
 */

#include <iostream>
#include <iomanip>
#include <sys/timeb.h>
// #include <time.h>
using namespace std;

// returns the time in milliseconds.
long millis()
{
    struct timeb t;
    ftime(&t);
    return 1000*t.time + t.millitm;
}


long fib(long n)
{
    long rtval;
    if( n <= 1 )
        rtval = 1;
    else
        rtval = fib(n-1) + fib(n-2);
    return rtval;
}

int main()
{
    const long start = 33;
    const long limit = 100;
    const long step = 1;
    for( long n = start; n < limit; n += step ) {
        long t0 = millis();
        long f = fib(n);
        long t1 = millis();
        cout << "[" << setw(15) << (t1-t0) << "]  "  
            << setw(4) << n << "  " << setw(15) << f << endl;
    }
}

