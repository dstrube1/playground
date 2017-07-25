//unaNode.h - a unary operator node
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/

#ifndef UNANODE_H
#define UNANODE_H

#include "node.h"

template <class NODETYPE>
   class unaNode:public Node<NODETYPE>{
   public:
      unaNode();
      virtual ~unaNode()=0;
      virtual NODETYPE eval() const=0;
      virtual void print() const=0;
   };

template <class NODETYPE>
   inline unaNode<NODETYPE>::unaNode(){
   }

template <class NODETYPE>
   inline unaNode<NODETYPE>::~unaNode(){
   }

#endif