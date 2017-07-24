#include <map>
#include <iostream>
#include <ctype.h>
   class rot13{
   
   public:
      //initializes the map
      rot13();
   	//given c, prints out c.rot(13)
      void shift(char c);
   private:
   	//oh my god!, who's got the map? 
   	//havent we been here before?... 
   	//it is the same tree...
      map<char,char> letters;
   };
   void main(){
      char a;
      rot13 rotter;
      while (cin>>a){
         rotter.shift(a);
         //putchar(~a-1/(~(a|32)/13*2-11)*13);
      
      }
   
   }
   rot13::rot13(){
      letters['a']='n';
      letters['b']='o';
      letters['c']='p';
      letters['d']='q';
      letters['e']='r';
      letters['f']='s';
      letters['g']='t';
      letters['h']='u';
      letters['i']='v';
      letters['j']='w';
      letters['k']='x';
      letters['l']='y';
      letters['m']='z';
      letters['n']='a';
      letters['o']='b';
      letters['p']='c';
      letters['q']='d';
      letters['r']='e';
      letters['s']='f';
      letters['t']='g';
      letters['u']='h';
      letters['v']='i';
      letters['w']='j';
      letters['x']='k';
      letters['y']='l';
      letters['z']='m';
   }
   void rot13::shift(char c){
   
      bool upper = false; //one who ups
      map<char, char>::iterator search;
   
      if (isupper(c)){ //this works
         upper=true;
         c=tolower(c);
      }
   
      //if(letters.find(c)){
      search= letters.find(c);
      c=search->second;
      if(upper)
         cout<<char(toupper(c));
      else
         cout<<c;
   }
