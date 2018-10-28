
#include "ccc_win.cpp" 
#include <iostream>
	//http://agri.upm.edu.my/~chris/tal/src-polygon.html
	//http://pigseye.kennesaw.edu/~showard2/color.html
/**************************************
				
**************************************/

/**************************************
	Random Generators
**************************************/
   int r_color();
	int r_move();
	
/**************************************
				Shape Drawers
**************************************/
   void I(int Sx, int Sy);
   void L (int Sx, int Sy);
   void O (int Sx, int Sy);
   void V(int Sx, int Sy);
   void E(int Sx, int Sy);
   void Y (int Sx, int Sy);
   void U(int Sx, int Sy);

/**************************************
					Global int
**************************************/
int a=1;

/**************************************
						MAIN
**************************************/

   int main() 
   
   { 
      srand(time(NULL));
      int MAXxy, xran, yran;
   
      MAXxy=50;
   
      cwin.coord(MAXxy,MAXxy,0,0);
   
      /*Point p[4]; 
      xran=r_move();
      yran=r_move();
   
      for (int j=0; j<4; j++)
         p[j]=Point(cos(2*3.14*j/4)+xran, sin(2*3.14*j/4)+yran);
   
      PolyGon poly (4, &p[0]);
      	//////////if you wanna make each shape flicker colors
      for (int i=0; i<2000; i++){
         cwin.SetFillColor(r_color(),r_color(),r_color()); 
         cwin<<poly; 
         //	cout<<"shapes is "<<shapes<<"and size is"<<MAXxy<<endl;
      }
   
   
   
      cout<<"done";
   */
   
      I(25,45);
      return 0; 
   } 

   int r_color(){
      return (rand() % 256);
   }

   int r_move(){
      return (rand() % 10);
   }

   void vertrect(){
   
   }
   void I(int Sx, int Sy){
      Point p[12];
      p[0]=	Point	(Sx, Sy);
      p[1]=	Point	(Sx+3*a, Sy);
      p[2]=	Point	(Sx+3*a, Sy-a);
      p[3]=	Point	(Sx+2*a, Sy-a);
      p[4]=	Point	(Sx+2*a, Sy-3*a);
      p[5]=	Point	(Sx+3*a, Sy-3*a);
      p[6]=	Point	(Sx+3*a, Sy-4*a);
      p[7]=	Point	(Sx, Sy-4*a);
      p[8]=	Point	(Sx, Sy-3*a);
      p[9]=	Point	(Sx+a, Sy-3*a);
      p[10]= Point (Sx+a, Sy-a);
      p[11]= Point (Sx, Sy-a);
      PolyGon poly (12, &p[0]);
      cwin<<poly; 
   
   }
   void L (int Sx, int Sy){
   }
   void O (int Sx, int Sy){
   }
   void V (int Sx, int Sy){
   }
   void E (int Sx, int Sy){
   }
   void Y (int Sx, int Sy){
   }
   void U (int Sx, int Sy){
   }