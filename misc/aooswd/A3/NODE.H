//node.h 
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 3
Expression Tree using bridge pattern
***************/

#ifndef NODE_H
#define NODE_H

#include <iostream>

template <class NODETYPE>
   class Node{
   public:
      Node (); //constructor
      virtual NODETYPE eval () const=0;
      virtual void print() const =0;
      virtual ~Node()=0;

      /******************************************
       I would not have the destructor as a pure
       virtual function.
      *****************************************/
   
   protected:
   //		Node *rootPtr;
      Node *leftPtr;
      Node *rightPtr;
   };

template <class NODETYPE>

   inline Node<NODETYPE>::Node(){
   
      //rootPtr=0;
      leftPtr=0;
      rightPtr=0;
   }

template <class NODETYPE>

   inline Node<NODETYPE>::~Node(){
   
   }

#endif
