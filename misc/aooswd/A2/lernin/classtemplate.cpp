#include <iostream> 
#include "classtemplate.h" 

using namespace std; 

template<typename T> T MyClass<T>::GetAverage() 
{ 
return static_cast<T>((n1 + n2 + n3) / 3); 
} 

int main() 
{ 
MyClass<int> mc(1, 2, 3); 
cout << "Return value is: " << mc.GetAverage() << endl << endl; 

return 0; 
} 

