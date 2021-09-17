//uminus.h
#ifndef UMINUS_H
#define UMINUS_H
#include "unaryOperator.h"
class UMinus: public UnaryOperator { public: 
           
              
      UMinus *fresh(void) const { 
              
         return new UMinus; } };
			
#endif