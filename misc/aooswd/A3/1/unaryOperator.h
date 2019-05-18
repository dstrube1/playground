//unaryOperator.h
#ifndef UNARYOPERATOR_H
#define UNARYOPERATOR_H
#include "operator.h"

   class UnaryOperator: public Operator { 
   
   protected:
      Expression *child;
      void shallowCopy(Operator *src) { 
         *this = *(UnaryOperator *)src; } 
   
      void deepCopy(Operator *src) { 
      // Copy all non pointer data members 
      // shallowCopy(src); // None in our case! 
         child = ((UnaryOperator*)src)-> child->deepClone(); } 
   
   public: 
   
      UnaryOperator (Expression &e):
      child(e.deepClone()){
      }
      virtual UnaryOperator *fresh(void) const = 0; 
   };
#endif