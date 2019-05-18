/*
	David Strube       18/20
	CSIS 4650
	Assignment # 1
*/

#include "Transaction.cpp"

/*******************************************************************
This needs to be avoided at all costs.  You are lucky that it happened
to work this time.
********************************************************************/

#include "GaFactory.h"
#include "FlFactory.h"

#include <vector>
#include <iostream>


   int main(int argc, char* argv[])
   {

      if (argc<=1)
         cout<<"Go back to Canada!\n";
      else{
      //create the tax
         TaxFactory* f;

         if (string (argv[1])=="Ga"||string (argv[1])=="ga"||string (argv[1])=="GA"||string (argv[1])=="gA"){
            f= new GaFactory;
         }
         else{ //if you aint from Joja, you must be from Floda
            f= new FlFactory;
         }

      	//create the tax
         Tax* taxi = f->create();

      	//set Items and Order
         vector <Order_Item> temp;
         Item I1 = Item("Golf pants", 100.00);
         Item I2 = Item("Metamucil", 150.00);
         Item I3 = Item("Cigarettes", 50.00);
         Item I4 = Item("Beer", 200.00);

         Order_Item one = Order_Item(I1 , 2);
         Order_Item two = Order_Item(I2 , 1);
         Order_Item three = Order_Item (I3 , 4);
         Order_Item four = Order_Item (I4, 1);

         temp.push_back(one);
         temp.push_back(two);
         temp.push_back(three);
         temp.push_back(four);

         Order* final = new Order(temp);

      	//create Transaction
         Transaction tran = Transaction(final, taxi);

      //output total
         cout<<"Based on your location, your grand total comes to..."<<tran.get_total()<<". Have a nice day\n";
      }
      return 0;

   }



