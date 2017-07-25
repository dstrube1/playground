#include "GaTax.h"

   GaTax::GaTax(){
      rate = 0.01;
      taxables.push_back("Cigarettes");
      taxables.push_back("Beer");
   }

   bool GaTax::IsTaxable (string product){
      bool decide = false;
      int temp = taxables.size();
      int i;
      for(i = 0 ; i < temp; i++)
      {
         if (product == taxables[i])
            decide = true;
      }
      return decide;
   }

   double GaTax::getRate(){
      return rate;
   }
