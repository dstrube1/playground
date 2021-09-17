//expNode.h - a binary operator node representing the exponetiation of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/

#ifndef EXPNODE_H
#define EXPNODE_H

#include "binNode.h"
#include <math.h>

template <class NODETYPE>
   class expNode:public binNode<NODETYPE>{
   public:
      expNode();
      expNode(Node<NODETYPE>* l, Node<NODETYPE>* r);
      ~expNode();
      NODETYPE eval() const;
      void print() const;
      Node<NODETYPE>* getPtr();
   };

template <class NODETYPE>
   inline expNode<NODETYPE>::expNode(){
   
   }

template <class NODETYPE>

   inline expNode<NODETYPE>::expNode(Node<NODETYPE>* l, Node<NODETYPE>* r){
   
      leftPtr=l;
      rightPtr=r;   
   }

template <class NODETYPE>
   inline expNode<NODETYPE>::~expNode(){
   
   }


template <class NODETYPE>
   inline NODETYPE expNode<NODETYPE>::eval() const{
      return NODETYPE(pow(leftPtr->eval(), rightPtr->eval()));
   }

template <class NODETYPE>
   inline void expNode<NODETYPE>::print() const{
      cout<<"(";
      leftPtr->print();
      cout<<"^";
      rightPtr->print();
      cout<<")";
   }

template <class NODETYPE>
   inline Node<NODETYPE>* expNode<NODETYPE>::getPtr(){
      return this;}

#endif