#include "memory_allocation.h"

void MemoryAllocation::allocateBlock (list<MemoryBlock>& l, int size,
				      list<MemoryBlock>::iterator position) 
  throw (AddressOrderException)
{
  if (size == position -> size())
  {
    allocatedBlock = *position;
    l.erase (position);
  }
  else
  {
    int addr = position -> getLower();
    MemoryBlock temp (addr, addr + size - 1);
    allocatedBlock = temp;
    position -> setLower (addr + size);
  }
}

