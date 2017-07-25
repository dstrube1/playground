#ifndef _WORST_FIT_ALLOCATION_H
#define _WORST_FIT_ALLOCATION_H

#include "memory_allocation.h"

class WorstFitAllocation: public MemoryAllocation
{
 public:
  WorstFitAllocation ();
  virtual ~WorstFitAllocation();
  void allocate (list<MemoryBlock>& l, int size);
};

inline WorstFitAllocation::WorstFitAllocation ()
{
}

inline WorstFitAllocation::~WorstFitAllocation ()
{
}

#endif
