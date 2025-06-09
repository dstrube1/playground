#include "worst_fit_allocation.h"

void WorstFitAllocation::allocate (list<MemoryBlock>& l, int size)
{
  success = false;
  if (!l.empty())
  {
    list<MemoryBlock>::iterator position = l.begin();
    list<MemoryBlock>::iterator worst;
    while (position != l.end())
    {
      if (position -> size() >= size)
	if (!success)
	{
	  success = true;
	  worst = position;
	}
	else if (position -> size() > worst -> size())
	  worst = position;
      position++;
    }
    if (success)
      allocateBlock (l, size, worst);
  }
}

