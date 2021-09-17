//tree2.h

#ifndef TREE2_H
#define TREE2_H

#include "node.h"
#include <string>

template <class NODETYPE>
   class Tree:public Node<NODETYPE>{
   public :
      Tree();
      Tree(Node<NODETYPE>*); //number tree; leaf
      Tree(Node<NODETYPE>*, Node<NODETYPE>*); //unary operator tree: operator and its left branch
      Tree(Node<NODETYPE>*, Node<NODETYPE>*, Node<NODETYPE>*); // binary operator tree: 
   																				//operator, left node, right node
      NODETYPE eval();
      void print();
   private: 
      Node<NODETYPE> *rootPtr;
      Node<NODETYPE> *leftPtr;
      Node<NODETYPE> *rightPtr;
   };

template <class NODETYPE>
   inline Tree<NODETYPE>::Tree(){
      rootPtr=0;
   }

template <class NODETYPE>
   inline Tree<NODETYPE>::Tree(Node<NODETYPE>* n){
      rootPtr=n;
   }

template <class NODETYPE>
   inline Tree<NODETYPE>::Tree(Node<NODETYPE>* n, Node<NODETYPE>* b){
      rootPtr=n;
      leftPtr=b;}

template <class NODETYPE>
   inline Tree<NODETYPE>::Tree(Node<NODETYPE>* n, Node<NODETYPE>* l, Node<NODETYPE>* r){
      /*if (s=="+"){
      sumNode SN(l,r);
   	rootPtr=SN1.getPtr();
      }
   	else if (s=="-"){}
   	else if (s=="*"){}
   	else if (s=="/"){}
   	else if (s=="^"){}
   	*/
      rootPtr=n;
      leftPtr=l;
      rightPtr=r;}

template <class NODETYPE>
   inline NODETYPE Tree<NODETYPE>::eval(){
      return rootPtr->eval();
   }	

template <class NODETYPE>
   inline void Tree<NODETYPE>::print(){
      rootPtr->print();
   }
#endif