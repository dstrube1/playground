//constant.h
#ifndef CONSTANT_H
#define CONSTANT_H
#include "operand.h"

   class Constant: public Operand { public: 
      Constant *fresh(void) const { 
      
         return new Constant; } 
   
      Complex v; 
   
   protected: 
      void copy(Operand *src) { 
         *this = *(Constant *)src; } 
   
   
   
   }; 
#endif