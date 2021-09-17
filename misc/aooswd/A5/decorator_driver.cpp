
//decorator_driver.cpp

/****************
David Strube           20/20
CSIS4650-01
Spring 2003
Assignment 5
Expression Tree extended using decorator pattern
***************/


#include "Tree.h"
#include "TimingDecorator.h"
   using namespace std;

   Tree* makeBigTree(int);

   int main(){
      int size=5;
      int result=0;
      TreeInterface* T1= new Tree(9);
      TreeInterface* T2=new Tree('-',T1);//-9

      TreeInterface* T3=new Tree(6);
      TreeInterface* T4=new Tree('+',T3);//+6
      TreeInterface* T5=new Tree('+',T4,T2);//+6 + -9
      TreeInterface* T6=new Tree(3);
      TreeInterface* T7=new Tree('*',T5,T6); //(+6 + -9) * 3

      TreeInterface* T8=new Tree(8);
      TreeInterface* T9=new Tree(4);
      TreeInterface* T10=new Tree(2);
      TreeInterface* T11=new Tree('^', T9, T10);
      TreeInterface* T12=new Tree('-',T8,T11); //8 - (4^2)

      TreeInterface* T13=new Tree('/', T7, T12);
      TreeInterface* T14 = new TimingDecorator(T13);
      result=T14->eval();
      cout<<T14->toString();
      cout<<"result = "<<result<<endl;

   //shortcut for some power of 2
      TreeInterface* T15=makeBigTree(size);
      TreeInterface* T16=new TimingDecorator(T15);
      result=T16->eval();
      cout<<endl<<T16->toString();
      cout<<"result = "<<result;

      return 0;}

   Tree* makeBigTree(int size){
      Tree* rootPtr;
      if (size>0){
         TreeInterface* tiL=makeBigTree(size-1);
         TreeInterface* tiR=makeBigTree(size-1);
         rootPtr = new Tree('+', tiL, tiR);
      }
      else{
         rootPtr = new Tree(1);
      }
      return rootPtr;
   }

