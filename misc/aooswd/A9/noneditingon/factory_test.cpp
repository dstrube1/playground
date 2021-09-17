#include "manager_factory.h"
#include "employee_wisdom.h"
#include "developer_factory.h"
#include <iostream>
#include <string>

void main (int argc, char* argv[])
{
  if (argc <= 1)
    cout << "go back to Athens" << endl;
  else
  {
    EmployeeFactory* f;
    if (string (argv[1]) == "m")
      f = new ManagerFactory;
    else
      f = new DeveloperFactory;
    Employee* e = f -> create();
    EmployeeWisdom w;
    w.displayWisdom (e);
  }
}
