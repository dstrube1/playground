#ifndef ORDER_H
#define ORDER_H

#include <vector>

#include "Order_Item.h"

   class Order {
   public:
      Order();
      Order (vector <Order_Item> lst);
      vector <Order_Item> getVector();

      /**********************************************
      Be careful that your function signatures do not
      reveal the underlying data structure.
      *********************************************/

   private:
      vector <Order_Item> v;
   };

   inline Order::Order(){
   }

   inline Order::Order ( vector <Order_Item> lst ){
      v = lst;
   }

   inline vector <Order_Item> Order :: getVector(){
      return v;
   }


#endif