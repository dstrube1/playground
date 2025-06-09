#ifndef _DEVELOPER_FACTORY_H
#define _DEVELOPER_FACTORY_H

#include "employee_factory.h"
#include "developer.h"

class DeveloperFactory: public EmployeeFactory
{
 public:
  DeveloperFactory ();
  Employee* create ();
};

inline DeveloperFactory::DeveloperFactory ()
{
}

inline Employee* DeveloperFactory::create()
{
  return new Developer;
}

#endif
