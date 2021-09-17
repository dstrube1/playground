#ifndef GA_FACTORY_H
#define GA_FACTORY_H

#include "Tax.h"
#include "GaTax.cpp"
#include "TaxFactory.h"

   class GaFactory: public TaxFactory{
   public:
      GaFactory ();
      Tax* create ();
   };

   inline GaFactory::GaFactory(){
   }

   inline Tax* GaFactory::create(){
      return new GaTax();
   }

#endif
