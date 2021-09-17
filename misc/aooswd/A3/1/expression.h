//expression.h
#ifndef EXPRESSION_H
#define EXPRESSION_H
   class Expression { 
   public: 
      virtual Expression *fresh(void) const = 0;  
      virtual Expression *shallowClone(void) const = 0; 
      virtual Expression *deepClone(void) const = 0;
      Expression& operator +(void); 
      Expression& operator -(void); 
      Expression& operator +(Expression &e); 
      Expression& operator -(Expression &e); 
      Expression& operator *(Expression &e); 
      Expression& operator /(Expression &e); 
      Expression& pow(Expression &e); 
   };
#endif

