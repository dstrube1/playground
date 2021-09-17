//unaNode.h - a unary operator node
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef UNANODE_H
#define UNANODE_H

#include "node.h"

   class unaNode:public Node{
   public:
      unaNode();
      virtual ~unaNode()=0;
      virtual int eval() =0;
      virtual string toString() const=0;
   };

   inline unaNode::unaNode(){
   }

   inline unaNode::~unaNode(){
   }

#endif