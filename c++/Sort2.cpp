

/**
 *  Time a function to sort a list.
 *  Created: 12:04, 09/06/03
 *  Modified: 18:16, 09/11/03
 *
 */

#include <iostream>
#include <iomanip>
#include <sys/timeb.h>
// #include <time.h>
//#include <algorithm>
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

/**
 *  The quicksort routines are adapted from Budd's source code.
 *  Instead of being template functions, these functions only
 *  work with arrays of integers.
 */
unsigned int pivot (int v[], unsigned int start, 
	unsigned int stop, unsigned int position)
	// partition vector into two groups
	// values smaller than or equal to pivot
	// values larger than pivot
	// return location of pivot element
{
		// swap pivot into starting position
	swap (v[start], v[position]);

		// partition values
	unsigned int low = start + 1;
	unsigned int high = stop;
	while (low < high)
		if (v[low] < v[start])
			low++;
		else if (v[--high] < v[start])
			swap (v[low], v[high]);

		// then swap pivot back into place
	swap (v[start], v[--low]);
	return low;
}

void quickSort(int v[], unsigned int low, unsigned int high)
{
	// no need to sort a vector of zero or one elements
	if (low >= high)
		return;

	// select the pivot value
	unsigned int pivotIndex = (low + high) / 2;

	// partition the vector
	pivotIndex = pivot (v, low, high, pivotIndex);

	// sort the two sub vectors
	if (low < pivotIndex)
		quickSort(v, low, pivotIndex);
	if (pivotIndex < high)
		quickSort(v, pivotIndex + 1, high);
}

void quickSort(int v[], int n)
{
	if (n > 1) 
		quickSort(v, 0, n-1);
}

/**
 *  End of adaptation of Budd's code.
 */


void test()
{
    const long step = 10000;
    const long start = step;
    const long limit = 1000000;
    for( long n = start; n < limit; n += step ) {
        int *a = new int[n];
        fillArray(a, n);
        long t0 = millis();
        quickSort(a,n);
        long t1 = millis();
        cout << "[" << setw(7) << (t1-t0) << "]  "  
            << setw(6) << n 
            << endl;
        delete a;
    }
}

int main()
{
    test();
}
