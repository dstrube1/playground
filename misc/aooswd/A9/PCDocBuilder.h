//PCDocBuilder.h
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 9 - Builder Pattern
***************/

#ifndef PCDOCBUILDER_H
#define PCDOCBUILDER_H

#include "DocumentBuilder.h"
#include <map>

   class PCDocBuilder : public DocumentBuilder
   {
   public:
      PCDocBuilder();
      virtual ~PCDocBuilder();
      virtual void build(string word);
      virtual string GetDocument();
   private:
      Document* currentDoc;
      map<string, string> replacements;
   };

   inline PCDocBuilder::PCDocBuilder(){
      currentDoc= new Document;
      replacements["man"]="person";
      replacements["Man"]="Person";
      replacements["men"]="persons";
      replacements["Men"]="Persons";}

   inline void PCDocBuilder::build(string word){
      int temp;
      map<string, string>::iterator iter; 
      for (unsigned int i=0; i<word.size(); i++){
         iter = replacements.begin();
         while (iter!=replacements.end()){
            temp = word.find((*iter).first, i);
            if (temp != -1){
               word.replace(temp, 3, (*iter).second);//, (*iter).second.size());
               break;
            }
            iter++;
         }
      }
      currentDoc->append(word + " ");
   }
   inline string PCDocBuilder::GetDocument(){
      return currentDoc->toString();}


   inline PCDocBuilder::~PCDocBuilder(){
      delete currentDoc;
      delete &(replacements);}

#endif 

/********************
same comments
*********************/
