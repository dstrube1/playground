#include <iostream>
template <class T> 
   class Test {
   public:
      Test(int t);//T);
      void recieve(T blah[]);
   };

template <class T>
   inline Test<T>::Test(int t){//T blah){
      //cout<<"\ntest working\n";
   }

template <class T>
   inline void Test<T>::recieve(T blah[]){
      cout<<"got "<<blah[0]<<endl;
      blah[0]=2;
      cout<<blah[0]<<" in test\n";
   }