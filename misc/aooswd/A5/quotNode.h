//quotNode.h - a binary operator node representing the quotient of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef QUOTNODE_H
#define QUOTNODE_H

#include "binNode.h"

   class quotNode:public binNode{
   public:
      quotNode();
      ~quotNode();
      quotNode(TreeInterface*, TreeInterface*);
      int eval();
      string toString() const;
   private:
      TreeInterface* left;
      TreeInterface* right;
   };

   inline quotNode::quotNode(){
   }

   inline quotNode::quotNode(TreeInterface* l, TreeInterface* r){
      left=l;
      right=r;   
   }

   inline quotNode::~quotNode(){
   }

   inline int quotNode::eval(){
      return left->eval() / right->eval();
   }

   inline string quotNode::toString() const{
      return "("+  left->toString() + " / "+ right->toString()+")";
   }

#endif