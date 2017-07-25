//glob.h
/***********
David Strube
CSIS4650-01
Spring 2003
Assignment 6
***********/

#ifndef GLOB_H
#define GLOB_H

#include <iostream>
#include <string>

template <class T>
   class Glob {
   public:
      Glob(int g);   
      ~Glob();
      int add(const T&); 
      int remove(T&);  
      void swap(unsigned int here1, unsigned int here2);
      string toString() const;   
      T readAt(unsigned int);
      void writeAt(unsigned int, T);
      int getSize() const;
   private:
      int size;  // number of elements in Glob
      int isEmpty()const;
      int isFull() const;
      int top;  
      T* globPtr;  } ;

template <class T>
   inline Glob<T>::Glob(int g){
      size= g>0 && g<1000 ? g : 10;
      top= -1;
      globPtr= new T[size];}

template <class T>
   inline Glob<T>::~Glob() {
      delete [] globPtr ;}

template <class T>
   inline int Glob<T>::add(const T& thing){
      if (!isFull()){
         globPtr[++top] = thing;
         return 1 ; } //success
      //else
      return 0 ;  } //unsuccess

template <class T>
   inline int Glob<T>::remove(T& pop) {
      if (!isEmpty()){
         pop = globPtr[top--] ;
         return 1 ;  }//success
      return 0 ; } //unsuccess

template <class T>
   inline void Glob<T>::swap (unsigned int here1, unsigned int here2){
      if (signed (here1)<=top && signed (here1)<size) {
         if (signed (here2)<=top && signed (here2)<size){
            T temp = globPtr[here1];
            globPtr[here1]= globPtr[here2];
            globPtr[here2]=temp;}
      }}

template <class T>
   inline string Glob<T>::toString()const{
      string temp("");
      if (!isEmpty()){
         for (int i=0; i<size; i++){
            cout<<"temp["<<i<<"] = "<<(char)(globPtr[i]+48)<<"\t";				
            temp[i]=globPtr[i]+48;}
      }
      return temp;}

template <class T>
   inline int Glob<T>::isEmpty()const {
      return top == -1 ;} 

template <class T>
   inline int Glob<T>::isFull() const {
      return top == size - 1 ;}

template <class T>
   inline int Glob<T>::getSize() const {
      return size;}

template <class T>

   inline T Glob<T>::readAt(unsigned int here){
      T temp;
      if (signed (here)<=top && signed (here)<size)
         temp=globPtr[here];
      return temp;}

template <class T>
   inline void Glob<T>::writeAt(unsigned int here, T temp){
      if (signed (here)<=top && signed (here)<size)
         globPtr[here]=temp;
   }


#endif
