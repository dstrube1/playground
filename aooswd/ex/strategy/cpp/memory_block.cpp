#include "memory_block.h"

MemoryBlock::MemoryBlock (int l, int u) throw (AddressOrderException)
{
  if (l < 0 || u < l)
    throw AddressOrderException ("invalid memory block");
  lower = l;
  upper = u;
}

void MemoryBlock::setLower (int l) throw (AddressOrderException)
{
  if (l > upper)
    throw AddressOrderException ("invalid memory block");
  lower = l;
}

void MemoryBlock::setUpper (int u) throw (AddressOrderException)
{
  if (u < lower)
    throw AddressOrderException ("invalid memory block");
  upper = u;
}

ostream& operator << (ostream& out, const MemoryBlock& b)
{
  out << '[' << b.getLower() << ',' << b.getUpper() << ']';
}

