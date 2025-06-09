#include "not_exp.h"
#include "load_statement.h"
#include "not_statement.h"
#include "store_statement.h"
#include "context.h"

string NotExp::generateCode (Context& c)
{
  string childName = child -> generateCode (c);
  c.addCodeStatement (new LoadStatement (childName));
  c.addCodeStatement (new NotStatement ());
  string temp = c.getTemp();
  c.addCodeStatement (new StoreStatement (temp));
  return temp;
}

