//DocumentBuilder.h
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 9 - Builder Pattern
***************/

#ifndef DOCUMENTBUILDER_H
#define DOCUMENTBUILDER_H

#include "Document.h"
#include <string>

   class DocumentBuilder {
   public:
   
      virtual void build(string) { 
      }
      virtual string GetDocument() { 
         return ""; }
   
   protected:
      DocumentBuilder(){
      }
   private:
      Document* currentDoc;
   };

#endif