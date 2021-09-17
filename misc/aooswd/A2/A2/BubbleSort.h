//BubbleSort.h
/***********
David Strube
CSIS4650-01
Spring 2003
Assignment 2
***********/


#ifndef BUBBLESORT_H
#define BUBBLESORT_H

#include "sort.h"

template <class T>
   class BubbleSort : public Sort<T>
   {
   public:
      BubbleSort();
      ~BubbleSort();
      void doit (T glob[], int size);
   };

template <class T>
   inline BubbleSort<T>::BubbleSort(){
   
   }

template <class T>
   inline BubbleSort<T>::~BubbleSort(){
   
   }


template <class T>
   inline void BubbleSort<T>::doit (T glob[], int size){
      bool swapped = false;
      for (int i = size; --i>=0; ) {
         for (int j = 0; j<i; j++) {
            if (glob[j] > glob[j+1]) {
               swap(glob[j],glob[j+1]);
               swapped = true;
            }
         }
         if (!swapped)
            return;

/**********************************************
This is very poor style.  You should have a loop
structure that has swapped as part of its control
structure.  You should never return from the middle
of a for loop.
************************************************/

      }
   
   }


	#endif
