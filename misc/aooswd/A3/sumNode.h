//sumNode.h - a binary operator node representing the sum of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/

#ifndef SUMNODE_H
#define SUMNODE_H

#include "binNode.h"

template <class NODETYPE>
   class sumNode:public binNode<NODETYPE>{
   public:
      sumNode();
      ~sumNode();
      sumNode(Node<NODETYPE>* l, Node<NODETYPE>* r);
      NODETYPE eval() const;
      void print() const;
      Node<NODETYPE>* getPtr();
   };

template <class NODETYPE>
   inline sumNode<NODETYPE>::sumNode(){
   }

template <class NODETYPE>
   inline sumNode<NODETYPE>::sumNode(Node<NODETYPE>* l, Node<NODETYPE>* r){
      leftPtr=l;
      rightPtr=r;   
   }

template <class NODETYPE>
   inline sumNode<NODETYPE>::~sumNode(){
   }


template <class NODETYPE>
   inline NODETYPE sumNode<NODETYPE>::eval() const{
      return leftPtr->eval() + rightPtr->eval();
   }

template <class NODETYPE>
   inline void sumNode<NODETYPE>::print() const{
      cout<<"(";
      leftPtr->print();
      cout<<"+";
      rightPtr->print();
      cout<<")";
   }

template <class NODETYPE>
   inline Node<NODETYPE>* sumNode<NODETYPE>::getPtr(){
   
   
      return this;}

#endif