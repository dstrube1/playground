//prodNode.h - a binary operator node representing the product of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/

#ifndef PRODNODE_H
#define PRODNODE_H

#include "binNode.h"

template <class NODETYPE>
   class prodNode:public binNode<NODETYPE>{
   public:
      prodNode();
      prodNode(Node<NODETYPE>* l, Node<NODETYPE>* r);
      ~prodNode();
      NODETYPE eval() const;
      void print() const;
      Node<NODETYPE>* getPtr();
   };

template <class NODETYPE>
   inline prodNode<NODETYPE>::prodNode(){
   
   }

template <class NODETYPE>

   inline prodNode<NODETYPE>::prodNode(Node<NODETYPE>* l, Node<NODETYPE>* r){
   
      leftPtr=l;
      rightPtr=r;   
   }

template <class NODETYPE>
   inline prodNode<NODETYPE>::~prodNode(){
   
   }


template <class NODETYPE>
   inline NODETYPE prodNode<NODETYPE>::eval() const{
      return leftPtr->eval() * rightPtr->eval();
   }

template <class NODETYPE>
   inline void prodNode<NODETYPE>::print() const{
      cout<<"(";
      leftPtr->print();
      cout<<"*";
      rightPtr->print();
      cout<<")";
   }

template <class NODETYPE>
   inline Node<NODETYPE>* prodNode<NODETYPE>::getPtr(){
      return this;}

#endif