//TreeVisitor.h

#ifndef TREEVISITOR_H
#define TREEVISITOR_H
//#include <iostream>

#include "TreeInterface.h"
#include <string>

   class numNode;

   class TreeVisitor:public TreeInterface{
   protected:
      TreeVisitor(); 
   public :
      TreeVisitor(TreeInterface*); 
      virtual void visitNumNode(numNode*)=0;
      virtual int eval();
		virtual string toString();
		virtual string toMorganString();
   	virtual void visitSumNode()=0;
   	virtual void visitDiffNode()=0;
   	virtual void visitProdNode()=0;
   	virtual void visitQuotNode()=0;
   	virtual void visitExpNode()=0;
   	virtual void visitModNode()=0;
		virtual void visitNegNode()=0;
		virtual void visitPosNode()=0;
   private:
      TreeInterface* mytree;
   };

   inline TreeVisitor::TreeVisitor(){
   }

   inline TreeVisitor::TreeVisitor(TreeInterface* ti){
      mytree=ti;
   }

	inline int TreeVisitor::eval(){return 1;}
	inline string TreeVisitor::toString(){return "";}
	inline string TreeVisitor::toMorganString(){return "";}
	
	

#endif