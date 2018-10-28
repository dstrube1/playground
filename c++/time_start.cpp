#include "ccc_time.cpp"
#include "ccc_win.cpp"

   const double PI = 3.141592653589793;


   class Clock{
   public:
      Clock();
      Clock(Point c, double r);
      void set_time(Time t);
      void draw() const;
   private:
      void draw_tick(double angle, double length) const;
      void draw_hand(double angle, double length, bool circ) const;
      Time current_time;
      Point center;
      double radius;
   };

   class Flow{
   public:
      Flow();
      void go();
      void choose();
   
   
   private:
      Clock clock;
      int minutes_from_current;
      double speed;
   };

   bool distance(double check, Point A, Point B){
      double x1=A.get_x();
      double x2=B.get_x();
      double y1=A.get_y();
      double y2=B.get_y();
      double dist=sqrt(pow((x1-x2),2)+pow((y1-y2),2));
      bool ret=false;
      if((check-dist)>0)ret=true;
      return ret;
   }

   Clock::Clock(){
   
   }

   Clock::Clock(Point c, double r)
   /*	PRE:
   POST:
   */
   {
      center=c;
      radius=r;
   }

   void Clock::set_time(Time t)
   /*	PRE:
   POST:
   */
   {
      current_time=t;
   }



   void Clock::draw_tick(double angle, double length) const
   
   /* PURPOSE:  draw a tick mark (hour or minute mark)
   RECEIVES: angle - the angle in minutes (0...59, 0 = top)
             length - the length of the tick mark
   */
   {  double alpha = PI / 2 - 6 * angle * PI / 180;
      Point from(center.get_x() + cos(alpha) * radius * (1 - length),
                center.get_y() + sin(alpha) * radius * (1 - length));
      Point to(center.get_x() + cos(alpha) * radius,
              center.get_y() + sin(alpha) * radius);
      cwin << Line(from, to);
   }


   void Clock::draw_hand(double angle, double length, bool circ) const
   
   /* PURPOSE:  draw a hand, starting from the center
   RECEIVES: angle - the angle in minutes (0...59, 0 = top)
             length - the length of the hand
   */
   {  double alpha = PI / 2 - 6 * angle * PI / 180;
      Point from = center;
      Point to(center.get_x() + cos(alpha) * radius * length,
              center.get_y() + sin(alpha) * radius * length);
      cwin << Line(from, to);
      if(circ){
         Circle end(to, 0.5);
         cwin << end;
      }
   }


   void Clock::draw() const
   
   /* PURPOSE:  draw the clock, with tick marks and hands
   */
   {  cwin << Circle(center, radius);
      int i;
      const double HOUR_TICK_LENGTH = 0.2;
      const double MINUTE_TICK_LENGTH = 0.1;
      const double HOUR_HAND_LENGTH = 0.55;
      const double MINUTE_HAND_LENGTH = 0.70;
   	const double SECOND_HAND_LENGTH = 0.75;
      for (i = 0; i < 12; i++)
      {  draw_tick(i * 5, HOUR_TICK_LENGTH);
         int j;
         for (j = 1; j <= 4; j++)
            draw_tick(i * 5 + j, MINUTE_TICK_LENGTH);
      }
      draw_hand(current_time.get_minutes(), MINUTE_HAND_LENGTH, true);
      draw_hand((current_time.get_hours() +
                current_time.get_minutes() / 60.0) * 5, HOUR_HAND_LENGTH, true);
      draw_hand(current_time.get_seconds(), SECOND_HAND_LENGTH, false);
   }



   Flow::Flow()
   /*	PRE:
   	POST:
   */
   {
   
   }

   void Flow::go()
   /*	PRE:
   	POST:
   */
   {
   
      bool quit = false;
      while(quit!=true){
      
      
      
      }
   }

   void Flow::choose()
   /*	PRE:
   	POST:
   */
   {
      cwin.clear();
   
   
   
   }











   int main(){
   
      Time now;
      cwin.coord(0,0,100,100);
   
      Message hr(Point(10,10), now.get_hours());
      Message col(Point(15,10), ":");
      Message mn(Point(16,10), now.get_minutes());
      Message col2(Point(21,10), ":");
      Message sec(Point(22,10), now.get_seconds());
      cwin << hr << col << mn << col2 << sec;
      return 0;
   }