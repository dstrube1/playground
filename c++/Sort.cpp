

/**
 *  Time a function to compute Fibonacci numbers.
 *  Created: 12:04, 09/06/03
 *  Modified: 21:39, 09/19/03
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

void fillArray(int a[], int n)
{
    for( int i = 0; i < n; i++ )
        a[0] = rand();
}

void sort(int a[], int n)
{
    for( int i = 0; i < n; i++ ) {
        for( int j = 0; j < n-1; j++ ) {
            if( a[j] > a[j+1] ) {
                int t = a[j];
                a[j] = a[j+1];
                a[j+1] = a[j];
            }
        }
    }
}

int main()
{
    const long start =       0;
    const long limit =  200000;
    const long step =     5000;
    for( long n = start; n < limit; n += step ) {
        int *a = new int[n];
        fillArray(a, n);
        long t0 = millis();
        sort(a,n);
        long t1 = millis();
        cout << setw(15) << (t1-t0)    
            << setw(15) << n 
            <<  endl;
        delete a;
    }
}

