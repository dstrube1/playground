#include "ccc_win.cpp" 
#include <iostream>

   int r_c();
   int r_l();

   int main() 
   {
      cwin.coord(0,0,24,24);
   
      srand(time(NULL));
   
      Point a,b;
   
      for (int i=0; i<20000; i++){
         cwin.SetDrawColor(r_c(),r_c(),r_c()); 
         a=Point(r_l(),r_l());
         b=Point(r_l(),r_l());
         cwin<<Line(a,b);
         //cout<<"delay\n";
      }
      return 0;
   }

   int r_c (){
      int rndm = rand() % 256;
      return rndm;
   }
   int r_l (){
      int rndm = rand() % 25;
      return rndm;
   }