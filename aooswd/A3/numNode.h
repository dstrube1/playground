//numNode.h - a node representing the value of a number

/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/

#ifndef NUMNODE_H
#define NUMNODE_H

#include "node.h"
//#include <iostream>

template <class NODETYPE>
   class numNode:public Node<NODETYPE>{
   public:
      numNode(const NODETYPE);
      ~numNode();
      NODETYPE eval() const;
      void print() const;
      Node<NODETYPE>* getPtr();
   private:
      NODETYPE data;
   };

template <class NODETYPE>
   inline numNode<NODETYPE>::numNode(const NODETYPE d){
      data=d;
   }

template <class NODETYPE>        
   inline numNode<NODETYPE>::~numNode(){
   }

template <class NODETYPE>
   inline NODETYPE numNode<NODETYPE>::eval() const{
      //cout<<"in numNode eval...\n";
      return data;
   }

template <class NODETYPE>
   inline void numNode<NODETYPE>::print() const{
      cout<<data;
   }

template <class NODETYPE>
   inline Node<NODETYPE>* numNode<NODETYPE>::getPtr(){
      return this;}

#endif