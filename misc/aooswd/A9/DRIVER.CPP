//driver.cpp
/****************
David Strube            20/20
CSIS4650-01
Spring 2003
Assignment 9 - Builder Pattern
***************/

#include <iostream>
#include "AthenianDocBuilder.h" //includes Document, DocumentBuilder, and string
#include "TextParser.h"
#include "PCDocBuilder.h"
#include "TeenagerDocBuilder.h"
   int main(int argc, char* argv[]){
   	//ofstream otfi("out.txt");
      DocumentBuilder* db;
      if (argc <= 1){ //going back to athens...
         db = new AthenianDocBuilder;
      }
      else if (string (argv[1]) =="a"){
         db = new AthenianDocBuilder;
      }
      else if (string (argv[1]) =="p"){
         db = new PCDocBuilder;
      }
      else if (string (argv[1])=="t"){
         db = new TeenagerDocBuilder;
      }
   
      TextParser* tp = new TextParser(db);
      tp->reconstruct("in.txt");
      string temp=db->GetDocument();
      cout<<temp<<endl;
   
      return 0;}
