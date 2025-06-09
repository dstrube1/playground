//TimingDecorator.h
/****************
David Strube
CSIS4650-01
Spring 2003
Assignment 5
***************/

#ifndef TIMINGDECORATOR_H
#define TIMINGDECORATOR_H

#include "TreeDecorator.h"
#include <strstream>
#include <string>

///////for duration: http://www.codeproject.com/cpp/duration.asp:
#include <windows.h>
#include "Duration.h"
///////////////
//Thanks to Laurent Guinnard and codeproject.com
///////////////


/*********************************************************************
This is what we call reusability!! :)
*********************************************************************/

   class TimingDecorator:public TreeDecorator{
   public :
      TimingDecorator();
      TimingDecorator(TreeInterface*);
      virtual ~TimingDecorator();
      int eval();
      string toString() const;
      double getTime() const;
   private:
      double microseconds;
      };

   inline TimingDecorator::TimingDecorator(){
      microseconds=0;
   }

   inline TimingDecorator::TimingDecorator(TreeInterface* t):TreeDecorator(t){
      microseconds=0;

   }
   inline TimingDecorator::~TimingDecorator(){
   }

   inline int TimingDecorator::eval(){
      int result;
      CDuration timer;
      timer.Start();
      result=TreeDecorator::eval();
      timer.Stop();
      microseconds = timer.GetDuration();

      return result;
   }


   inline string TimingDecorator::toString() const{
      ostrstream out;
      out <<TreeDecorator::toString() <<" evaluated in "<<microseconds<<" microseconds\n"<<ends;
      string s = out.str();
      return s;
   }

   inline double TimingDecorator::getTime() const{
      return microseconds;

   }
#endif