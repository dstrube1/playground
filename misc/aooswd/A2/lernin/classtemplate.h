template<typename T> 
   class MyClass 
   { 
   public: 
      MyClass(T x = 0, T y = 0, T z = 0) : n1(x), n2(y), n3(z) {
      } 
      T GetAverage(); 
   
   private: 
      T n1; 
      T n2; 
      T n3; 
   }; 
