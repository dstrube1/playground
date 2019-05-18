
#include "Tree.h"   // 20/20
#include "TreeEvalVisitor.h"
#include "TreeStringVisitor.h"
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
      TreeVisitor* T13e = new TreeEvalVisitor(T13);
      result=T13e->eval();
      TreeVisitor* T13s = new TreeStringVisitor(T13);
      cout<<T13s->toString()<<": ";
      cout<<"result = "<<result<<endl;
      cout<<"Which is the same as saying :\n"<<T13s->toMorganString()<<endl<<endl;

      TreeInterface* T14=makeBigTree(size);
      TreeVisitor* T14e=new TreeEvalVisitor(T14);
      result=T14e->eval();
      TreeVisitor* T14s = new TreeStringVisitor(T14);
      cout<<T14s->toString()<<": ";
      cout<<"result = "<<result<<endl;

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
