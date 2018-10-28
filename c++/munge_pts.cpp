#include <iostream>
#include <fstream.h>
#include <string>

//2004-11-11
//David Strube
//munge_pts

//input: some rows from running 
//\\Wwwserver\ftproot\EP_Integrity_Check_Scripts\EPRO to Millbrook integrity check EPRO 2.sql
//against a db (decatur peds to be exact)

//Output = billing ids

   int main(){
   
   		/***********************
   		start things off, get stuff initialised
   		*************************/
      ifstream infi ("delete 20041111.txt");
      ofstream outfi ("out.txt");
      string intemp, outemp;
      //string findme="118";
      const int findme_L=118;
      //int size=0;
      //int space_L=0;
      int count=0;
   
   		/***********************
   		now the fun begins
   		*************************/
   
      while (getline(infi, intemp)){
      //cout<<"testing "<<intemp<<endl;
      //findme_L=intemp.find(findme);
      //size=intemp.size();
      //space_L=intemp.rfind(" ");
      //if (findme_L!=-1) {
         //cout<<".found the billing id:\n"<<intemp<<endl;
         outemp=intemp.substr(findme_L);
         outfi<<outemp<<"\", \"";
         //cout<<outemp<<endl<<"Found at "<<findme_L;
         count++;
      //}
         //else
            //cout<<"not .jpg:\n"<<intemp<<endl;
      
         //cout<<"intemp.find(jpg) = "<<jpg_L<<endl;
         //getline(infi, intemp);
      //size=0;
      //space_L=0;
         //findme_L=0;
      
      }
      infi.close();
   	outfi<<"\ncount: "<<count;
      outfi.close();
      return 0;
   }
