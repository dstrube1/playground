#include <iostream>
#include <fstream>
#include <string>
           
   int main(){
           
      ifstream infi ("in.txt");
      ofstream outfi ("AllStu.txt");
      string temp;
      int lines=0;
      cout<<"this many lines: \n";
      while (getline (infi, temp)){
         if (temp.substr(0,2)=="Lo"){
           outfi<<temp<<endl;
         }
         cout<<".";
         lines++;
      }
		
      cout<<endl<<lines<<"\nHit enter to end";
      getline(cin, temp);
      return 0;
   }