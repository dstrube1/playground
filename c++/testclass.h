#ifndef _testclass_h
#define _testclass_h

   class testclass{
   
   public:
      testclass();
      extern "C" __declspec(dllexport) void stuff();
   };
#endif
