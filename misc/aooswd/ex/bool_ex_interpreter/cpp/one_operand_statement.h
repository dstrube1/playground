#ifndef _ONE_OPERAND_STATEMENT_H
#define _ONE_OPERAND_STATEMENT_H

#include "code_statement.h"
#include <string>

class OneOperandStatement: public CodeStatement
{
 public:
  OneOperandStatement (const string& op);
  virtual ~OneOperandStatement();
  string getOp () const;
 private:
  string op;
};

inline OneOperandStatement::OneOperandStatement (const string& op): op(op)
{
}

inline OneOperandStatement::~OneOperandStatement()
{
}

inline string OneOperandStatement::getOp () const
{
  return op;
}

#endif
