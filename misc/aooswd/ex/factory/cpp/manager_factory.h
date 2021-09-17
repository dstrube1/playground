#ifndef _MANAGER_FACTORY_H
#define _MANAGER_FACTORY_H

#include "employee_factory.h"
#include "manager.h"

class ManagerFactory: public EmployeeFactory
{
 public:
  ManagerFactory ();
  Employee* create ();
};

inline ManagerFactory::ManagerFactory ()
{
}

inline Employee* ManagerFactory::create ()
{
  return new Manager;
}

#endif
