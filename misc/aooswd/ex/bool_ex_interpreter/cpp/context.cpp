#include "context.h"
#include "bool_value.h"

bool Context::lookup (const string& s) const
{
  return table.getValue(s);
}

void Context::assign (VariableExp* e, bool value)
{
  table.setValue (e -> getName(), new BoolValue (value));
}

void Context::addCodeStatement (CodeStatement* stmt)
{
  code.add (stmt);
}

string Context::getTemp ()
{
  return fac.getTemp();
}

vector<CodeStatement*> Context::getCode ()
{
  return code.getGeneratedCode();
}

