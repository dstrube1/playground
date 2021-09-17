//binNode.h - a binary operator node

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/


#ifndef BINNODE_H
#define BINNODE_H

#include "node.h" 

   class binNode:public Node{
   public:
      binNode();
      virtual ~binNode()=0;
      virtual int eval()=0;
      virtual string toString() const=0;
   };

   inline binNode::binNode(){
   
   }

   inline binNode::~binNode(){
   
   }

#endif