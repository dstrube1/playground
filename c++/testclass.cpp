#include "testclass.h"
#include <iostream>

extern "C" __declspec(dllexport)
   testclass::testclass(){
   }
   void testclass::stuff(){
      cout<<"Hey, it worked!\n";
   
   }
