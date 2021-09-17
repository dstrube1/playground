#ifndef _DEVELOPER_H
#define _DEVELOPER_H

#include "employee.h"
#include <iostream>

class Developer: public Employee
{
 public:
  Developer ();
  void wisdom ();
};

inline Developer::Developer()
{
}

inline void Developer::wisdom ()
{
  cout << "what is leisure time?" << endl;
}

#endif
