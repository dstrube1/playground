//TreeStringVisitor.h

#ifndef TREESTRINGVISITOR_H
#define TREESTRINGVISITOR_H

#include "TreeVisitor.h"
#include <stack>
#include <strstream>
#include <string>
#include "numNode.h"

   class TreeStringVisitor:public TreeVisitor{
   public :
      TreeStringVisitor();
      TreeStringVisitor(TreeInterface*);
      virtual ~TreeStringVisitor();
      string toString();
      string toMorganString();
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
      stack<string> myStack;
      stack<string> myMorganStack;
      TreeInterface* myTree;
   };

   inline TreeStringVisitor::TreeStringVisitor(){
   }

   inline TreeStringVisitor::TreeStringVisitor(TreeInterface* ti):TreeVisitor(ti){
      myTree = ti;
   }
   inline TreeStringVisitor::~TreeStringVisitor(){
   }

   inline string TreeStringVisitor::toString() {
      myTree->accept(this);
      return myStack.top();
   }

   inline string TreeStringVisitor::toMorganString() {
      myTree->accept(this);
      return myMorganStack.top();
   }

   inline void TreeStringVisitor::visitNumNode(numNode* n){
      ostrstream out;
      out <<n->getNum() <<ends;
      myStack.push(out.str());
      myMorganStack.push(out.str());
   }

   inline void TreeStringVisitor::visitSumNode(){
      string temp1 = myStack.top();
      myStack.pop();
      string temp2 = myStack.top();
      myStack.pop();
      myStack.push("("+temp2+"+"+temp1+")");
   
      string temp3 = myMorganStack.top();
      myMorganStack.pop();
      string temp4 = myMorganStack.top();
      myMorganStack.pop();
      myMorganStack.push("the sum of "+temp4+" and "+temp3);
   }

   inline void TreeStringVisitor::visitDiffNode(){	
      string temp1 = myStack.top();
      myStack.pop();
      string temp2 = myStack.top();
      myStack.pop();
      myStack.push("("+temp2+"-"+temp1+")");
   
      string temp3 = myMorganStack.top();
      myMorganStack.pop();
      string temp4 = myMorganStack.top();
      myMorganStack.pop();
      myMorganStack.push("the difference of "+temp4+" and "+temp3);
   }
   inline void TreeStringVisitor::visitProdNode(){
      string temp1 = myStack.top();
      myStack.pop();
      string temp2 = myStack.top();
      myStack.pop();
      myStack.push("("+temp2+"*"+temp1+")");
   
      string temp3 = myMorganStack.top();
      myMorganStack.pop();
      string temp4 = myMorganStack.top();
      myMorganStack.pop();
      myMorganStack.push("the product of "+temp4+" and "+temp3);
   }
   inline void TreeStringVisitor::visitQuotNode(){
      string temp1 = myStack.top();
      myStack.pop();
      string temp2 = myStack.top();
      myStack.pop();
      myStack.push("("+temp2+"/"+temp1+")");
   
      string temp3 = myMorganStack.top();
      myMorganStack.pop();
      string temp4 = myMorganStack.top();
      myMorganStack.pop();
      myMorganStack.push("the quotient of "+temp4+" and "+temp3);
   }
   inline void TreeStringVisitor::visitExpNode(){
      string temp1 = myStack.top();
      myStack.pop();
      string temp2 = myStack.top();
      myStack.pop();
      myStack.push("("+temp2+"^"+temp1+")");
   
      string temp3 = myMorganStack.top();
      myMorganStack.pop();
      string temp4 = myMorganStack.top();
      myMorganStack.pop();
      myMorganStack.push(temp4+" raised to the power of "+temp3);
   }
   inline void TreeStringVisitor::visitModNode(){
      string temp1 = myStack.top();
      myStack.pop();
      string temp2 = myStack.top();
      myStack.pop();
      myStack.push("("+temp2+"%"+temp1+")");
   
      string temp3 = myMorganStack.top();
      myMorganStack.pop();
      string temp4 = myMorganStack.top();
      myMorganStack.pop();
      myMorganStack.push("the modulus of "+temp4+" and "+temp3);
   }
   inline void TreeStringVisitor::visitNegNode(){	
      string temp1 = myStack.top();
      myStack.pop();
      myStack.push("(-"+temp1+")");
   
      string temp3 = myMorganStack.top();
      myMorganStack.pop();
      myMorganStack.push("the sum inverse of "+temp3);
   }
   inline void TreeStringVisitor::visitPosNode(){	
      string temp1 = myStack.top();
      myStack.pop();
      myStack.push("(+"+temp1+")");
   
      string temp3 = myMorganStack.top();
      myMorganStack.pop();
      myMorganStack.push(temp3);}

#endif