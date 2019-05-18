//http://www.sgi.com/tech/stl/basic_string.html
#include <iostream>
#include <fstream>
#include <string>
#include <map>
//
   void test1();
   void test2();
   void test3();
   int main(){
      //test1();
      test2();
      //test3();
      return 0;}

   void test1(){
      string word("blah, blow, Ah, Oh");
      char letter;
   
      map<char, string> replacements;
      replacements['a'] = "";
      replacements['o'] = "aw";
      replacements['A'] = "";
      replacements['O'] = "Aw";
   
      map<char, string>::iterator iter; 
      for (int i=0; i<word.size(); i++){
         letter=word[i];
         iter = replacements.begin();
         while (iter!=replacements.end()){
            if (letter==(*iter).first){
               word.replace(i, 1, (*iter).second);
            }
            iter++;
         }
      }
      cout<<word<<endl;
   }

   void test2(){
      string word="hola man\" men; Man, Men. hola";
      int temp;
   
      map<string, string> replacements;
      replacements["man"]="person";
      replacements["Man"]="Person";
      replacements["men"]="persons";
      replacements["Men"]="Persons";
   
      map<string, string>::iterator iter; 
      cout<<word<<endl;
      for (int i=0; i<word.size(); i++){
         //cout<<"i="<<i<<"\tword.size()="<<word.size()<<endl;
         iter = replacements.begin();
         while (iter!=replacements.end()){
            temp = word.find((*iter).first, i);
            if (temp != -1){
               //cout<<"found "<<(*iter).first<<" at "<<temp<<"\t replacing word at "<<temp
                  //<<", size 3 with "<<(*iter).second<<" size "<<(*iter).second.size()<<endl;
               //cout<<"\t B4:"<<word;
               word.replace(temp, 3, (*iter).second);//, (*iter).second.size());
               //cout<<"\tafter:"<<word<<endl;
               break;
            }
            iter++;
         }
      }
      cout<<word<<endl;
   }

   void test3(){
      string blah = "hola man";
      int temp = blah.find_first_of("man");
      cout<<temp<<endl;
      blah.replace(temp+2, 3, "person");
      cout <<blah<<endl;
   }