#ifndef _AND_STATEMENT_H
#define _AND_STATEMENT_H

#include "one_operand_statement.h"

class AndStatement: public OneOperandStatement
{
 public:
  AndStatement (const string& op);
  virtual ~AndStatement ();
  string toString () const;
};

inline AndStatement::AndStatement (const string& op): OneOperandStatement (op)
{
}

inline AndStatement::~AndStatement ()
{
}

inline string AndStatement::toString () const
{
  return "and " + getOp();
}

#endif
