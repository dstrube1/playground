//TeenagerDocBuilder.h
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 9 - Builder Pattern
***************/

#ifndef TEENAGERDOCBUILDER_H
#define TEENAGERDOCBUILDER_H

#include "DocumentBuilder.h"
#include <ctype.h>

   class TeenagerDocBuilder : public DocumentBuilder
   
   {
   public:
      TeenagerDocBuilder();
      virtual ~TeenagerDocBuilder();
      virtual void build(string word);
      virtual string GetDocument();
   private:
      Document* currentDoc;
      string sentence_begin;
      string sentence_end;
      bool sentence_began;
   };

   inline TeenagerDocBuilder::TeenagerDocBuilder(){
      currentDoc=new Document;
      sentence_begin = "Like, ";
      sentence_end = ", you know?";
      sentence_began = true;
   }

   inline void TeenagerDocBuilder::build(string word){
      int temp;
      if (sentence_began){
         word[0]=tolower(word[0]);
         word = sentence_begin + word;
      }
   
      if (word.find(".") == word.size()-1) { 
         sentence_began = true;
         temp = word.find_first_of(".");
         word.replace(temp, 1, sentence_end);
      }
      else if (word.find("?") == word.size()-1) {
         sentence_began = true;
         temp = word.find_first_of("?");
         word.replace(temp, 1, sentence_end);
      }
      else if (word.find("!") == word.size()-1){
         sentence_began = true;
         temp = word.find_first_of("!");
         word.replace(temp, 1, sentence_end);
      }
      else 	sentence_began = false;
      currentDoc->append(word + " ");
   }
   inline string TeenagerDocBuilder::GetDocument(){
      return currentDoc->toString();}

   inline TeenagerDocBuilder::~TeenagerDocBuilder(){
      delete currentDoc;
   }

#endif

/*******************************************
same comment about inline functions
*******************************************/
