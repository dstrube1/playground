#ifndef _BOOLEAN_EXP_H
#define _BOOLEAN_EXP_H

#include <string>

class Context;

class BooleanExp
{
 public:
  BooleanExp ();
  virtual ~BooleanExp();
  virtual bool evaluate (Context& c) = 0;
  virtual string generateCode (Context& c) = 0;
};

inline BooleanExp::BooleanExp()
{
}

inline BooleanExp::~BooleanExp()
{
}

#endif
