//uplus.h
#ifndef UPLUS_H
#define UPLUS_H
#include "unaryOperator.h"
   class UPlus: public UnaryOperator { public: 
   
   UPlus(Expression &e): UnaryOperator(e) {} 
      UPlus *fresh(void) const { 
      
         return new UPlus; } }; 

#endif