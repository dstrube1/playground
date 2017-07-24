#include<iostream.h>
#include<conio.h>
//from http://www.scootcity.com/cpp/polygon.htm
   struct point{
      float x,y;
      point *p;
   };

   float calc_polygon(point *, point *);
   float calc_triangle(point *, point *, point *);

   inline float calc_determinant(float px, float py, float qx, float qy){
      return(px*qy - qx*py);
   }

   main(){
   
      point *head=new point;
      point *current=new point;
      current=head;
      int i = 1;
      cout << "\nEnter point " << i << ": ";
   
      while (cin >> current->x >> current->y) {
         current->p=new point;
         current=current->p;
         i++;
         cout << "\nEnter point " << i << ": ";
      }
      current->p=NULL;	// put 'tail' on linked list of points.
   
      float area=calc_polygon(head, head->p);
      cout << "\nArea is: " << fabs(area) << endl;
      getch();
   }

   float calc_polygon(point *head, point *next){
      float area;
      if(next->p->p!=NULL){
         area=calc_triangle(head, next, next->p);
         next=next->p;
         area+=calc_polygon(head, next);
         return area;
      }
      return 0;
   }

   float calc_triangle(point *a, point *b, point *c){		
      float det_bc=calc_determinant(b->x, b->y, c->x, c->y);
      float det_ac=calc_determinant(a->x, a->y, c->x, c->y);
      float det_ab=calc_determinant(a->x, a->y, b->x, b->y);
      float area=(det_bc-det_ac+det_ab)/2;	// formula for area of triangle
      return area;
   }
