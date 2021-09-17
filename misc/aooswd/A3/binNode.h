//binNode.h - a binary operator node

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/


#ifndef BINNODE_H
#define BINNODE_H

#include "node.h"

template <class NODETYPE>
   class binNode:public Node<NODETYPE>{
   public:
      binNode();
      virtual ~binNode()=0;
      virtual NODETYPE eval() const=0;
      virtual void print() const=0;
   };

template <class NODETYPE>
   inline binNode<NODETYPE>::binNode(){
   
   }

template <class NODETYPE>
   inline binNode<NODETYPE>::~binNode(){
   
   }

#endif