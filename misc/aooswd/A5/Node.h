//node.h 
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef NODE_H
#define NODE_H

#include <string>
#include <sstream>


   class Node{
   public:
      Node (); 
      virtual ~Node();
      virtual int eval ()=0;
      virtual string toString() const =0;
   };


   inline Node::Node(){
   }


   inline Node::~Node(){
   
   }

#endif
