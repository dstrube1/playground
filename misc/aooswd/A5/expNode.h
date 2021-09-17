//expNode.h - a binary operator node representing the exponetiation of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef EXPNODE_H
#define EXPNODE_H

#include "binNode.h"
#include <math.h>


   class expNode:public binNode{
   public:
      expNode();
      expNode(TreeInterface*, TreeInterface*);
      ~expNode();
      int eval();
      string toString() const;
   private:
      TreeInterface* left;
      TreeInterface* right;
   };

   inline expNode::expNode(){
   }

   inline expNode::expNode(TreeInterface* l, TreeInterface* r){
      left=l;
      right=r;   
   }

   inline expNode::~expNode(){
   }

   inline int expNode::eval(){
      return int(pow(left->eval(), right->eval()));
   }

   inline string expNode::toString() const{
      return "("+  left->toString() + " ^ "+ right->toString()+")";
   }

#endif