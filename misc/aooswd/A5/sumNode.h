//sumNode.h - a binary operator node representing the sum of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef SUMNODE_H
#define SUMNODE_H

#include "binNode.h"

   class sumNode:public binNode{
   public:
      sumNode();
      ~sumNode();
      sumNode(TreeInterface*, TreeInterface*);
      int eval();
      string toString() const;
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

   inline int sumNode::eval(){
      return left->eval() + right->eval();
   }

   inline string sumNode::toString() const{
      return "("+  left->toString() + " + "+ right->toString()+")";
   }

#endif