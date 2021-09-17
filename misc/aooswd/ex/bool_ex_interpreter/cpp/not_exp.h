#ifndef _NOT_EXP_H
#define _NOT_EXP_H

#include "boolean_exp.h"

class NotExp: public BooleanExp
{
 public:
  NotExp (BooleanExp* child);
  virtual ~NotExp();
  bool evaluate (Context& c);
  string generateCode (Context& c);
 private:
  BooleanExp* child;
};

inline NotExp::NotExp (BooleanExp* child): child (child)
{
}

inline NotExp::~NotExp ()
{
}

inline bool NotExp::evaluate (Context& c)
{
  return !(child -> evaluate(c));
}

#endif
