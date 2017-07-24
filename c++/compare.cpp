#include <iostream>
#include <fstream.h>
#include <string>

   void main(){
   		/***********************
   		start things off, get stuff initialised
   		*************************/
      ifstream newfi ("new.htm");
      ifstream oldfi ("old.htm");
      string ntemp, otemp, mytemp;
   
   		/***********************
   		now the fun begins
   		*************************/
   
      while (getline(oldfi, otemp)){
         getline(newfi, ntemp);
         while (ntemp != otemp){
            // print out line from new till it equals line in old
            cout<<"this line is new:\n"<<ntemp<<endl;
            getline(newfi, ntemp);
         	getline(cin, mytemp);
         }
         if (ntemp == otemp) {//same line
         //leaving this here for future testing
         }
      
      }
      newfi.close();
      oldfi.close();
   
   }