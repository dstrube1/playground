#ifndef _STORE_STATEMENT_H
#define _STORE_STATEMENT_H

#include "one_operand_statement.h"

class StoreStatement: public OneOperandStatement
{
 public:
  StoreStatement (const string& op);
  virtual ~StoreStatement ();
  string toString () const;
};

inline StoreStatement::StoreStatement (const string& op): 
  OneOperandStatement (op)
{
}

inline StoreStatement::~StoreStatement ()
{
}

inline string StoreStatement::toString () const
{
  return "store " + getOp();
}

#endif
