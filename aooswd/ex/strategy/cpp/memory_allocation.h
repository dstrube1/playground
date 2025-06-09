#ifndef _MEMORY_ALLOCATION_H
#define _MEMORY_ALLOCATION_H

#include "memory_block.h"
#include <list>

class MemoryAllocation
{
 public:
  MemoryAllocation();
  virtual ~MemoryAllocation();
  virtual void allocate (list<MemoryBlock>& l, int size) 
    throw (AddressOrderException) = 0;
  bool isSuccessful () const;
  MemoryBlock getAllocatedBlock () const;
 protected:
  bool success;
  MemoryBlock allocatedBlock;
  void allocateBlock (list<MemoryBlock>& l, int size,
		      list<MemoryBlock>::iterator position) 
    throw (AddressOrderException);
};

inline MemoryAllocation::MemoryAllocation(): allocatedBlock (0,0), 
     success (false)
{
}

inline MemoryAllocation::~MemoryAllocation()
{
}

inline bool MemoryAllocation::isSuccessful () const
{
  return success;
}

inline MemoryBlock MemoryAllocation::getAllocatedBlock () const
{
  return allocatedBlock;
}

#endif

