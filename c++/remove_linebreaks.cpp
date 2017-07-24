//# include <iostream.h>
# include <string>
# include <fstream.h>
   int main(){
      ifstream infile("in.txt"); 
      ofstream outfile("out.txt");
      string temp; 
      int length_count = 0;
      while (getline(infile, temp)){
         if (temp.length() > 1){
            length_count += temp.length();
            if (length_count >= 230){
               length_count = 0;
               outfile << endl;
            }
            outfile<<temp<<" ";
         }
      }
      infile.close(); //this doesnt seem necessary, nor harmful
      outfile.close(); 
      return 0;
   }
