#ifndef _SYMBOL_DATA_H
#define _SYMBOL_DATA_H

#include <string>
#include "value.h"

class SymbolData
{
 public:
  SymbolData (const string& name, Value* v);
  virtual ~SymbolData();
  string getName () const;
  Value* getValue () const;
  void setValue (Value* v);
 private:
  string symbolName;
  Value* val;
};

inline SymbolData::SymbolData (const string& name, Value* v): 
  symbolName (name), val (v)
{
}

inline SymbolData::~SymbolData()
{
}

inline string SymbolData::getName () const
{
  return symbolName;
}

inline Value* SymbolData::getValue () const
{
  return val;
}

inline void SymbolData::setValue (Value* v)
{
  val = v;
}

#endif
