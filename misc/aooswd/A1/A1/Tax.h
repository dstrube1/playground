#ifndef TAX_H
#define TAX_H

#include <string>

   class Tax{
   public:
      Tax();
      virtual ~Tax() =0;
      virtual bool IsTaxable (string product) = 0;
      virtual double getRate() = 0;
   };
   inline Tax :: Tax(){
   }

   inline Tax::~Tax(){
   }

 #endif