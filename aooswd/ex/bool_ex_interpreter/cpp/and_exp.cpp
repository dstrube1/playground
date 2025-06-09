#include "and_exp.h"
#include "load_statement.h"
#include "and_statement.h"
#include "store_statement.h"
#include "context.h"

string AndExp::generateCode (Context& c)
{
  string leftName = left -> generateCode (c);
  string rightName = right -> generateCode (c);
  c.addCodeStatement (new LoadStatement (leftName));
  c.addCodeStatement (new AndStatement (rightName));
  string temp = c.getTemp();
  c.addCodeStatement (new StoreStatement (temp));
  return temp;
}
