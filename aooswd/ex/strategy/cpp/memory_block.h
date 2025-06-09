#ifndef _MEMORY_BLOCK_H
#define _MEMORY_BLOCK_H

#include <string>
#include "address_order_exception.h"

class MemoryBlock
{
 public:
  MemoryBlock (int l, int u) throw (AddressOrderException);
  virtual ~MemoryBlock();
  int getLower() const;
  int getUpper() const;
  void setLower (int l) throw (AddressOrderException);
  void setUpper (int u) throw (AddressOrderException);
  int size() const;
 private:
  int lower;
  int upper;
};

ostream& operator << (ostream& out, const MemoryBlock& b);

inline MemoryBlock::~MemoryBlock ()
{
}

inline int MemoryBlock::getLower () const
{
  return lower;
}

inline int MemoryBlock::getUpper () const
{
  return upper;
}

inline int MemoryBlock::size () const
{
  return upper - lower + 1;
}

#endif
