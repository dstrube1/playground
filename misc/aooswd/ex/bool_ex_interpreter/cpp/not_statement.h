#ifndef _NOT_STATEMENT_H
#define _NOT_STATEMENT_H

#include "code_statement.h"

class NotStatement: public CodeStatement
{
 public:
  NotStatement ();
  virtual ~NotStatement ();
  string toString () const;
};

inline NotStatement::NotStatement ()
{
}

inline NotStatement::~NotStatement ()
{
}

inline string NotStatement::toString () const
{
  return "not";
}

#endif
