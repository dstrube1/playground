//bridge_driver.cpp

/****************
David Strube             20/20
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/


#include "tree.h"
   using namespace std;

   int main(){
   		///////////////////////////////////////////
   		//if want to change number type, do so here:
      typedef int mytype; 
   
      const mytype a=9, b=7, c=5, d=3, e=1;
   
      Tree<mytype> T1(a); 
      Tree<mytype> T2('-', T1.eval());
      Tree<mytype> T3(b);
      Tree<mytype> T4('+', T2, T3);
   	Tree<mytype> T5(c);
   	Tree<mytype> T6('+', T5);
   Tree<mytype> T7('*', T4, T6);
   Tree<mytype> T8(d);
   Tree<mytype> T9('/', T7, T8);
   Tree<mytype> T10(e);
   Tree<mytype> T11('^', T9, T10);
   
   
      cout<<"T11=";
      T11.print();
      cout<<"="<<T11.eval()<<endl;
   
      return 0;}

