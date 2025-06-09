//tree.h
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/


#ifndef TREE_H
#define TREE_H

//#include <iostream>
#include "node.h"
#include "numNode.h"
#include "sumNode.h"
#include "diffNode.h"
#include "prodNode.h"
#include "quotNode.h"
#include "modNode.h"
#include "expNode.h"
#include "negNode.h"
#include "posNode.h"

template <class NODETYPE>
   class Tree:public Node<NODETYPE>{
   public :
      Tree();
      Tree(const NODETYPE); //number tree: leaf
      Tree(char, const Tree<NODETYPE>); //unary operator tree: operator and its left branch
      Tree(char, const Tree <NODETYPE>, const Tree<NODETYPE>); // binary operator tree: 
   																				//operator, left node, right node
      NODETYPE eval() const;
      void print() const;
      Node<NODETYPE>* getPtr();
   private: 
      //Tree* rootPtr;
      Node<NODETYPE>* rootPtr;
   };

template <class NODETYPE>
   inline Tree<NODETYPE>::Tree(){
      rootPtr=0;
   }

template <class NODETYPE>
   inline Tree<NODETYPE>::Tree(const NODETYPE n){
      rootPtr= new numNode<NODETYPE>(n);
   }

template <class NODETYPE>
   inline Tree<NODETYPE>::Tree(char n, const Tree<NODETYPE> b){
   
      leftPtr=new Tree<NODETYPE> (b);
      if (n=='+'){
         rootPtr=new posNode<NODETYPE> (leftPtr);
      }
      else if (n=='-'){
         rootPtr=new negNode<NODETYPE> (leftPtr);
      }
      else
         rootPtr=0;
   
   }

template <class NODETYPE>
   inline Tree<NODETYPE>::Tree(char n, const Tree<NODETYPE> l, const Tree<NODETYPE> r){
      leftPtr=new Tree<NODETYPE> (l);
      rightPtr=new Tree<NODETYPE> (r);
   
      if (n=='+'){
         rootPtr=new sumNode<NODETYPE> (leftPtr,rightPtr);
      }
      else if (n=='-'){
         rootPtr=new diffNode<NODETYPE> (leftPtr,rightPtr);
      }
      else if (n=='*'){
         rootPtr=new prodNode<NODETYPE> (leftPtr,rightPtr);
      }
      else if (n=='/'){
         rootPtr=new quotNode<NODETYPE> (leftPtr,rightPtr);
      }
      else if (n=='%'){
         rootPtr=new modNode<NODETYPE> (leftPtr,rightPtr);
      }
      else if (n=='^'){
         rootPtr=new expNode<NODETYPE> (leftPtr,rightPtr);
      }
      else
         rootPtr=0;
   
   }

template <class NODETYPE>
   inline NODETYPE Tree<NODETYPE>::eval() const{
      return rootPtr->eval();
   }	

template <class NODETYPE>
   inline void Tree<NODETYPE>::print() const{
      rootPtr->print();
   }

template <class NODETYPE>          
   inline Node<NODETYPE>* Tree<NODETYPE>::getPtr(){
      return this;}
#endif