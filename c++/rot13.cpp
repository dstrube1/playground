/************************
Comments?
We dont need no steekin comments!
************************/

   class rot13{
   
   public:
      rot13();
      void shift(char c);
   private:
      char letter;
   };
   void main(){
      char a;
      rot13 rotter;
      while(a=~getchar())
         rotter.shift(a);
   
   }
   rot13::rot13(){
   }
   void rot13::shift(char c){
      letter=c;
      putchar(~letter-1/(~(letter|32)/13*2-11)*13);
   
   }

