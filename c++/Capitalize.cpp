//#include <iostream>
#include <fstream>
#include <string>
//#include <ctype.h>

   int main(){
   
      ifstream infi ("in.txt");
      ofstream outfi ("out.txt");
      string temp;
      while (getline (infi, temp)){
         temp[0]=toupper(temp[0]);
         for (unsigned int i=1; i<temp.length(); i++)
            temp[i]=tolower(temp[i]);
         outfi<<temp<<endl;
      }
   
      return 0;
   }