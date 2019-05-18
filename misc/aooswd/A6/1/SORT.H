//sort.h
/***********
David Strube
CSIS4650-01
Spring 2003
Assignment 2
***********/

#ifndef SORT_H
#define SORT_H

template <class T>
   class Sort{
   public:
      Sort();
      virtual void doit(T glob[], int size)=0;
      virtual ~Sort()=0;
      void swap(T& temp1, T& temp2);
   };


template <class T>
   inline Sort<T>::Sort(){
   
   }
template <class T>
   inline Sort<T>::~Sort(){
   
   }

template <class T>
   inline void Sort<T>::swap(T& temp1, T& temp2){
      T temp0=temp1;
      temp1=temp2;
      temp2=temp0;
   }

#endif
