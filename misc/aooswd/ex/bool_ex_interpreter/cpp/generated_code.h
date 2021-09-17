#ifndef _GENERATED_CODE_H
#define _GENERATED_CODE_H

#include <vector>
#include "code_statement.h"

class GeneratedCode
{
 public:
  GeneratedCode ();
  virtual ~GeneratedCode ();
  void add (CodeStatement* stmt);
  vector<CodeStatement*> getGeneratedCode () const;
 private:
  vector<CodeStatement*> code;
};

inline GeneratedCode::GeneratedCode ()
{
}

inline GeneratedCode::~GeneratedCode ()
{
}

inline void GeneratedCode::add (CodeStatement* stmt)
{
  code.push_back (stmt);
}

inline vector<CodeStatement*> GeneratedCode::getGeneratedCode () const
{
  return code;
}
 
#endif
