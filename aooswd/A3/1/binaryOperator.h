//binaryOperator.h
#ifndef BINARYOPERATOR_H
#define BINARYOPERATOR_H
#include "operator.h"

   class BinaryOperator: public Operator { public: 
      virtual BinaryOperator *fresh(void) const = 0; 
   protected: 
      Expression *left, *right; 
   
      void shallowCopy(Operator *src) { 
         *this = *(BinaryOperator *)src; } 
   
      void deepCopy(Operator *src) { 
      // Copy all non pointer data members 
      // shallowCopy(src); // None in our case! 
         left = ((BinaryOperator*)src)-> left->deepClone(); 
         right = ((BinaryOperator*)src)-> right->deepClone(); } 
   
   }; 
#endif