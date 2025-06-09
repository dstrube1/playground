//negNode.h - a unary operator node representing the negation of one node value

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef NEGNODE_H
#define NEGNODE_H

#include "unaNode.h"

   class negNode:public unaNode{
   public:
      negNode();
      negNode(TreeInterface*);
      ~negNode();
      int eval();
      string toString() const;
   private:
      TreeInterface* left;
   };

   inline negNode::negNode(){
   }

   inline negNode::negNode(TreeInterface* l){   
      left=l;
   }

   inline negNode::~negNode(){   
   }

   inline int negNode::eval(){
      return -(left->eval());
   }

   inline string negNode::toString() const{
      return "(-"+  left->toString()+")";
   }
#endif