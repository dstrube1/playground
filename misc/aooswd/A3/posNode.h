//posNode.h - a unary operator node representing the positifying of a node value

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/

#ifndef POSNODE_H
#define POSNODE_H

#include "unaNode.h"

template <class NODETYPE>

   class posNode:public unaNode<NODETYPE>{
   public:
      posNode();
      ~posNode();
      posNode(Node<NODETYPE>* l);
      NODETYPE eval() const;
      void print() const;
      Node<NODETYPE>* getPtr();
   };

template <class NODETYPE>
   inline posNode<NODETYPE>::posNode(){
   }

template <class NODETYPE>
   inline posNode<NODETYPE>::~posNode(){
   }

template <class NODETYPE>
   inline posNode<NODETYPE>::posNode(Node<NODETYPE>* l){
      leftPtr=l;
   }

template <class NODETYPE>
   inline NODETYPE posNode<NODETYPE>::eval() const{
   
      return leftPtr->eval();
   }

template <class NODETYPE>
   inline void posNode<NODETYPE>::print() const{
      cout<<"(+";
      leftPtr->print();
      cout<<")";
   
   }

template <class NODETYPE>
   inline Node<NODETYPE>* posNode<NODETYPE>::getPtr(){
      return this;}

#endif