#ifndef _RANDOM_FIT_ALLOCATION_H
#define _RANDOM_FIT_ALLOCATION_H

#include "memory_allocation.h"

class RandomFitAllocation: public MemoryAllocation
{
 public:
  RandomFitAllocation ();
  virtual ~RandomFitAllocation();
  void allocate (list<MemoryBlock>& l, int size);
 private:
  const int hitLimit;
};

inline RandomFitAllocation::~RandomFitAllocation ()
{
}

#endif
