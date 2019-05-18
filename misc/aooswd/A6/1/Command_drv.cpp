//command_drv.cpp
/***********
David Strube
CSIS4650-01
Spring 2003
Assignment 6
***********/

   using namespace std;
#include "glob.h"
#include <iostream>
#include <string>


   int main(int argc, char* argv[]){
      typedef Glob<int> IntGlob;
      IntGlob glub(50);
      int i = 1;
   //	string temp("");
   //	temp=(string)i;
   //	cout <<temp<<endl;
      while (glub.add(i++)){}
      cout<<"toString test:\n"<<glub.toString()<<endl;
   	
      string stopper;  
   
      //while (glub.remove(i)){}
      //cout<<"\nGlob emptied:"<<glub.toString()<<endl;
   
      cout<<"Hit enter to continue\n"; 
      getline(cin, stopper);
   
      return 0;
   }

