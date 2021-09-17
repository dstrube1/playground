//modNode.h - a binary operator node representing the modulussing of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef MODNODE_H
#define MODNODE_H

#include "binNode.h"


   class modNode:public binNode{
   
   public:
      modNode();
      modNode(TreeInterface*, TreeInterface*);
      ~modNode();
      int eval();
      string toString() const;
   private:
      TreeInterface* left;
      TreeInterface* right;
   };


   inline modNode::modNode(){
   
   }


   inline modNode::modNode(TreeInterface* l, TreeInterface* r){
   
      left=l;
      right=r;   
   }


   inline modNode::~modNode(){
   
   }


   inline int modNode::eval(){
   
      return left->eval() % right->eval();
   }


   inline string modNode::toString() const{
   
      return "("+  left->toString() + " % "+ right->toString()+")";
   }
#endif