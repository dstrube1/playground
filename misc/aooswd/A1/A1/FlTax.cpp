# include "FlTax.h"

   FlTax::FlTax(){
      rate = 0.98;
      taxables.push_back("Golf pants");
      taxables.push_back("Metamucil");
   }

   bool FlTax::IsTaxable (string product){
      bool decide = false;
      int temp = taxables.size();
      for (int i = 0; i < temp ; i ++ )
      {
         if (product == taxables[i])
            decide = true;
      }
      return decide;
   }

   double FlTax::getRate(){
      return rate;
   }