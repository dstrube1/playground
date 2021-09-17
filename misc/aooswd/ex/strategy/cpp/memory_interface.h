#ifndef _MEMORY_INTERFACE_H
#define _MEMORY_INTERFACE_H

#include "memory_manager.h"

class MemoryInterface
{
 public:
  MemoryInterface (AllocationChoice choice);
  virtual ~MemoryInterface();
  void allocate (int size) throw (AddressOrderException);
  void deallocate (const MemoryBlock& b) throw (AddressOrderException);
  void displayMemory() const;
  void changeAllocation (AllocationChoice choice);
  bool isSuccessful () const;
  MemoryBlock getAllocatedBlock () const;
 private:
  MemoryManager manager;
};

inline MemoryInterface::MemoryInterface (AllocationChoice choice): 
  manager(choice)
{
}

inline MemoryInterface::~MemoryInterface()
{
}

inline void MemoryInterface::allocate (int size) throw (AddressOrderException)
{
  manager.allocate (size);
}

inline void MemoryInterface::deallocate (const MemoryBlock& b) 
     throw (AddressOrderException)
{
  manager.deallocate (b);
}

inline void MemoryInterface::displayMemory() const
{
  manager.displayMemory();
}

inline void MemoryInterface::changeAllocation (AllocationChoice choice)
{
  manager.changeAllocation (choice);
}

inline bool MemoryInterface::isSuccessful () const
{
  return manager.isSuccessful();
}

inline MemoryBlock MemoryInterface::getAllocatedBlock () const
{
  return manager.getAllocatedBlock();
}

#endif
