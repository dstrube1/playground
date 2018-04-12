package com.dstrube.myapplication;

import android.util.Log;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

/**
 * This is a class that showcases many different types of sorts
 * <p/>
 * List:
 * https://en.wikipedia.org/wiki/Sorting_algorithm#Comparison_of_algorithms
 */
public class MySortTest {

    private static final String TAG = MySortTest.class.getSimpleName();


//    How do we want to do this?:
//
//    non-static non-generic
//    MySortTest mst = new MySortTest();
//    array = mst.quickSort(array);
//    pro: easy to write
//    con: hard to write error handling
//
//    or
//    non-static generic
//    MySortTest mst = new MySortTest();
//    array = mst.sort(array,"quickSort");
//    pro: easy to put error handling in one place
//    con: more writing than static generic
//
//    or
//    static non-generic
//    array = MySortTest.quickSort(array)
//    pro: easiest to write without error handling
//    con: hard on error handling writing
//
//    or
//    static generic
//    array = MySortTest.sort(array,"quickSort");
//    pro: easier to put all null checking etc in one place
//    con: a little more work

    public MySortTest() {
    }
//
//    public MySortTest(int[] array) {
//        //array will have to be non-static for this to work
//        this.array = array;
//    }

//    private int[] array;

    public static int[] generateRandomArray(int size) {
        final Random random = new Random();
        if (size == 0) {
            size = 10; //random.nextInt(10);
        }
        final int[] result = new int[size];
        for (int i = 0; i < size; i++) {
            result[i] = random.nextInt(20);
        }
        return result;
    }

//    public static int[] sort(int[] input, String sortType) {
//        return null;
//    }

    public static boolean isSorted(int[] array) {
        for (int i = 0; i < array.length - 1; i++) {
            if (array[i] > array[i + 1]) {
                return false;
            }
        }
        return true;
    }

    public static void binaryTreeSort() throws NoSuchMethodException {
        //https://en.wikipedia.org/wiki/Tree_sort
        //http://www.qmatica.com/DataStructures/Trees/BST.html
        //http://postimg.org/image/a76lcv16r/
        //http://stackoverflow.com/questions/15696552/sorting-the-elements-in-binary-trees
        //http://math.hws.edu/javanotes/source/chapter9/SortTreeDemo.java
        //http://math.hws.edu/javanotes/c9/s4.html

//TODO
        throw new NoSuchMethodException();
    }

    public static void bubbleSort(final int[] array) {
        //http://www.java2novice.com/java-sorting-algorithms/bubble-sort/
        //https://en.wikipedia.org/wiki/Bubble_sort

/*
* Bubble sort, also referred to as sinking sort, is a simple sorting algorithm that works by
* repeatedly stepping through the list to be sorted, comparing each pair of adjacent items and
* swapping them if they are in the wrong order. The pass through the list is repeated until no swaps
* are needed, which indicates that the list is sorted. The algorithm gets its name from the way
* smaller elements "bubble" to the top of the list. Because it only uses comparisons to operate on
* elements, it is a comparison sort. Although the algorithm is simple, most of the other sorting
* algorithms are more efficient for large lists.
*
* Bubble sort has worst-case and average complexity both О(n^2), where n is the number of items being
* sorted. There exist many sorting algorithms with substantially better worst-case or average
* complexity of O(n log n). Even other О(n^2) sorting algorithms, such as insertion sort, tend to have
* better performance than bubble sort. Therefore, bubble sort is not a practical sorting algorithm
* when n is large. Performance of bubble sort over an already-sorted list (best-case) is O(n).
* */
        final int arraySize = array.length;
        int nextIndex;
        for (int howManyLoops = arraySize; howManyLoops >= 0; howManyLoops--) {
            for (int index = 0; index < arraySize - 1; index++) {
                nextIndex = index + 1;
                if (array[index] > array[nextIndex]) {
                    final int temp = array[index];
                    array[index] = array[nextIndex];
                    array[nextIndex] = temp;
                }
            }
        }
    }

    public static void combSort(int[] array) {
        //https://en.wikipedia.org/wiki/Comb_sort
        //http://rosettacode.org/wiki/Sorting_algorithms/Comb_sort#Java

        int gap = array.length;
        final int shrink = 2;
        boolean swapped = true;

        while (gap > 1 || swapped) {
            if (gap > 1) {
                gap = gap / shrink;
            }

            swapped = false;

            for (int i = 0; i + gap < array.length; i++) {
                if (array[i] > array[i + gap]) {
                    int tmp = array[i];
                    array[i] = array[i + gap];
                    array[i + gap] = tmp;
                    swapped = true;
                }
            }
        }
    }

    public static void gnomeSort(int[] array) {
        //https://en.wikipedia.org/wiki/Gnome_sort
        //http://dickgrune.com/Programs/gnomesort.html

/*
* Here is how a garden gnome sorts a line of flower pots. Basically, he looks at the flower pot
* next to him and the previous one; if they are in the right order he steps one pot forward,
* otherwise he swaps them and steps one pot backwards. Boundary conditions: if there is no previous
* pot, he steps forwards; if there is no pot next to him, he is done.
* */
        int i = 0;
        final int n = array.length;

        while (i < n) {
            if (i == 0 || array[i - 1] <= array[i])
                i++;
            else {
                int tmp = array[i];
                array[i] = array[i - 1];
                array[--i] = tmp;
            }
        }
    }

    public static void heapSort(int[] array) {
//        https://en.wikipedia.org/wiki/Heapsort
//        http://rosettacode.org/wiki/Sorting_algorithms/Heapsort#Java
        int count = array.length;

        //first place a in max-heap order
        heapify(array, count);

        int end = count - 1;
        while (end > 0) {
            //swap the root(maximum value) of the heap with the
            //last element of the heap
            int tmp = array[end];
            array[end] = array[0];
            array[0] = tmp;
            //put the heap back in max-heap order
            siftDownHeap(array, 0, end - 1);
            //decrement the size of the heap so that the previous
            //max value will stay in its proper place
            end--;
        }
    }

    private static void heapify(int[] array, int count) {
        //start is assigned the index in a of the last parent node
        int start = (count - 2) / 2; //binary heap

        while (start >= 0) {
            //sift down the node at index start to the proper place
            //such that all nodes below the start index are in heap
            //order
            siftDownHeap(array, start, count - 1);
            start--;
        }
        //after sifting down the root all nodes/elements are in heap order
    }

    private static void siftDownHeap(int[] array, int start, int end) {
        //end represents the limit of how far down the heap to sift
        int root = start;

        while ((root * 2 + 1) <= end) {      //While the root has at least one child
            int child = root * 2 + 1;           //root*2+1 points to the left child
            //if the child has a sibling and the child's value is less than its sibling's...
            if (child + 1 <= end && array[child] < array[child + 1])
                child = child + 1;           //... then point to the right child instead
            if (array[root] < array[child]) {     //out of max-heap order
                int tmp = array[root];
                array[root] = array[child];
                array[child] = tmp;
                root = child;                //repeat to continue sifting down the child now
            } else
                return;
        }
    }

    public static void inPlaceSort(int[] array) throws NoSuchMethodException {
        throw new NoSuchMethodException();
    }

    public static void insertionSort(final int[] array) {
        //https://en.wikipedia.org/wiki/Insertion_sort
        //http://www.java2novice.com/java-sorting-algorithms/insertion-sort/

/*
* Insertion sort is a simple sorting algorithm, it builds the final sorted array one item at a time.
* It is much less efficient on large lists than other sort algorithms.
*
* Advantages of Insertion Sort:
*
* 1) It is very simple.
* 2) It is very efficient for small data sets.
* 3) It is stable; i.e., it does not change the relative order of elements with equal keys.
* 4) In-place; i.e., only requires a constant amount O(1) of additional memory space.
*
* Insertion sort iterates through the list by consuming one input element at each repetition, and
* growing a sorted output list. On a repetition, insertion sort removes one element from the input
* data, finds the location it belongs within the sorted list, and inserts it there. It repeats until
* no input elements remain.
*
* The best case input is an array that is already sorted. In this case insertion sort has a linear
* running time (i.e., Θ(n)). During each iteration, the first remaining element of the input is only
* compared with the right-most element of the sorted subsection of the array. The simplest worst
* case input is an array sorted in reverse order. The set of all worst case inputs consists of all
* arrays where each element is the smallest or second-smallest of the elements before it. In these
* cases every iteration of the inner loop will scan and shift the entire sorted subsection of the
* array before inserting the next element. This gives insertion sort a quadratic running time
* (i.e., O(n2)). The average case is also quadratic, which makes insertion sort impractical for
* sorting large arrays. However, insertion sort is one of the fastest algorithms for sorting very
* small arrays, even faster than quicksort; indeed, good quicksort implementations use insertion
* sort for arrays smaller than a certain threshold, also when arising as subproblems; the exact
* threshold must be determined experimentally and depends on the machine, but is commonly around ten.
*
* */
        int temp;
        for (int i = 1; i < array.length; i++) {
            for (int j = i; j > 0; j--) {
                if (array[j] < array[j - 1]) {
                    temp = array[j];
                    array[j] = array[j - 1];
                    array[j - 1] = temp;
                }
            }
        }
    }

    public static void mergeSort(int[] array) {
        //http://www.java2novice.com/java-sorting-algorithms/merge-sort/
        //https://en.wikipedia.org/wiki/Merge_sort

/*
* Merge sort is a fast, stable sorting routine with guaranteed O(n*log(n)) efficiency.
* When sorting arrays, merge sort requires additional scratch space proportional to the size
* of the input array. Merge sort is relatively simple to code and offers performance
* typically only slightly below that of quicksort.
* */

        Log.i(TAG, "Begin mergeSort");
        doMergeSort(array, 0, array.length - 1);
//        Log.i(TAG, "End mergeSort");

    }

    private static void doMergeSort(int[] array, int lowerIndex, int higherIndex) {
//        Log.i(TAG, "doMergeSort, low = " + lowerIndex + "; high = " + higherIndex);
//        Log.i(TAG, "array = " + MainActivity.stringifyIntArray(array));

        if (lowerIndex < higherIndex) {
            final int middle = lowerIndex + (higherIndex - lowerIndex) / 2;
            // Below step sorts the left side of the array
            doMergeSort(array, lowerIndex, middle);
            // Below step sorts the right side of the array
            doMergeSort(array, middle + 1, higherIndex);
            // Now merge both sides
            mergeParts(array, lowerIndex, middle, higherIndex);
        }
    }

    private static void mergeParts(int[] array, int lowerIndex, int middle, int higherIndex) {
        final int[] tempMergArr = new int[array.length];

        for (int i = lowerIndex; i <= higherIndex; i++) {
            //compiler says to use System.arraycopy, but
            //why does this do nothing?
//            System.arraycopy(array, i, tempMergArr, i, array.length);
            tempMergArr[i] = array[i];
        }
        int i = lowerIndex;
        int j = middle + 1;
        int k = lowerIndex;
        while (i <= middle && j <= higherIndex) {
            if (tempMergArr[i] <= tempMergArr[j]) {
                array[k] = tempMergArr[i];
                i++;
            } else {
                array[k] = tempMergArr[j];
                j++;
            }
            k++;
        }
        while (i <= middle) {
            array[k] = tempMergArr[i];
            k++;
            i++;
        }

    }

    public static void quickSort(int[] array) {
        //https://en.wikipedia.org/wiki/Quicksort
        //http://www.java2novice.com/java-sorting-algorithms/quick-sort/

/*
* Quicksort or partition-exchange sort, is a fast sorting algorithm, which is using divide
* and conquer algorithm. Quicksort first divides a large list into two smaller sub-lists:
* the low elements and the high elements. Quicksort can then recursively sort the sub-lists.
*
* Steps to implement Quick sort:
*
* 1) Choose an element, called pivot, from the list. Generally pivot can be the middle index element.
* 2) Reorder the list so that all elements with values less than the pivot come before the
* pivot, while all elements with values greater than the pivot come after it (equal values
* can go either way). After this partitioning, the pivot is in its final position. This is
* called the partition operation.
* 3) Recursively apply the above steps to the sub-list of elements with smaller values and
* separately the sub-list of elements with greater values.
*
* The complexity of quick sort in the average case is Θ(n log(n)) and in the worst case is Θ(n2).
* */

        Log.i(TAG, "Begin quickSort");

        final int length = array.length;
        quickSortRecurse(array, 0, length - 1);

    }

    private static void quickSortRecurse(int[] array, final int lowerIndex, final int higherIndex) {

        int i = lowerIndex;
        int j = higherIndex;
        // calculate pivot number, I am taking pivot as middle index number
        final int pivot = array[lowerIndex + (higherIndex - lowerIndex) / 2];
        // Divide into two arrays
        while (i <= j) {
            /**
             * In each iteration, we will identify a number from left side which
             * is greater then the pivot value, and also we will identify a number
             * from right side which is less then the pivot value. Once the search
             * is done, then we exchange both numbers.
             */
            while (array[i] < pivot) {
                i++;
            }
            while (array[j] > pivot) {
                j--;
            }
            if (i <= j) {
                int temp = array[i];
                array[i] = array[j];
                array[j] = temp;
                //move index to next position on both sides
                i++;
                j--;
            }
        }
        // call quickSort() method recursively
        if (lowerIndex < j)
            quickSortRecurse(array, lowerIndex, j);
        if (i < higherIndex)
            quickSortRecurse(array, i, higherIndex);

    }

    public static void selectionSort(final int[] array) {
        //https://en.wikipedia.org/wiki/Selection_sort
        //http://www.java2novice.com/java-sorting-algorithms/selection-sort/

/*
* The selection sort is a combination of searching and sorting. During each pass, the unsorted
* element with the smallest (or largest) value is moved to its proper position in the array. The
* number of times the sort passes through the array is one less than the number of items in the
* array. In the selection sort, the inner loop finds the next smallest (or largest) value and the
* outer loop places that value into its proper location.
*
* Selection sort is not difficult to analyze compared to other sorting algorithms since none of the
* loops depend on the data in the array. Selecting the lowest element requires scanning all n
* elements (this takesn − 1 comparisons) and then swapping it into the first position. Finding the
* next lowest element requires scanning the remaining n − 1 elements and so on,
* for (n − 1) + (n − 2) + ... + 2 + 1 = n(n − 1) / 2 ∈ Θ(n2) comparisons.
* Each of these scans requires one swap for n − 1 elements.
* */
        for (int i = 0; i < array.length - 1; i++) {
            int index = i;
            for (int j = i + 1; j < array.length; j++)
                if (array[j] < array[index])
                    index = j;

            final int smallerNumber = array[index];
            array[index] = array[i];
            array[i] = smallerNumber;
        }
    }

}
