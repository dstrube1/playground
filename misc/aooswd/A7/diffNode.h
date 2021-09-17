//diffNode.h - a binary operator node representing the difference of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 7 - Visitor Pattern
***************/


#ifndef DIFFNODE_H
#define DIFFNODE_H

#include "binNode.h"

   class diffNode:public binNode{
   public:
      diffNode();
      ~diffNode();
      diffNode(TreeInterface*, TreeInterface*);
      void accept(TreeVisitor*);
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

   inline void diffNode::accept(TreeVisitor* tv){
      left->accept(tv);
      right->accept(tv);
   	tv->visitDiffNode();
   }
#endif