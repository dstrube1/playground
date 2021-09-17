#ifndef _AND_EXP_H
#define _AND_EXP_H

#include "boolean_exp.h"

class AndExp: public BooleanExp
{
 public:
  AndExp (BooleanExp* left, BooleanExp* right);
  virtual ~AndExp();
  bool evaluate (Context& c);
  string generateCode (Context& c);
 private:
  BooleanExp* left;
  BooleanExp* right;
};

inline AndExp::AndExp (BooleanExp* left, BooleanExp* right): left (left),
     right (right)
{
}

inline AndExp::~AndExp ()
{
}

inline bool AndExp::evaluate (Context& c)
{
  return left -> evaluate(c) && right -> evaluate (c);
}

#endif
