//TreeEvalVisitor.h

#ifndef TREEEVALVISITOR_H
#define TREEEVALVISITOR_H

#include "TreeVisitor.h"
#include "numNode.h"
#include <stack>
#include <math.h>


   class TreeEvalVisitor:public TreeVisitor{
   public :
      TreeEvalVisitor();
      TreeEvalVisitor(TreeInterface*);
      virtual ~TreeEvalVisitor();
      int eval();
      void visitNumNode(numNode*);
      void visitSumNode();
      void visitDiffNode();
      void visitProdNode();
      void visitQuotNode();
      void visitExpNode();
      void visitModNode();
      void visitNegNode();
      void visitPosNode();
   private:
      stack<int> myStack;
      TreeInterface* myTree;
   };

   inline TreeEvalVisitor::TreeEvalVisitor(){
   }

   inline TreeEvalVisitor::TreeEvalVisitor(TreeInterface* ti):TreeVisitor(ti){
      myTree = ti;
   }

   inline TreeEvalVisitor::~TreeEvalVisitor(){
   }

   inline int TreeEvalVisitor::eval(){
      myTree->accept(this);
      return myStack.top();
   }

   inline void TreeEvalVisitor::visitNumNode(numNode* n){
      myStack.push(n->getNum());
   }

   inline void TreeEvalVisitor::visitSumNode(){
      int temp1 = myStack.top();
      myStack.pop();
      int temp2 = myStack.top();
      myStack.pop();
      myStack.push(temp2+temp1);
   }

   inline void TreeEvalVisitor::visitDiffNode(){	
      int temp1 = myStack.top();
      myStack.pop();
      int temp2 = myStack.top();
      myStack.pop();
      myStack.push(temp2-temp1);
   }
   inline void TreeEvalVisitor::visitProdNode(){
      int temp1 = myStack.top();
      myStack.pop();
      int temp2 = myStack.top();
      myStack.pop();
      myStack.push(temp2*temp1);
   }
   inline void TreeEvalVisitor::visitQuotNode(){
      int temp1 = myStack.top();
      myStack.pop();
      int temp2 = myStack.top();
      myStack.pop();
      myStack.push(temp2/temp1);
   }
   inline void TreeEvalVisitor::visitExpNode(){
      int temp1 = myStack.top();
      myStack.pop();
      int temp2 = myStack.top();
      myStack.pop();
      myStack.push(int(pow(temp2, temp1)));
   }
   inline void TreeEvalVisitor::visitModNode(){
      int temp1 = myStack.top();
      myStack.pop();
      int temp2 = myStack.top();
      myStack.pop();
      myStack.push(temp2%temp1);
   }
   inline void TreeEvalVisitor::visitNegNode(){	
      int temp1 = myStack.top();
      myStack.pop();
      myStack.push(-temp1);
   }
   inline void TreeEvalVisitor::visitPosNode(){	
      int temp1 = myStack.top();
      myStack.pop();
      myStack.push(temp1);
   }
	
#endif