#ifndef _VALUE_H
#define _VALUE_H

class Value
{
 public:
  virtual ~Value ();
 protected:
  Value();
};

inline Value::Value ()
{
}

inline Value::~Value()
{
}

#endif
