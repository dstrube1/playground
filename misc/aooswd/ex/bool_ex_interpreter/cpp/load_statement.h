#ifndef _LOAD_STATEMENT_H
#define _LOAD_STATEMENT_H

#include "one_operand_statement.h"

class LoadStatement: public OneOperandStatement
{
 public:
  LoadStatement (const string& op);
  virtual ~LoadStatement ();
  string toString () const;
};

inline LoadStatement::LoadStatement (const string& op): 
  OneOperandStatement (op)
{
}

inline LoadStatement::~LoadStatement ()
{
}

inline string LoadStatement::toString () const
{
  return "load " + getOp();
}

#endif
