//posNode.h - a unary operator node representing the positifying of a node value

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef POSNODE_H
#define POSNODE_H

#include "unaNode.h"

   class posNode:public unaNode{
   public:
      posNode();
      ~posNode();
      posNode(TreeInterface*);
      int eval();
      string toString() const;
   private:
      TreeInterface* left;
   };

   inline posNode::posNode(){
   }

   inline posNode::posNode(TreeInterface* l){
      left=l;
   }

   inline posNode::~posNode(){
   }

   inline int posNode::eval(){
      return left->eval();
   }

   inline string posNode::toString() const{
      return "(+"+  left->toString()+")";
   }

#endif