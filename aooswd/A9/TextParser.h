//TextParser.h
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 9 - Builder Pattern
***************/

#ifndef TEXTPARSER_H
#define TEXTPARSER_H

#include <string>
#include <fstream>

   class TextParser{
   public: 
      TextParser(DocumentBuilder* doc);
      void reconstruct(string filename);
   private:
      DocumentBuilder* db;
   };

   inline TextParser::TextParser(DocumentBuilder* doc){
      db=doc;}

   inline void TextParser::reconstruct(string filename){
      ifstream infi(filename.c_str());
      string temp;
      while (infi>>temp){
         db->build(temp);
      }
   }

#endif