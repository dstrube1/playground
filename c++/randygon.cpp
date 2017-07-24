
#include "ccc_win.cpp" 
#include <iostream>
	//http://agri.upm.edu.my/~chris/tal/src-polygon.html
	//http://pigseye.kennesaw.edu/~showard2/color.html

   int r_color();
   int r_numOFshapes();
   int r_numOFsides();
   int r_move(int size);

   int main() 
   
   { 
      const double PI=3.1415926535898;
      srand(time(NULL));
      int shapes, MAXxy, sides, xran, yran;
      
   	cout<<"How many shapes do you want? (enter 0 to let the computer decide) ";
      cin>>shapes;
      if (shapes>0){}
      else
         shapes=r_numOFshapes();
   
      cout<<"How far shud x & y go? (enter 0 to let the computer decide) ";
      cin>>MAXxy;
      if (MAXxy>0){}
      else
         MAXxy=20;
   		
      cwin.coord(0,0,MAXxy,MAXxy);
   
      for (int k=shapes; k>0; k--){
         sides=r_numOFsides();
         Point p[sides]; 
         xran=r_move(MAXxy);
         yran=r_move(MAXxy);
      
         for (int j=0; j<sides; j++){
            p[j]=Point(cos(2*PI*j/sides)+xran, sin(2*PI*j/sides)+yran);
         
         ////////////////these printout the coordinates of the shapes
         //cout<<"p[j]=Point(cos(2*PI*j/sides), sin(2*PI*j/sides))=\np[";
         //cout<<j<<"]=Point("<<cos(2*PI*j/sides)<<", "<<sin(2*PI*j/sides)<<")\n";
         }
         //cout<<"where sides="<<sides;
      
         PolyGon poly (sides, &p[0]);
      	//////////if you wanna make each shape flicker colors
         for (int i=0; i<3000; i++){
            cwin.SetFillColor(r_color(),r_color(),r_color()); 
            cwin<<poly; 
         //	cout<<"shapes is "<<shapes<<"and size is"<<MAXxy<<endl;
         }
      
      }
   
   cout<<"done";
   
      return 0; 
   } 

   int r_color(){
      return (rand() % 256);
   }
   int r_numOFshapes() {
      return (rand() % 50);
   }
   int r_numOFsides(){
      return ((rand() % 3)+3);
   }


   int r_move(int size){
      return (rand() % size);
   }
