#ifndef ORDER_ITEM_H
#define ORDER_ITEM_H

#include "Item.h"

   class Order_Item{
   public:
      Order_Item();
      Order_Item( Item i, int q);
      Item getItem();
      int getqty();
   private:
      Item item;
      int qty;
   };

   inline Order_Item :: Order_Item(){ 
   } 
   inline Order_Item :: Order_Item ( Item i, int q){
      item = i;
      qty = q;
   }

   inline Item Order_Item :: getItem (){
      return item;
   }

   inline int Order_Item :: getqty(){
      return qty;
   }
#endif 
