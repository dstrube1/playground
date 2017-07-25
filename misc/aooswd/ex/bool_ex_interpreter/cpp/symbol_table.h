#ifndef _SYMBOL_TABLE_H
#define _SYMBOL_TABLE_H

#include <vector>
#include "symbol_data.h"

class SymbolTable
{
 public:
  SymbolTable ();
  virtual ~SymbolTable ();
  void insert (const SymbolData& data);
  void setValue (const string& name, Value* v);
  Value* getValue (const string& name);
 private:
  vector<SymbolData> table;
  int getIndexOf (const string& name);
};

inline SymbolTable::SymbolTable ()
{
}

inline SymbolTable::~SymbolTable ()
{
}

inline void SymbolTable::insert (const SymbolData& data)
{
  table.push_back (data);
}

#endif
