#include "memory_manager.h"
#include "first_fit_allocation.h"
#include "best_fit_allocation.h"
#include "worst_fit_allocation.h"
#include "random_fit_allocation.h"

MemoryManager::MemoryManager (AllocationChoice choice): allocation (NULL)
{
  changeAllocation (choice);
  l.push_back (MemoryBlock (0, 9999));
}

void MemoryManager::displayMemory() const
{
  for (list<MemoryBlock>::const_iterator i = l.begin(); i != l.end(); i++)
    cout << *i << endl;
}

void MemoryManager::changeAllocation (AllocationChoice choice)
{
  MemoryAllocation* temp;
  if (choice == first)
    temp = new FirstFitAllocation;
  else if (choice == random)
    temp = new RandomFitAllocation;
  else if (choice = worst)
    temp = new WorstFitAllocation;
  else
    temp = new BestFitAllocation;
  if (allocation != NULL)
    delete allocation;
  allocation = temp;
}

void MemoryManager::deallocate (const MemoryBlock& block)
{
  list<MemoryBlock>::iterator position = l.begin();
  while (position != l.end() && block.getUpper() >= position -> getLower())
    position++;
  if (position == l.end())
    l.push_back (block);
  else
    insertBefore (position, block);
}

void MemoryManager::coalesceBoth (list<MemoryBlock>::iterator position)
{
  list<MemoryBlock>::iterator i = position;
  ++i;
  position -> setUpper (i -> getUpper());
  l.erase(i);
}

void MemoryManager::insertBefore (list<MemoryBlock>::iterator position, 
				  const MemoryBlock& b)
{
  if (position == l.begin())
    if (b.getUpper() + 1 == position -> getLower())
      coalesceFront (position, b);
    else
      l.push_front (b);
  else 
  {
    list<MemoryBlock>::iterator i = position;
    --i;
    if (b.getUpper() + 1 == position -> getLower())
      coalesceBoth (i);
    else
      coalesceRear (i, b);
  }
}

