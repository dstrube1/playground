//variable.h
#ifndef VARIABLE_H
#define VARIABLE_H
#include "operand.h"

   class Variable: public Operand { public: 
      Variable *fresh(void) const { 
      
         return new Variable; } 
   
      String v; 
   
   protected: 
      void copy(Operand *src) { 
         *this = *(Variable *)src; } 
   }; 


#endif