//david strube
//2003-07-23-933pm
//quick-and-dirty easy making of a simple index html file - display clickable index

//anchor tag format : <a href="filename"><img src=filename h=... w=....></a>

#include<iostream>
#include <fstream>
#include <string>

   int main(){
      string h = " height=75";
      string w = " width=150";
      string alt = " alt=\" comment \" ";
      string bfn=""; //begin filename
   	string efn =".jpg";
      string bat = "<a href=\""; //begin anchor tag
      string bit = "<img src=\"";
   	ofstream of("clickable_index.htm");
   
   	//string eit = ""; //not necessary right now
   
      of<<"<html><head></head><body bgcolor=black>\n";
      for (int i=1; i<57; i++){
         if (i<10)
            bfn= "s_n_iraq0";
         else 
            bfn= "s_n_iraq";
      
         of<<bat<<bfn<<i<<efn<<"\"> "<<bit<<bfn<<i<<efn<<"\""<<h<<w<<alt<<"></a>"<<endl;
      
         if (i%6==0)
            of<<"<br>\n";
      }
      of<<"</body></html>";
      return 0;}