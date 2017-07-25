//diffNode.h - a binary operator node representing the difference of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/


#ifndef DIFFNODE_H
#define DIFFNODE_H

#include "binNode.h"

   class diffNode:public binNode{
   public:
      diffNode();
      ~diffNode();
      diffNode(TreeInterface*, TreeInterface*);
      int eval();
      string toString() const;
   private:
      TreeInterface* left;
      TreeInterface* right;
   };

   inline diffNode::diffNode(){
   }

   inline diffNode::diffNode(TreeInterface* l, TreeInterface* r){
      left=l;
      right=r;   
   }

   inline diffNode::~diffNode(){
   }

   inline int diffNode::eval(){
      return left->eval() - right->eval();
   }

   inline string diffNode::toString() const{
      return "("+  left->toString() + " - "+ right->toString()+")";
   }

#endif