#ifndef FLTAX_H
#define FLTAX_H

#include "Tax.h"
#include <string>
#include <vector>

   class FlTax: public Tax{
   public:
      FlTax();
      bool IsTaxable(string product);
      double getRate();
   private:
      double rate;
      vector <string> taxables;
   };

#endif