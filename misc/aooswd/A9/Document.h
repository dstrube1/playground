//Document.h
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 9 - Builder Pattern
***************/

#ifndef DOCUMENT_H
#define DOCUMENT_H

#include <string>

   class Document{
   public:
      Document();
   //string toString(); //guess we don't really need one of these if we're making the data public
      void append (string input);
      string toString () const;
   private:
      string text;
   };

   inline Document::Document(){
      text="";
   }

   inline void Document::append(string input){
      text+=input;
   }

   inline string Document::toString() const {
      return text;}

#endif