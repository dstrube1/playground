#ifndef Tax_FACTORY_H
#define Tax_FACTORY_H

#include "Tax.h"

   class TaxFactory{
   public:
      TaxFactory();
      virtual Tax* create () = 0;
   };
   inline TaxFactory::TaxFactory ()
   {
   }
#endif
