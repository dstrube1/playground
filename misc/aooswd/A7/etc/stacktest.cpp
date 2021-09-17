//http://www.josuttis.com/libbook/cont/stack1.cpp.html
#include <stack>
#include <iostream>
#include <strstream>
#include <string>

   int main(){
      stack <string> st;
   
      string t1("1");
   
      int temp=2;
      ostrstream out;
      out <<temp<<ends;
      string t2 = out.str();
   
      st.push(t1);
      st.push(t2);
      
   	string t3("+");
   
    // pop and print two elements from the stack
      string t4= st.top();
      st.pop();
      string t5= st.top();
      st.pop();
   	
   	//out<<t4<<t3<<t5<<ends;
      st.push("("+t4+"+"+t5+")");
   	
    // pop and print remaining elements
    while (!st.empty()) {
        cout << st.top() << ' ';
        st.pop();
    }
      cout << endl;
      return 0;}