
/**
 *  Computing powers using a recursive method.
 *  Created: 16:15, 09/07/03
 *  Modified: 15:08, 09/19/03
 *
 */
#include <iostream>
#include <math.h>
#include <iomanip>
#include <sys/timeb.h>
using namespace std;

// returns the time in milliseconds.
long millis()
{
    struct timeb t;
    ftime(&t);
    return 1000*t.time + t.millitm;
}

/**
 *  Returns b raised to the e power.
 *  It is assumed that e >= 0.
 */
double powr(double b, int e)
{
    // cout << "calling powr " << b << " " << e << endl; 
    double rtval;
    if( e == 0 )
        rtval = 1.0;
    else {
        double x = powr(b, e/2);
        rtval = x * x;
        if( e % 2 == 1 )
            rtval = rtval * b;
    }
    return rtval;
}

int main()
{
    double b = 1.001;
    const long limit =  400000L;
    const long step =    10000L;
    const long start = step;
    // because the power function is so fast, we have to repeat
    // it a number of times to get a measurable time.  The reps
    // simply become part of the constant c.
    const long reps =  1000000L;
    for( long e = start; e < limit; e += step ) {
        long t0 = millis();
        for( int i = 0; i < reps; i++ )
            powr(b,e);
        long t1 = millis();
        cout << setw(15) << e 
            << setw(15) << (t1-t0) << endl;
    }
}
