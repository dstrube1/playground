#include "variable_exp.h"
#include "or_exp.h"
#include "and_exp.h"
#include "constant.h"
#include "not_exp.h"
#include "symbol_table.h"
#include "bool_value.h"
#include "context.h"
#include <iostream>
#include <vector>

void displayCode (const vector<CodeStatement*> code);

void main ()
{
  VariableExp* x = new VariableExp ("X");
  VariableExp* y = new VariableExp ("Y");
  BooleanExp* expression = new OrExp 
    (new AndExp (new Constant (true), x), new AndExp (y, new NotExp (x)));
  SymbolTable table;
  SymbolData data1 ("X", new BoolValue (false));
  table.insert (data1);
  SymbolData data2 ("Y", new BoolValue (false));
  GeneratedCode code;
  Context c(table, code);
  c.assign (x, false);
  c.assign (y, true);
  string location = expression -> generateCode (c);
  vector<CodeStatement*> assmCode = c.getCode();
  displayCode (assmCode);
//   bool value = expression -> evaluate (c);
//   cout << "result is ";
//   if (value)
//     cout << "true" << endl;
//   else
//     cout << "false" << endl;
}

void displayCode (const vector<CodeStatement*> code)
{
  for (int i = 0; i < code.size(); i++)
    cout << code[i] -> toString() << endl;
}

