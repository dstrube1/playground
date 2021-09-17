//http://cpptips.hyperformix.com/Templates.html
//http://cpptips.hyperformix.com/cpptips/constr_templ_args
   using namespace std;
#include "Test.h"
#include <iostream>
#include <string>

template < class T > 
   T max ( T a, T b ) { 
      return (a < b ? b : a); 
   }

   main(){
      typedef int me;
      Test<me> blah(1);
      int a=3;
      int b=2;
   	int c[1];
   	c[0]=max(a,b);
      blah.recieve(c); 
   	cout<<c[0]<<endl;
   }