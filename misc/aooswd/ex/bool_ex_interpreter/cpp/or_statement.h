#ifndef _OR_STATEMENT_H
#define _OR_STATEMENT_H

#include "one_operand_statement.h"

class OrStatement: public OneOperandStatement
{
 public:
  OrStatement (const string& op);
  virtual ~OrStatement ();
  string toString () const;
};

inline OrStatement::OrStatement (const string& op): OneOperandStatement (op)
{
}

inline OrStatement::~OrStatement ()
{
}

inline string OrStatement::toString () const
{
  return "or " + getOp();
}

#endif
