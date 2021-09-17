//sumNode.h - a binary operator node representing the sum of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 7 - Visitor Pattern
***************/

#ifndef SUMNODE_H
#define SUMNODE_H

#include "binNode.h"

   class sumNode:public binNode{
   public:
      sumNode();
      ~sumNode();
      sumNode(TreeInterface*, TreeInterface*);
      void accept(TreeVisitor*);
   private:
      TreeInterface* left;
      TreeInterface* right;
   };

   inline sumNode::sumNode(){
   }

   inline sumNode::sumNode(TreeInterface* l, TreeInterface* r){
      left=l;
      right=r;   
   }

   inline sumNode::~sumNode(){
   }

   inline void sumNode::accept(TreeVisitor* tv){
      left->accept(tv);
      right->accept(tv);
   	tv->visitSumNode();
   }
	
#endif