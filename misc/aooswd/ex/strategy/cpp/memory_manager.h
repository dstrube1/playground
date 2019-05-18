#ifndef _MEMORY_MANAGER_H
#define _MEMORY_MANAGER_H

#include "memory_allocation.h"

enum AllocationChoice {best, first, random, worst};

class MemoryManager
{
 public:
  MemoryManager(AllocationChoice choice);
  virtual ~MemoryManager();
  void allocate (int size) throw (AddressOrderException);
  void displayMemory() const;
  void changeAllocation (AllocationChoice choice);
  void deallocate (const MemoryBlock& block);
  MemoryBlock getAllocatedBlock() const;
  bool isSuccessful() const;
 private:
  list<MemoryBlock> l;
  MemoryAllocation* allocation;
  void coalesceFront (list<MemoryBlock>::iterator position, 
		      const MemoryBlock& b) throw (AddressOrderException);
  void coalesceRear (list<MemoryBlock>::iterator position, 
		      const MemoryBlock& b) throw (AddressOrderException);
  void coalesceBoth (list<MemoryBlock>::iterator position);
  void insertBefore (list<MemoryBlock>::iterator position, 
		      const MemoryBlock& b);
};

inline MemoryManager::~MemoryManager()
{
  delete allocation;
}

inline MemoryBlock MemoryManager::getAllocatedBlock () const
{
  return allocation -> getAllocatedBlock();
}

inline bool MemoryManager::isSuccessful() const
{
  return allocation -> isSuccessful();
}

inline void MemoryManager::allocate (int size) throw (AddressOrderException)
{
  allocation -> allocate (l, size);
}

inline void MemoryManager::coalesceFront (list<MemoryBlock>::iterator position,
					  const MemoryBlock& b) 
     throw (AddressOrderException)
{
  position -> setLower(b.getLower());
}

inline void MemoryManager::coalesceRear (list<MemoryBlock>::iterator position, 
					 const MemoryBlock& b)
     throw (AddressOrderException)
{
  position -> setUpper (b.getUpper());
}

#endif
