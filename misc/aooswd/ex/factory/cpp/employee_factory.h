#ifndef _EMPLOYEE_FACTORY_H
#define _EMPLOYEE_FACTORY_H

#include "employee.h"

class EmployeeFactory
{
 public:
  EmployeeFactory();
  virtual Employee* create () = 0;
};

inline EmployeeFactory::EmployeeFactory ()
{
}

#endif
