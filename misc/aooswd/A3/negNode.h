//negNode.h - a unary operator node representing the negation of one node value

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/

#ifndef NEGNODE_H
#define NEGNODE_H

#include "unaNode.h"

template <class NODETYPE>

   class negNode:public unaNode<NODETYPE>{
   public:
      negNode();
      ~negNode();
      negNode(Node<NODETYPE>* l);
      NODETYPE eval() const;
      void print() const;
      Node<NODETYPE>* getPtr();
   };

template <class NODETYPE>
   inline negNode<NODETYPE>::negNode(){
   }

template <class NODETYPE>
   inline negNode<NODETYPE>::~negNode(){
   }

template <class NODETYPE>
   inline negNode<NODETYPE>::negNode(Node<NODETYPE>* l){
      leftPtr=l;
   }

template <class NODETYPE>
   inline NODETYPE negNode<NODETYPE>::eval() const{
   
      return -1* leftPtr->eval();
   }

template <class NODETYPE>
   inline void negNode<NODETYPE>::print() const{
      cout<<"(-";
      leftPtr->print();
      cout<<")";
   
   }

template <class NODETYPE>
   inline Node<NODETYPE>* negNode<NODETYPE>::getPtr(){
      return this;}

#endif