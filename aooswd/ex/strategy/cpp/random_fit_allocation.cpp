#include "random_fit_allocation.h"
#include <cstdlib>
#include <ctime>

RandomFitAllocation::RandomFitAllocation (): hitLimit (6)
{
  srand(time(0));
}

void RandomFitAllocation::allocate (list<MemoryBlock>& l, int size)
{
  success = false;
  if (!l.empty())
  {
    list<MemoryBlock>::iterator position = l.begin();
    list<MemoryBlock>::iterator choice;
    int numHits = 0;
    int maxHits = 1 + rand() % (hitLimit + 1);
    while (position != l.end() && numHits < maxHits)
    {
      if (position -> size() >= size)
      {
	numHits++;
	if (!success)
	{
	  success = true;
	  choice = position;
	}
	else if (position -> size() < choice -> size())
	  choice = position;
      }
      position++;
      if (success)
	allocateBlock (l, size, choice);
    }
  }
}
