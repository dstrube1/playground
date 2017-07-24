#include <iostream>
#include <fstream>
#include <string>
   int main(){
      ifstream infi ("in.txt");
      ofstream outfi ("out.txt");
      string temp;
      int lines=0;
      cout<<"this many lines: \n";
      while (getline (infi, temp)){
         if (temp.substr(0,1)=="0"||temp.substr(0,1)=="7"||temp.substr(0,1)=="8"||temp.substr(0,1)=="9"){
            temp.resize(42);
            outfi<<temp<<endl;
         }
         cout<<".";
         lines++;
      }
      cout<<endl<<lines<<"\nHit enter to end";
      getline(cin, temp);
      return 0;
   }