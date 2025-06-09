//QuickSort.h
/***********
David Strube
CSIS4650-01
Spring 2003
Assignment 2
***********/

#ifndef QUICKSORT_H
#define QUICKSORT_H

#include "sort.h"

template <class T>	
   class QuickSort : public Sort<T>
   
   {
   public:
      QuickSort();
      ~QuickSort();
      void doit (T glob[], int size);
   private:
      void meat(T glob[], int lo0, int hi0);
   };

template <class T>	
   inline QuickSort<T>::QuickSort(){
   }

template <class T>	
   inline QuickSort<T>::~QuickSort(){
   }

template <class T>	
   inline void QuickSort<T>::doit (T glob[], int size){
      meat(glob, 0, size-1);
   }

template <class T>	
   inline void QuickSort<T>::meat(T glob[], int lo0, int hi0){
      int lo = lo0;
      int hi = hi0;
      T mid;
   
      if ( hi0 > lo0){
         mid = glob[((lo0+hi0) /2)];
      
         while( lo <= hi )
         {
         
            while( ( lo < hi0 ) && ( glob[lo] < mid ))
               ++lo;
         
            /* find an element that is smaller than or equal to
             * the partition element starting from the right Index.
             */
            while( ( hi > lo0 ) && ( glob[hi] > mid ))
               --hi;
         
            // if the indexes have not crossed, swap
            if( lo <= hi )
            {
               swap(glob[lo], glob[hi]);
               ++lo;
               --hi;
            }
         }
      
         /* If the right index has not reached the left side of array
          * must now sort the left partition.
          */
         if( lo0 < hi )
            meat( glob, lo0, hi );
      
         /* If the left index has not reached the right side of array
          * must now sort the right partition.
          */
         if( lo < hi0 )
            meat( glob, lo, hi0 );
      
      }
   }
	#endif