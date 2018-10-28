//# include <iostream.h>
# include <string>
# include <fstream.h>

   int main(){
   
      int count = 1;
      string root = "out"+1+".txt";
   	char * name = (char*)root
   	
		ifstream infile("in.txt"); 
      ofstream outfile(name);
      string temp; 
      while (getline(infile, temp)&& count < 100){
         /*if (count%10 == 0){
            outfile.close();
         	name = 
            outfile();
         }*/
         outfile<<temp<< endl;
      
         count++;
      
      }
      infile.close(); //this doesnt seem necessary, nor harmful
      outfile.close(); 
      return 0;
   }
