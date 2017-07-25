//modNode.h - a binary operator node representing the modulussing of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/

#ifndef MODNODE_H
#define MODNODE_H

#include "binNode.h"

template <class NODETYPE>
   class modNode:public binNode<NODETYPE>{
   public:
      modNode();
      modNode(Node<NODETYPE>* l, Node<NODETYPE>* r);
      ~modNode();
      NODETYPE eval() const;
      void print() const;
      Node<NODETYPE>* getPtr();
   };

template <class NODETYPE>
   inline modNode<NODETYPE>::modNode(){
   
   }

template <class NODETYPE>

   inline modNode<NODETYPE>::modNode(Node<NODETYPE>* l, Node<NODETYPE>* r){
   
      leftPtr=l;
      rightPtr=r;   
   }

template <class NODETYPE>
   inline modNode<NODETYPE>::~modNode(){
   
   }


template <class NODETYPE>
   inline NODETYPE modNode<NODETYPE>::eval() const{
      return leftPtr->eval() % rightPtr->eval();
   }

template <class NODETYPE>
   inline void modNode<NODETYPE>::print() const{
      cout<<"(";
      leftPtr->print();
      cout<<"%";
      rightPtr->print();
      cout<<")";
   }

template <class NODETYPE>
   inline Node<NODETYPE>* modNode<NODETYPE>::getPtr(){
      return this;}

#endif