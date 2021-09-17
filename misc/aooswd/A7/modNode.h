//modNode.h - a binary operator node representing the modulussing of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 7 - Visitor Pattern
***************/

#ifndef MODNODE_H
#define MODNODE_H

#include "binNode.h"


   class modNode:public binNode{
   
   public:
      modNode();
      modNode(TreeInterface*, TreeInterface*);
      ~modNode();
      void accept(TreeVisitor*);
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


   inline void modNode::accept(TreeVisitor* tv){
      left->accept(tv);
      right->accept(tv);
   	tv->visitModNode();
   }
#endif