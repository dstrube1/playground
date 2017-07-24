

/**
 *  Time a function to compute the 2n+1 function.
 *  Created: 15:41, 09/07/03
 *  Modified: 15:44, 09/07/03
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


long twoNone(long n)
{
    long rtval = 0;
    while( n != 1 ) {
        if( n % 2 == 0 )
            n = n / 2;
        else
            n = 3 * n + 1;
        rtval++;
    }
    return rtval;
}

int main()
{
    const long step = 1000;
    const long start = step;
    const long limit = 100000;
    for( long n = start; n < limit; n += step ) {
        long t0 = millis();
        long f = twoNone(n);
        long t1 = millis();
        cout << "[" << setw(7) << (t1-t0) << "]  "  
            << setw(6) << n << "  " << setw(15) << f << endl;
    }
}

