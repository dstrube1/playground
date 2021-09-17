//TreeDecorator.h
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef TREEDECORATOR_H
#define TREEDECORATOR_H
//#include <iostream>

#include "TreeInterface.h"

   class TreeDecorator:public TreeInterface{
   protected:
      TreeDecorator(); 
   public :
      TreeDecorator(TreeInterface*); 
      virtual int eval();
      virtual string toString() const;
   private: 
      TreeInterface* mytree;
   };

   inline TreeDecorator::TreeDecorator(){
      mytree=0;
   }

   inline TreeDecorator::TreeDecorator(TreeInterface* t){
      mytree= t;
   }

   inline int TreeDecorator::eval() {
   
      return mytree->eval();
   }

   inline string TreeDecorator::toString() const{
      return mytree->toString();
   }

#endif