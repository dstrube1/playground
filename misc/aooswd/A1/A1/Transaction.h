# ifndef TRANSACTION_H
# define TRANSACTION_H
#include "Tax.h"
#include "Order.h"
#include <string>

   class Transaction
   {
   public:
      Transaction();
      Transaction (Order* o, Tax* t);
      double get_tax(string product);
      double get_total();
   private:
      Tax* my_tax;
      Order* my_order;
   };

#endif


