//tree.h
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef TREE_H
#define TREE_H

#include "node.h"
#include "treeInterface.h"
#include "numNode.h"
#include "sumNode.h"
#include "diffNode.h"
#include "prodNode.h"
#include "quotNode.h"
#include "modNode.h"
#include "expNode.h"
#include "negNode.h"
#include "posNode.h"

   class Tree:public TreeInterface{
   public :
      Tree();
      Tree(const int); //number tree: leaf
      Tree(char, TreeInterface*); //unary operator tree: operator and its left branch
      Tree(char, TreeInterface*, TreeInterface*); // binary operator tree: 
   																				//operator, left node, right node
      int eval();
      string toString() const;
   private: 
      Node* root;
   };

   inline Tree::Tree(){
      root=0;
   }

   inline Tree::Tree(const int n){
      root= new numNode(n);
   }

   inline Tree::Tree(char n, TreeInterface* left){
      if (n=='+'){
         root=new posNode(left);
      }
      else if (n=='-'){
         root=new negNode(left);
      }
      else
         root=0;
   }

   inline Tree::Tree(char n, TreeInterface* left, TreeInterface* right){
      if (n=='+'){
         root=new sumNode(left,right);
      }
         else if (n=='-'){
         root=new diffNode (left,right);
      }
      else if (n=='*'){
         root=new prodNode (left,right);
      }
      else if (n=='/'){
         root=new quotNode (left,right);
      }
      else if (n=='%'){
         root=new modNode (left,right);
      }
      else if (n=='^'){
         root=new expNode (left,right);
      }
      else
         root=0;
   }

   inline int Tree::eval(){
      return root->eval();
   }	

   inline string Tree::toString() const{
      return root->toString();
   }

#endif