//binNode.h - a binary operator node

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 7 - Visitor Pattern
***************/


#ifndef BINNODE_H
#define BINNODE_H

#include "node.h" 

   class binNode:public Node{
   public:
      binNode();
      virtual ~binNode()=0;
		virtual void accept(TreeVisitor*)=0;
         };

   inline binNode::binNode(){
   
   }

   inline binNode::~binNode(){
   
   }

#endif