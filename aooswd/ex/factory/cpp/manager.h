#ifndef _MANAGER_H
#define _MANAGER_H

#include "employee.h"
#include <iostream>

class Manager: public Employee
{
 public:
  Manager ();
  void wisdom();
};

inline Manager::Manager()
{
}

inline void Manager::wisdom ()
{
  cout << "bring me a copy of the internet" << endl;
}

#endif
