#ifndef _CONSTANT_H
#define _CONSTANT_H

#include "boolean_exp.h"

class Constant: public BooleanExp
{
 public:
  Constant (bool value);
  virtual ~Constant();
  bool evaluate (Context& c);
  string generateCode (Context& c);
 private:
  bool value;
};

inline Constant::Constant (bool value): value (value)
{
}

inline Constant::~Constant()
{
}

inline bool Constant::evaluate (Context& c)
{
  return value;
}

#endif
