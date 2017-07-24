/*******************************
DFP0-VIN.cpp - DataFormatProgram0 like DFP1, but without vectors
this prog takes in a text file, opens it, reads it line by line, 
then reconstructs / outputs 
*******************************/

# include <iostream.h>
# include <string>
# include <fstream.h>

	/************************FUNCTIONS***************************/
   void ChopLineUp();
   void CleanModel();
   void CleanVIN();
   void PutTogether();
   void PrintLine();

	/****************************STRINGS**************************/

   string line, YR, MAKE, MODEL, VIN;
	//Constants:
   string MT(""), dot("."), CUTMAKE(" MAKE\t"), CUTID("ID#\t"), TAB("\t"), NL("\n");

	/********************Files for input & output****************/
   ifstream infile("vinin.txt");
   ofstream outfile("vinout.txt");
	//files needs to be in the same dir as the exe


   int main(){
   		/*strupr and lwr only works on chars?
      getline(infile, line);
      strupr(line);
      cout<<"line1 upperd: "<<line+NL;
      strlwr(line);
      cout<<"line1 lowerd: "<<line+NL;
   
      getline(infile, line);
      strupr(line);
      cout<<"line2 upperd: "<<line+NL;
      strlwr(line);
      cout<<"line2 lowerd: "<<line+NL;
   	*/
   
   
      while( getline(infile, line) ) {
      // read lines until end of file
         if (line.substr(2,1)==" "){
            ChopLineUp();
            CleanModel();
            CleanVIN();
            //outfile<<"YR: "<<YR<<".\nMAKE: "<<MAKE<<".\nMODEL: "<<MODEL<<".\n"<<"VIN: "<<VIN<<".\n";
            PutTogether();      		
            PrintLine(); 
         
            cout<<dot;
         }
      }
   
   
   
      infile.close(); //this doesnt seem necessary, nor harmful
      outfile.close(); 
      return 0;
   }


   void ChopLineUp(){
   //comes in like this:
   //	91 MAKE	ACURA LEGEND              ID#	JH4KA7661MC039256
   //                                                               
      int size=line.size(), pos, msize;
   
      YR=line.substr(0,2);
      line=line.substr(8,size-8);//line is now line minus YR and CUTMAKE
      										//IE :"MAKE?^MODEL?^?ID#\tVIN?"
      pos=line.find(" ");
      MAKE=line.substr(0,pos);//make found; chop line down;
      size=line.size();
      line=line.substr(pos+1,size-1); //line:"MODEL?^?ID#\tVIN?"
      pos=line.find("ID#\t");
      MODEL=line.substr(0,pos); //model found (but not cleaned yet)...
      size=line.size();     
      line=line.substr(pos+4,size-1);//line:"VIN?^?"
      VIN=line;
   
   
   }

   void CleanModel(){
   
      int size=MODEL.size();
      int pos=MODEL.find_last_of(" ");
      //outfile<<"MODEL B4: "<<MODEL<<".\n";
      for (int i=size;i>0;i--){
         if (pos>=(size-1)){
            MODEL=MODEL.substr(0,size-1);
            //outfile<<"MODEL during: "<<MODEL<<".\n";
            size=MODEL.size();
            pos=MODEL.find_last_of(" ");
         }
      }
      //outfile<<"MODEL after: "<<MODEL<<".\n";
   
   }
   void CleanVIN(){
   
      int size=VIN.size();
      int pos=VIN.find_last_of(" ");
      if (pos!=-1){
         //outfile<<"VIN B4: "<<VIN<<".\n";
         for (int i=size;i>0;i--){
            if (pos>=(size-1)){
               VIN=VIN.substr(0,size-1);
               //outfile<<"VIN during: "<<VIN<<".\n";
               size=VIN.size();
               pos=VIN.find_last_of(" ");
            }
         }
         //outfile<<"VIN after: "<<VIN<<".\n";
      }
   }

   void PutTogether(){
      line=YR+TAB+MAKE+TAB+MODEL+TAB+VIN;
   
   }

   void PrintLine(){
      outfile<<line<<endl;
   }





