//operand.h
#ifndef OPERAND_H
#define OPERAND_H
#include "expression.h"

   class Operand: public Expression { 
   public: 
      virtual Operand *fresh(void) const = 0; 
   
      Operand *shallowClone(void) const { 
         return clone(); } 
      Operand *deepClone(void) const { 
         return clone(); } 
   
   private: 
      Operand *clone(void) const { 
         Operand *res = fresh(); res->copy(this); 
         return res; } 
   protected: virtual void copy(Operand *src) = 0;   
   };
#endif