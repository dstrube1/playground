//glob_drv.cpp      18/20
/***********
David Strube
CSIS4650-01
Spring 2003
Assignment 2
***********/

   using namespace std;
#include "glob.h"
#include <iostream>
#include <string>

template <class T>
   void test(Glob<T> glub, T v, char sort_type);
   void str_test(Glob<string> glub, string v, char sort_type);
template <class T>
   void test_main(Glob<T> glub, T v, char sort_type);	

   int main(int argc, char* argv[]){
      typedef Glob<float> FloatGlob;
      FloatGlob glubF(100);
   
      typedef Glob<int> IntGlob;
      IntGlob glubI(100);
   
      typedef Glob<char> CharGlob;
      CharGlob glubC(26);
   
      typedef Glob<string> StrGlob;
      StrGlob glubS(26);
   
      float f = 1.1;
      int i = 1;
      char c = 'a';
      string s = "aa";
      string temp;
   
      char sort_type;
      if (argc<=1)
         sort_type='b';
      else
         sort_type=argv[1][0];
      //cout<<sort_type<<endl;
      //cin>>temp;
   
      cout<<"Float test:\n";
      test(glubF, f, sort_type);
      cout<<"Integer test:\n";
      test(glubI, i, sort_type);
      cout<<"Char test:\n";
      test(glubC, c, sort_type);
      cout<<"String test:\n";
      str_test(glubS, s, sort_type);
   
      return 0;
   }

template <class T>
   void test(Glob<T> glub, T v, char sort_type){
      while (glub.add(v++)){}
      cout<<"Glob created:\n";
      glub.print();
   
      test_main(glub, v, sort_type);
   }

   void str_test(Glob<string> glub, string v, char sort_type){
      while (glub.add(v)){
         v[0]++;
      }
      cout<<"Glob created:\n";
      glub.print();
   
      test_main(glub, v, sort_type);
   }

template <class T>
   void test_main(Glob<T> glub, T v, char sort_type){
      string stopper;  
   
      glub.shuffle();
      cout<<"\nGlob shuffled:\n";
      glub.print();
   
      glub.sort(sort_type);
      cout<<"\nGlob sorted:\n";
      glub.print();
   
      while (glub.remove(v)){}
      cout<<"\nGlob emptied:";
      glub.print();
   
      cout<<"Hit enter to continue\n"; 
      getline(cin, stopper);
   }
