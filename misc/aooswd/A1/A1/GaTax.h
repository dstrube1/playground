#ifndef GATAX_H
#define GATAX_H

#include "Tax.h"
#include <vector>
#include <string>

   class GaTax: public Tax{
   public:
      GaTax ();
      bool IsTaxable(string product);
      double getRate();
   private:
      double rate;
      vector <string> taxables;
   };

#endif
