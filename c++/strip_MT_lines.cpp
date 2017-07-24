//# include <iostream.h>
# include <string>
# include <fstream.h>
   int main(){
      ifstream infile("in.txt"); 
      ofstream outfile("out.txt");
      string temp; 
      while (getline(infile, temp)){
         if (temp.length() > 1)
      	outfile<<temp<<endl;
      }
      infile.close(); //this doesnt seem necessary, nor harmful
      outfile.close(); 
      return 0;
   }
