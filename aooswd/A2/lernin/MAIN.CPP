#include <iostream> 
#include "main.h" 

using namespace std; 

template<class T> T GetAverage(T num1, T num2, T num3) 
{ 
return static_cast<T>((num1 + num2 + num3) / 3); 
} 

int main() 
{ 
int x = 10; 
int y = 20; 
int z = 30; 

int returnValue = GetAverage(x, y, z); 
cout << "Returned " << returnValue << endl << endl; 

return 0; 
} 
