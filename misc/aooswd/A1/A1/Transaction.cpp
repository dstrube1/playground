#include "Transaction.h"

   Transaction::Transaction (){ 
   }

   Transaction::Transaction (Order* o, Tax* t){
      my_order = o;
      my_tax=t;
   }  

   double Transaction::get_tax(string product){
      bool taxable = my_tax -> IsTaxable(product);
      double rate = 0.00;
      if (taxable == true)
         rate = my_tax -> getRate();
      return rate;
   }

   double  Transaction::get_total(){
      vector <Order_Item> b= my_order -> getVector();
      Item temp;
      int tempqty = 0;
      int size = b.size();
      double total = 0.0;
      string product("");
      double temp_price, taxrate, subtotal, cost;
   
      for (int i = 0 ; i < size; i ++ )
      {
         temp = b[i].getItem();
         tempqty = b[i].getqty();
         product = temp.getproductcode();
         temp_price = temp.getPrice();
         taxrate = get_tax(product);
         subtotal = tempqty * temp_price;
         cost = subtotal + (subtotal * taxrate);
         total += cost;
      }
   
      return total ;
   } 


