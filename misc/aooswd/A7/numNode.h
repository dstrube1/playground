//numNode.h - a node representing the value of a number

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 7 - Visitor Pattern
***************/

#ifndef NUMNODE_H
#define NUMNODE_H

#include "node.h"

   class numNode:public Node{
   public:
      numNode(const int);
      ~numNode();
      void accept(TreeVisitor*);
      int getNum();
   private:
      int data;
   };

   inline numNode::numNode(const int d){
      data=d;
   }

   inline numNode::~numNode(){
   }

   inline void numNode::accept(TreeVisitor* tv){
      tv->visitNumNode(this);
      }

   inline int numNode::getNum(){
      return data;}

#endif