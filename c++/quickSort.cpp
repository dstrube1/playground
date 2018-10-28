//
//	test of quick sort routine
//
//	Described in Chapter 14 of
//	Data Structures in C++ using the STL
//	Published by Addison-Wesley, 1997
//	Written by Tim Budd, budd@cs.orst.edu
//	Oregon State University
//

# include <vector.h>
# include <iostream.h>
# include <multiset.h>
# include <algo.h>

//
//	see section 3 of appendix a wrt to
//	second argument in declaration of multiset
//

template <class T>
unsigned int pivot (vector<T> & v, unsigned int start, 
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

template <class T>
void quickSort(vector<T> & v, unsigned int low, unsigned int high)
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

template <class T> void quickSort(vector<T> & v)
{
	unsigned int numberElements = v.size ();
	if (numberElements > 1) 
		quickSort(v, 0, numberElements - 1);
}

void main() {
	vector<int> v(100);
	for (int i = 0; i < 100; i++)
		v[i] = rand();
	quickSort(v);
	vector<int>::iterator itr = v.begin();
	while (itr != v.end()) {
		cout << *itr << " ";
		itr++;
		}
	// copy (v.begin(), v.end(), ostream_iterator<int>(cout, ":"));
	cout << "\n";
}
