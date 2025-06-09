#ifndef FL_FACTORY_H
#define FL_FACTORY_H

#include "FlTax.cpp"
#include "Tax.h"
#include "TaxFactory.h"
   class FlFactory: public TaxFactory{
   public:
      FlFactory ();
      Tax* create ();	
   };

   inline FlFactory::FlFactory (){
   }

   inline Tax* FlFactory::create(){
      return new FlTax();
   }
#endif