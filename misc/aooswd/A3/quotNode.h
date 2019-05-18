//quotNode.h - a binary operator node representing the quotient of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/

#ifndef QUOTNODE_H
#define QUOTNODE_H

#include "binNode.h"

template <class NODETYPE>
   class quotNode:public binNode<NODETYPE>{
   public:
      quotNode();
      quotNode(Node<NODETYPE>* l, Node<NODETYPE>* r);
      ~quotNode();
      NODETYPE eval() const;
      void print() const;
      Node<NODETYPE>* getPtr();
   };

template <class NODETYPE>
   inline quotNode<NODETYPE>::quotNode(){
   
   }

template <class NODETYPE>

   inline quotNode<NODETYPE>::quotNode(Node<NODETYPE>* l, Node<NODETYPE>* r){
   
      leftPtr=l;
      rightPtr=r;   
   }

template <class NODETYPE>
   inline quotNode<NODETYPE>::~quotNode(){
   
   }


template <class NODETYPE>
   inline NODETYPE quotNode<NODETYPE>::eval() const{
      return leftPtr->eval() / rightPtr->eval();
   }

template <class NODETYPE>
   inline void quotNode<NODETYPE>::print() const{
      cout<<"(";
      leftPtr->print();
      cout<<"/";
      rightPtr->print();
      cout<<")";
   }

template <class NODETYPE>
   inline Node<NODETYPE>* quotNode<NODETYPE>::getPtr(){
      return this;}

#endif