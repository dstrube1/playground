#ifndef _BOOL_VALUE_H
#define _BOOL_VALUE_H

#include "value.h"

class BoolValue: public Value
{
 public:
  BoolValue (bool b);
  virtual ~BoolValue ();
  bool getValue () const;
 private:
  bool data;
};

inline BoolValue::BoolValue (bool b): data (b)
{
}

inline BoolValue::~BoolValue ()
{
}

inline bool BoolValue::getValue () const
{
  return data;
}

#endif
