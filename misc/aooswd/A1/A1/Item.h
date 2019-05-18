#ifndef ITEM_H
#define ITEM_H
#include <string>

   class Item{
   public:
      Item();
      Item( string p_code, double p );
      double getPrice();
      string getproductcode();

      /************************************************
      be sure to use const when appropriate - it helps correctness
      & improves readability of your code
      *************************************************/

   private:
      string product_code;
      double price;
   };

   inline Item :: Item(){
   }

   inline Item :: Item ( string p_code, double p){
      product_code = p_code;
      price = p;
   }
   inline double Item :: getPrice(){
      return price;
   }

   inline string Item :: getproductcode ()
   {
      return product_code;
   }

#endif

