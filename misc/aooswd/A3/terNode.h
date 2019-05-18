//terNode.h - a ternary operator node
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/

#ifndef TERNODE_H
#define TERNODE_H

#include "node.h"

template <class NODETYPE>
   class terNode :public Node<NODETYPE>{
   public:
      terNode();
      virtual ~terNode()=0;
      virtual NODETYPE eval()const =0;
      virtual void print() const=0;
   private:
      Node<NODETYPE> * midPtr;
   };

template <class NODETYPE>
   terNode<NODETYPE>::terNode(){
   }

template <class NODETYPE>
   terNode<NODETYPE>::~terNode(){
   }

#endif