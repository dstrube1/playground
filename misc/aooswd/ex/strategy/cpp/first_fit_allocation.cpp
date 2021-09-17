#include "first_fit_allocation.h"

void FirstFitAllocation::allocate (list<MemoryBlock>& l, int size)
{
  list<MemoryBlock>::iterator i = l.begin();
  while (i != l.end() && i -> size() < size)
    i++;
  success = i != l.end();
  if (success)
    allocateBlock (l, size, i);
}
