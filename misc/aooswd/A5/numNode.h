//numNode.h - a node representing the value of a number

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef NUMNODE_H
#define NUMNODE_H

#include "node.h"

   class numNode:public Node{
   public:
      numNode(const int);
      ~numNode();
      int eval();
      string toString() const;
   private:
      int data;
   };

   inline numNode::numNode(const int d){
      data=d;
   }

   inline numNode::~numNode(){
   }

   inline int numNode::eval(){
      return data;
   }

   inline string numNode::toString() const{
   
      ostringstream outstr;
      outstr << data; 
      return outstr.str();
   
   }

#endif