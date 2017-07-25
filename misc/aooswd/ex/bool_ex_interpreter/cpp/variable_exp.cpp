#include "variable_exp.h"
#include "context.h"

bool VariableExp::evaluate (Context& c)
{
  return c.lookup (name);
}

