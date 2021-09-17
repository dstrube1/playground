//glob.h
/***********
David Strube
CSIS4650-01
Spring 2003
Assignment 2
***********/

#ifndef GLOB_H
#define GLOB_H

#include  <stdlib.h>
#include <time.h>
#include <iostream>
#include "BubbleSort.h"
#include "SelectionSort.h"
#include "QuickSort.h"
//#include "Sort.h"

template <class T>
   class Glob 
   {
   public:
      Glob(int g);   
      ~Glob();
      int add(const T&); 
      int remove(T&);  
      void sort(char sort_type);
      void shuffle();
      void swap(unsigned int here1, unsigned int here2);
      void print();   
   private:
      int size;  // number of elements in Glob
      int isEmpty()const;
      int isFull() const;
      int top;  
      T* globPtr;  
      Sort<T>* s;
   } ;

template <class T>
   inline Glob<T>::Glob(int g){
      size= g>0 && g<1000 ? g : 10;
      top= -1;
      globPtr= new T[size];
   }

template <class T>
   inline Glob<T>::~Glob() {
   
      delete [] globPtr ;
   }

template <class T>
   inline int Glob<T>::add(const T& thing){
   
      if (!isFull())
      {
         globPtr[++top] = thing;
         return 1 ;  //success
      }
      else
         return 0 ;  //unsuccess
   } 

template <class T>
   inline int Glob<T>::remove(T& pop) {
   
      if (!isEmpty())
      {
         pop = globPtr[top--] ;
         return 1 ;  //success
      }
      return 0 ;  //unsuccess
   }

template <class T>
   inline void Glob<T>::sort(char sort_type){

/********************************************************************
You are combining the selection of the sort algorithm and the execution
of the algorithm.  They should be separate.  You should have a method that
allows the client to select the algorthm and another method that sorts using
the current algorithm.
*********************************************************************/
   
      if (sort_type == 'b') //bubble sort
      {
         s= new BubbleSort<T>;
      } 
      else if (sort_type == 's') //selection sort
      {
         s= new SelectionSort<T>;
      }
      else //default - quick
      {
         s= new QuickSort<T>;
      }
   
      s->doit(globPtr, size);
   
   }

template <class T>
   inline void Glob<T>::shuffle(){
   
      srand(time(NULL));
      unsigned int rval;
      for (int i = 0; i < size; i++){
         rval = (rand()%size);
         swap(i, rval);
      }
   }

template <class T>
   inline void Glob<T>::swap (unsigned int here1, unsigned int here2){
   
      if (signed (here1)<=top && signed (here1)<size) {
         if (signed (here2)<=top && signed (here2)<size){
            T temp = globPtr[here1];
            globPtr[here1]= globPtr[here2];
            globPtr[here2]=temp;
         }
      }
   }
template <class T>
   inline void Glob<T>::print(){
      if (!isEmpty()){
         for (int i=0; i<size; i++){
            cout<<globPtr[i]<<' ';
         }
         cout<<endl;
      }
      else
         cout<<"\nGlob is empty\n";
   }

template <class T>
   inline int Glob<T>::isEmpty()const {
   
      return top == -1 ;
   } 

template <class T>
   inline int Glob<T>::isFull() const {
   
      return top == size - 1 ;
   }

#endif

/*
template <class T>
   inline int Glob<T>::getSize() const {
   
      return size;
   }
template <class T>
   inline T Glob<T>::readAt(unsigned int here){
      T temp;
      if (signed (here)<=top && signed (here)<size)
         temp=globPtr[here];
      return temp;
   }

*/
