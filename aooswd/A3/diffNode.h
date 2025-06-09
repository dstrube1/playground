//diffNode.h - a binary operator node representing the difference of two node values

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/


#ifndef DIFFNODE_H
#define DIFFNODE_H

#include "binNode.h"

template <class NODETYPE>
   class diffNode:public binNode<NODETYPE>{
   public:
      diffNode();
      diffNode(Node<NODETYPE>* l, Node<NODETYPE>* r);
      ~diffNode();
      NODETYPE eval() const;
      void print() const;
      Node<NODETYPE>* getPtr();
   };

template <class NODETYPE>
   inline diffNode<NODETYPE>::diffNode(){
   
   }

template <class NODETYPE>
   inline diffNode<NODETYPE>::diffNode(Node<NODETYPE>* l, Node<NODETYPE>* r){
      leftPtr=l;
      rightPtr=r;   
   }

template <class NODETYPE>
   inline diffNode<NODETYPE>::~diffNode(){
   
   }


template <class NODETYPE>
   inline NODETYPE diffNode<NODETYPE>::eval() const{
      return leftPtr->eval() - rightPtr->eval();
   }

template <class NODETYPE>
   inline void diffNode<NODETYPE>::print() const{
      cout<<"(";
      leftPtr->print();
      cout<<"-";
      rightPtr->print();
      cout<<")";
   }

template <class NODETYPE>
   inline Node<NODETYPE>* diffNode<NODETYPE>::getPtr(){
   
      return this;}

#endif