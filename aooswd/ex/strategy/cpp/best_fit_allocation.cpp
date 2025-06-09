#include "best_fit_allocation.h"

void BestFitAllocation::allocate (list<MemoryBlock>& l, int size)
{
  success = false;
  if (!l.empty())
  {
    list<MemoryBlock>::iterator position = l.begin();
    list<MemoryBlock>::iterator best;
    while (position != l.end())
    {
      if (position -> size() >= size)
	if (!success)
	{
	  success = true;
	  best = position;
	}
	else if (position -> size() < best -> size())
	  best = position;
      position++;
    }
    if (success)
      allocateBlock (l, size, best);
  }
}

