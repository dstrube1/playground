//terNode.h - a ternary operator node
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef TERNODE_H
#define TERNODE_H

#include "node.h"


   class terNode :public Node{
   public:
      terNode();
      virtual ~terNode()=0;
      virtual int eval() =0;
      virtual string toString() const=0;
   private:
      Node* midPtr;
   };


   terNode::terNode(){
   }


   terNode::~terNode(){
   }

#endif