#include "constant.h"

string Constant::generateCode (Context& c)
{
  string s = "#";
  if (value)
    s += "true";
  else
    s += "false";
  return s;
}


