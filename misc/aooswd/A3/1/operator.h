//operator.h
#ifndef OPERATOR_H
#define OPERATOR_H
#include "expression.h"

   class Operator: public Expression { public: 
   
      virtual Operator *fresh(void) const = 0; 
   
      Expression *shallowClone(void) const { 
         Expression *res = fresh(); 
         res->shallowCopy(this); 
         return res; } 
   
      Expression *deepClone(void) const { 
         Expression *res = fresh(); 
         res->deepCopy(this); 
         return res; } 
   
   protected: 
      virtual void deepCopy(Operator *src) = 0; 
      virtual void shallowCopy(Operator *src) = 0; 
   }; 



#endif