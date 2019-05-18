//prodNode.h - a binary operator node representing the product of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef PRODNODE_H
#define PRODNODE_H

#include "binNode.h"

   class prodNode:public binNode{
   public:
      prodNode();
      ~prodNode();
      prodNode(TreeInterface*, TreeInterface*);
      int eval();
      string toString() const;
   private:
      TreeInterface* left;
      TreeInterface* right;
   };

   inline prodNode::prodNode(){
   }

   inline prodNode::prodNode(TreeInterface* l, TreeInterface* r){
      left=l;
      right=r;   
   }

   inline prodNode::~prodNode(){
   }

   inline int prodNode::eval(){
      return left->eval() * right->eval();
   }

   inline string prodNode::toString() const{
      return "("+  left->toString() + " * "+ right->toString()+")";
   }

#endif