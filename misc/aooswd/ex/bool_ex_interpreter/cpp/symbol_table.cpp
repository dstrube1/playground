#include "symbol_table.h"

void SymbolTable::setValue (const string& name, Value* v)
{
  int index = getIndexOf (name);
  table[index].setValue(v);
}

Value* SymbolTable::getValue (const string& name)
{
  int index = getIndexOf(name);
  return table[index].getValue();
}

int SymbolTable::getIndexOf (const string& name)
{
  int index = 0;
  while (index < table.size() && table[index].getName() != name)
    index++;
  return index;
}
