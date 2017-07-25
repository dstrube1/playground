#ifndef _CODE_STATEMENT_H
#define _CODE_STATEMENT_H

class CodeStatement
{
 public:
  virtual ~CodeStatement();
  virtual string toString () const = 0;
 protected:
  CodeStatement();
};

inline CodeStatement::CodeStatement()
{
}

inline CodeStatement::~CodeStatement()
{
}

#endif
