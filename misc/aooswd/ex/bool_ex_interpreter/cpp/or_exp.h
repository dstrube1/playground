#ifndef _OR_EXP_H
#define _OR_EXP_H

#include "boolean_exp.h"

class Context;

class OrExp: public BooleanExp
{
 public:
  OrExp (BooleanExp* left, BooleanExp* right);
  virtual ~OrExp();
  bool evaluate (Context& c);
  string generateCode (Context& c);
 private:
  BooleanExp* left;
  BooleanExp* right;
};

inline OrExp::OrExp (BooleanExp* left, BooleanExp* right): left (left),
     right (right)
{
}

inline OrExp::~OrExp ()
{
}

inline bool OrExp::evaluate (Context& c)
{
  return left -> evaluate(c) || right -> evaluate (c);
}

#endif
