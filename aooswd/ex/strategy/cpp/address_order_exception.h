#ifndef _ADDRESS_ORDER_EXCEPTION_H
#define _ADDRESS_ORDER_EXCEPTION_H

#include <stdexcept>

class AddressOrderException: public range_error
{
 public:
  AddressOrderException (const string& message);
};

inline AddressOrderException::AddressOrderException (const string& message):
  range_error (message)
{
}

#endif
