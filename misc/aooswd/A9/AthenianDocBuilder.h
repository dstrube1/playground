//AthenianDocBuilder.h
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 9 - Builder Pattern
***************/

#ifndef ATHENIANDOCBUILDER_H
#define ATHENIANDOCBUILDER_H

#include "DocumentBuilder.h"
#include <map>

   class AthenianDocBuilder : public DocumentBuilder
   {
   public:
      AthenianDocBuilder();
      virtual ~AthenianDocBuilder();
      virtual void build(string word);
      virtual string GetDocument();
   private:
      Document* currentDoc;
      map<char, string> replacements;
   };

   inline AthenianDocBuilder::AthenianDocBuilder(){
      currentDoc=new Document;
   
      replacements['a'] = "";
      replacements['o'] = "aw";
      replacements['A'] = "";
      replacements['O'] = "Aw";
   }

   inline void AthenianDocBuilder::build(string word){
      char letter;
      map<char, string>::iterator iter;
      for (unsigned int i=0; i<word.size(); i++){
         letter = word[i];
         iter = replacements.begin();
         while (iter!=replacements.end()){
            if (letter==(*iter).first){
               word.replace(i, 1, (*iter).second);
               break;

/*****************************************
This is very poor style.  You need to reconsider
your loop structure.
*****************************************/
            }
            iter++;
         }
      }
      currentDoc->append(word +" ");
   }

   inline string AthenianDocBuilder::GetDocument(){
      return currentDoc->toString();}

   inline AthenianDocBuilder::~AthenianDocBuilder(){
      delete currentDoc;
      delete &(replacements);}

#endif

/***************************************************
You are severely abusing the inline capabilities.
Are you just trying to avoid makefiles?
***************************************************/
