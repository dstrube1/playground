#ifndef _FIRST_FIT_ALLOCATION_H
#define _FIRST_FIT_ALLOCATION_H

#include "memory_allocation.h"

class FirstFitAllocation: public MemoryAllocation
{
 public:
  FirstFitAllocation ();
  virtual ~FirstFitAllocation();
  void allocate (list<MemoryBlock>& l, int size);
};

inline FirstFitAllocation::FirstFitAllocation ()
{
}

inline FirstFitAllocation::~FirstFitAllocation ()
{
}

#endif
