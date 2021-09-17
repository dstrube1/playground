#include "memory_interface.h"

void main ()
{
  try
  {
    MemoryInterface memory (first);
    memory.displayMemory();
    memory.allocate(40);
    MemoryBlock b1 = memory.getAllocatedBlock();
    memory.displayMemory();
    memory.allocate(16);
    MemoryBlock b2 = memory.getAllocatedBlock();
    memory.displayMemory();
    memory.deallocate (b1);
    memory.displayMemory();
    memory.deallocate(b2);
    memory.displayMemory();
  }
  catch (AddressOrderException e)
  {
    cout << e.what();
  }
}
