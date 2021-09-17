#ifndef _EMPLOYEE_H
#define _EMPLOYEE_H

class Employee
{
 public:
  Employee();
  virtual void wisdom () = 0;
};

inline Employee::Employee()
{
}

#endif
