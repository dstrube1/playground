#ifndef _CONTEXT_H
#define _CONTEXT_H

#include "symbol_table.h"
#include "generated_code.h"
#include "variable_exp.h"
#include "temp_var_factory.h"

class Context
{
 public:
  Context (SymbolTable& symbols, GeneratedCode& code);
  virtual ~Context();
  bool lookup (const string& s) const;
  void assign (VariableExp* e, bool value);
  void addCodeStatement (CodeStatement* stmt);
  string getTemp ();
  vector<CodeStatement*> getCode ();
 private:
  SymbolTable& table;
  GeneratedCode& code;
  TempVarFactory fac;
};

inline Context::Context (SymbolTable& symbols, GeneratedCode& code):
  table (symbols), code (code)
{
}

inline Context::~Context()
{
}

#endif
