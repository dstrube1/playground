#ifndef _BEST_FIT_ALLOCATION_H
#define _BEST_FIT_ALLOCATION_H

#include "memory_allocation.h"

class BestFitAllocation: public MemoryAllocation
{
 public:
  BestFitAllocation ();
  virtual ~BestFitAllocation();
  void allocate (list<MemoryBlock>& l, int size);
};

inline BestFitAllocation::BestFitAllocation ()
{
}

inline BestFitAllocation::~BestFitAllocation ()
{
}

#endif
