#ifndef _VARIABLE_EXP_H
#define _VARIABLE_EXP_H

#include <string>
#include "boolean_exp.h"

class VariableExp: public BooleanExp
{
 public:
  VariableExp (const string& lexeme);
  virtual ~VariableExp();
  bool evaluate (Context& c);
  string generateCode (Context& c);
  string getName() const;
 private:
  string name;
};

inline VariableExp::VariableExp (const string& lexeme): name (lexeme)
{
}

inline VariableExp::~VariableExp()
{
}

inline string VariableExp::getName () const
{
  return name;
}

inline string VariableExp::generateCode (Context& c)
{
  return name;
}

#endif
