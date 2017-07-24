/*******************************
DFP0.cpp - DataFormatProgram0 like DFP1, but without vectors
David Strube
11-01-01
this prog takes in a text file, opens it, reads it line by line, 
then reconstructs / outputs it in a manner as required by the Safeway Interface
*******************************/


# include <iostream.h>
# include <string>
# include <fstream.h>

	/************************FUNCTIONS***************************/
   void ResetStrings ();
	//pre: line, required and optional strings exist
	//post: strings are reset to pre-data input format (PDIF)
   void ReplaceLines();
	//pre: lines is in PDIF
	//post: post data input format
   void PrintLines();
   //pre:
	//post: lines printed to console &/or output file
   void test4REQUIREDSandOPTIONALS(int linum, string stremp);
   //pre: linum = number of line being tested; stremp = string being tested
	//post: stremp is either put into requireds, or sent to test4OPTIONALS, and/or spat back with error
   void test4OPTIONALS(string stremp);
   //pre: stremp = string being tested
	//post: stremp is put into optionals &/or spat back with error
   void AYR_MAKE_VIN(string B4);
   //pre: B4= string of additional vehicle data
	//post: strings of additional vehicle data is put into optionals
   void LossPayee(string B4);
	//pre: B4= string of Loss Payee data
	//post: strings of Loss Payee data is put into optionals
   void AN_DOB_SM_DLN(string B4);
   //pre: B4= string of additional applicant data
	//post: strings of additional applicant data is put into optionals

	/****************************STRINGS**************************/
	//Lines:
   string line1, line2, line3, line4, line5, line6, line7, line8, line9, line10, line11, line12, line13, line14,
   line15, line16, line17, line18, line19, line20, line21;
	//Requireds:
   string SEQ, REF, SUBAGENT, NAME, ADDRESS, CITY, STZIP, TER, FROM, TO, 
   YR, MAKE, VIN, MILES, OCC, DOB, SM, DLN;
	//Optionals:
   string MONTHF, NAME_OF_EXCLUSION, NET, COJRSR, MVR, MED, UNINSURED_MOTORIST, car1psdot1, 
   car1psdot2, car2psdot1, car2psdot2, car3psdot1, car3psdot2, DEVDISC1, SR22a_FR, SR22a_R, 
   COMP_COLL, SYMBOL, TOWING, AYR2, AMAKE2, AVIN2, DEV2, AMI2, AYR3, AMAKE3, AVIN3, DEV3, AMI3, 
   ASR22a2FR, ASR22a2R, ASR22a3FR, ASR22a3R,
   LP1NAME, LP1ADDY, LP1CITY, LP1STZIP, LP2NAME, LP2ADDY, LP2CITY, LP2STZIP, LP3NAME, LP3ADDY, LP3CITY, 
   LP3STZIP, AN1, ADOB1, ASM1, ADLN1, AN2, ADOB2, ASM2, ADLN2, AN3, ADOB3, ASM3, ADLN3, 
   END_P_DOT12, END_P_DOT34, END_P_DOT5;
	//Constants:
   const string MT(""), dot("."), semi(";"), comma(","), breaker("==="), 
   output_cycle_break("==============================================================");

	// filehandles for input & output of raw & formatted Safeway data
   ifstream infile("in.txt"); //for example, see "input example.txt"
   ofstream outfile("out.txt");  //for example, see "output example.txt"
	//files needs to be in the same dir as the exe


///////////////MAIN
    int main(){
      ResetStrings(); 
   
      string temp;    
      unsigned int count=1, sum_of_apps=0;
   
   	//Greeting from 1st line of input - user's name
      getline(infile, temp);
      cout <<"Guten Tag "<<temp<<"!"<<endl;
   
      while( getline(infile, temp) ) {
      // read words until end of file
      
         if (temp!=breaker){
            if (temp.substr(temp.size()-1,1)==" ")
               //this permits one extra space, no more.
               temp=temp.substr(0,temp.size()-1);
         
            test4REQUIREDSandOPTIONALS (count, temp);
         }	
         else{
            //we've hit the breaker = end of app = must put it all together...
            ReplaceLines(); 
         	//print out ...
            PrintLines(); 
            //and reset the line count and strings before going to the next app
            count=0;
            ResetStrings();
         
         	//increment app counter
            sum_of_apps++;
         	//let the program console know we've completed one app
            cout<<dot;
         }
         count++;
      
         if (count>37)
            cout<<"\nSilly human- line count is too high - You forgot the app cycle breaker (===).\n";
      }
   
      infile.close(); //this doesnt seem necessary, nor harmful
      outfile.close(); 
   
      cout<<endl<<sum_of_apps<<" application(s) formatted and ready to be processed. Have a burger-rific day!=D\n";
      return 0;
   }
////////END MAIN

//////////BEGIN OTHER FUNCTIONS:
    void ResetStrings (){
   		//LINES
      line1="SEQ#XXXXXXBRK#XXXXXXXXXXXXX XXXXXX999999XXXXX      ";
      line2="XXXXXXXXXXXXXXXNAME                                    XXXXXXXXX   ";
      line3="XXXX                         XXXXXXXXXREF#    XXXXX          XXXXXX   XXXX ";
      line4="XX                              XXXXXX                    XXXXXXXXSTZIP99";
      line5="                                                                               TERXXXXXXFROM01XXXXTO0102XXXXXXXXXXXXXXXXX5XXXX5XXXXX XXXXX XXXX XXXX ";
      line6="XXXXXXXXX   XXXXX......XXXXX    XXXX XXXX XXXX XXXX ";
      line7="                                                                                 XXXXX                         XXXXXVIN               XXXXX  XXXXXXX     ";
      line8="XXXXXXXXX   XXXXX......XXXXX    XXXX XXXX XXXX XXXX ";
      line9="                                                                                 XXXXX                         XXXXX                  XXXXX  XXXXXXX     ";
      line10="XXXXXXXXX   XXXXX......XXXXX    XXXX XXXX XXXX XXXX ";
      line11="                                                                                 XXXXX                         XXXXX                  XXXXX  XXXXXXX     ";
      line12="XXXXXXXXXXXXX                           ";
      line13="";
      line14="                                                                                                                                                         ";
      line15="                                                                                                                                                         ";
      line16="                                                                                                                                                         ";
      //might need to lengthen 17-21 for D dots
      line17="                                                                                                   XXXX      XXXX  XXX              XXX.....XXX  XXX ";
      line18="";
      line19="                                                                                                    XXX      XXXX  XXX              XXX.....XXX  XXX ";
      line20="                                                                                                    XXX      XXXX  XXX              XXX.....XXX  XXX ";
      line21="                                                                                                    XXX      XXXX  XXX              XXX.....XXX  XXX ";
   
   		//REQUIREDS:
      SEQ=REF=SUBAGENT=NAME=ADDRESS=CITY=STZIP=TER=FROM=TO=YR=MAKE=VIN=MILES=OCC=DOB=SM=DLN=MT;
   
   
   		//OPTIONALS:
      MONTHF=NAME_OF_EXCLUSION=NET=COJRSR=MVR=MED=UNINSURED_MOTORIST=MT;
      car1psdot1=car1psdot2=car2psdot1=car2psdot2=car3psdot1=car3psdot2=dot;
      DEVDISC1=SR22a_FR=SR22a_R=COMP_COLL=SYMBOL=TOWING=AYR2=AMAKE2=AVIN2=DEV2=AYR3=AMAKE3=MT;
      ASR22a2FR=ASR22a2R=ASR22a3FR=ASR22a3R=MT;
      AVIN3=DEV3=AMI2=AMI3=LP1NAME=LP1ADDY=LP1CITY=LP1STZIP=LP2NAME=LP2ADDY=LP2CITY=LP2STZIP=MT;
      LP3NAME=LP3ADDY=LP3CITY=LP3STZIP=AN1=ADOB1=ASM1=ADLN1=AN2=ADOB2=ASM2=ADLN2=MT;
      AN3=ADOB3=ASM3=ADLN3=MT;
      END_P_DOT12=END_P_DOT34=dot+dot;
      END_P_DOT5=dot;
   
   }



    void ReplaceLines(){
      line1.replace(0, SEQ.size(),SEQ); 
      line1.replace(10, SUBAGENT.size(),SUBAGENT);
      line2.replace(14, NAME.size(),NAME);	
      line3.replace(38, REF.size(),REF);
      line4.replace(2, ADDRESS.size(),ADDRESS);
      line4.replace(38, CITY.size(),CITY);
      line4.replace(66, STZIP.size(),STZIP);
      line5.replace(79, TER.size(),TER);
      line5.replace(88, FROM.size(),FROM);
      line5.replace(98, TO.size(),TO);
      line7.replace(78, YR.size(),YR);
      line7.replace(86, MAKE.size(),MAKE);
      line7.replace(116, VIN.size(),VIN);
      line7.replace(148, MILES.size(),MILES);
      line17.replace(79, OCC.size(),OCC);
      line17.replace(103, DOB.size(),DOB);
      line17.replace(113, SM.size(),SM);
      line17.replace(118, DLN.size(),DLN);
   //optionals:
      line1.replace(27, MONTHF.size(), MONTHF);
      line12.replace(13, NAME_OF_EXCLUSION.size(), NAME_OF_EXCLUSION);
      line1.replace(45, NET.size(), NET);
      line2.replace(64, COJRSR.size(), COJRSR);
      line3.replace(74, MVR.size(), MVR);
      line5.replace(132, MED.size(), MED);
      line5.replace(143, UNINSURED_MOTORIST.size(), UNINSURED_MOTORIST);
      line6.replace(17, car1psdot1.size(), car1psdot1);
      line6.replace(18, car1psdot2.size(), car1psdot2);
      line8.replace(17, car2psdot1.size(), car2psdot1);
      line8.replace(18, car2psdot2.size(), car2psdot2);
      line10.replace(17, car3psdot1.size(), car3psdot1);
      line10.replace(18, car3psdot2.size(), car3psdot2);
      line6.replace(28, DEVDISC1.size(), DEVDISC1);
      line6.replace(36, SR22a_FR.size(), SR22a_FR);
      line17.replace(148, SR22a_R.size(), SR22a_R);
      line6.replace(42, COMP_COLL.size(), COMP_COLL);
      line6.replace(47, COMP_COLL.size(), COMP_COLL);
      line7.replace(139, SYMBOL.size(), SYMBOL);
      line6.replace(52, TOWING.size(), TOWING);
      line9.replace(78, AYR2.size(), AYR2);
      line9.replace(86, AMAKE2.size(), AMAKE2);
      line9.replace(116, AVIN2.size(), AVIN2);
      line8.replace(29, DEV2.size(), DEV2);
      line9.replace(148, AMI2.size(),AMI2);
      line11.replace(78, AYR3.size(), AYR3);
      line11.replace(86, AMAKE3.size(), AMAKE3);
      line11.replace(116, AVIN3.size(), AVIN3);
      line10.replace(29, DEV3.size(), DEV3);
      line11.replace(148, AMI3.size(),AMI3);
      line14.replace(77, LP1NAME.size(), LP1NAME);
      line14.replace(99, LP1ADDY.size(), LP1ADDY);
      line14.replace(128, LP1CITY.size(), LP1CITY);
      line14.replace(146, LP1STZIP.size(), LP1STZIP);
      line15.replace(77, LP2NAME.size(), LP2NAME);
      line15.replace(99, LP2ADDY.size(), LP2ADDY);
      line15.replace(128, LP2CITY.size(), LP2CITY);
      line15.replace(146, LP2STZIP.size(), LP2STZIP);
      line16.replace(77, LP3NAME.size(), LP3NAME);
      line16.replace(99, LP3ADDY.size(), LP3ADDY);
      line16.replace(128, LP3CITY.size(), LP3CITY);
      line16.replace(146, LP3STZIP.size(), LP3STZIP);
      line19.replace(75, AN1.size(), AN1);
      line19.replace(102, ADOB1.size(), ADOB1);
      line19.replace(113, ASM1.size(), ASM1);
      line19.replace(118, ADLN1.size(), ADLN1);
      line20.replace(75, AN2.size(), AN2);
      line20.replace(102, ADOB2.size(), ADOB2);
      line20.replace(113, ASM2.size(), ASM2);
      line20.replace(118, ADLN2.size(), ADLN2);
      line21.replace(75, AN3.size(), AN3);
      line21.replace(102, ADOB3.size(), ADOB3);
      line21.replace(113, ASM3.size(), ASM3);
      line21.replace(118, ADLN3.size(), ADLN3);
      line17.replace(135, END_P_DOT12.size(), END_P_DOT12);
      line17.replace(137, END_P_DOT34.size(), END_P_DOT34);
      line17.replace(139, END_P_DOT5.size(), END_P_DOT5);
   
   }



    void PrintLines(){
      outfile<<line1<<endl;
      outfile<<line2<<endl;
      outfile<<line3<<endl;
      outfile<<line4<<endl;
      outfile<<line5<<endl;
      outfile<<line6<<endl;
      outfile<<line7<<endl;
      outfile<<line8<<endl;
      outfile<<line9<<endl;
      outfile<<line10<<endl;
      outfile<<line11<<endl;
      outfile<<line12<<endl;
      outfile<<line13<<endl;
      outfile<<line14<<endl;
      outfile<<line15<<endl;
      outfile<<line16<<endl;
      outfile<<line17<<endl;
      outfile<<line18<<endl;
      outfile<<line19<<endl;
      outfile<<line20<<endl;
      outfile<<line21<<endl;
      outfile<<output_cycle_break<<endl;
   }



    void test4REQUIREDSandOPTIONALS (int linum, string stremp){
      int size=stremp.size();
      bool error=false;
      if (linum==1){ //REF
         if (size!=6){
            error=true;
            cout<<"Error - REF#: \""<<stremp<<"\"; ";
         }
         SEQ=stremp.substr(2,4); 	//SEQ
         REF=stremp; 
      } 
      else if (linum==2){ //SUBAGENT
         if (size!=4){
            error=true;
            cout <<"Error - SUBAGENT; ";
         }
         SUBAGENT=stremp;
      }
      else if (linum==3){ //NAME
         if (size<4||size>40||stremp.find(comma)==-1){
            error=true;
            cout<<"Error - NAME: \""<<stremp<<"\"; ";
         }
         NAME=stremp;
      } 
      else if (linum==4){ //ADDRESS
         if (size<4||size>30){
            error=true;
            cout<<"Error - ADDRESS: \""<<stremp<<"\"; ";
         }
         ADDRESS=stremp;
      }
      else if (linum==5){ //CITY
         if (size<4||size>20){
            error=true;
            cout<<"Error - CITY: \""<<stremp<<"\"; ";
         }
         CITY=stremp;
      }
      else if (linum==6){ //STZIP
         if (size!=7){
            error=true;
            cout<<"Error - STZIP: \""<<stremp<<"\"; ";
         }
         STZIP=stremp;
      }
      else if (linum==7){ //TER
         if (size!=3){
            error=true;
            cout<<"Error - TER: \""<<stremp<<"\"; ";
         }
         TER=stremp;
      
      }
      else if (linum==8){ //FROM
         if (size!=6){
            error=true;
            cout<<"Error - FROM: \""<<stremp<<"\"; ";
         }
         FROM=stremp;
      
      }
      else if (linum==9){ //TO
         if (size!=6){
            error=true;
            cout<<"Error - TO: \""<<stremp<<"\"; ";
         }
         TO=stremp;
      
      }
      else if (linum==10){ //YR
         if (size!=2){
            error=true;
            cout<<"Error - YR: \""<<stremp<<"\"; ";
         }
         YR=stremp;
      }
      else if (linum==11){ // MAKE
         if (size<5||size>25){
            error=true;
            cout<<"Error - MAKE: \""<<stremp<<"\"; ";
         }
         MAKE=stremp;
      
      }
      else if (linum==12){ //VIN 
         if (size<9||size>18){
            error=true;
            cout<<"Error - VIN: \""<<stremp<<"\"; ";
         }
         VIN=stremp;
      
      }
      else if (linum==13){ //MILES
         if (size<1||size>4){
            error=true;
            cout<<"Error - MILES: \""<<stremp<<"\"; ";
         }
         MILES=stremp;
      
      }
      else if (linum==14){ //OCC
         if (size<3||size>20){
            error=true;
            cout<<"Error - OCC: \""<<stremp<<"\"; ";
         }
         OCC=stremp;
      
      }
      else if (linum==15){ //DOB 
         if (size!=6){
            error=true;
            cout<<"Error - DOB: \""<<stremp<<"\"; ";
         }
         DOB=stremp;
      
      }
      else if (linum==16){ //SM 
         if (size!=2){
            error=true;
            cout<<"Error - SM: \""<<stremp<<"\"; ";
         }
         SM=stremp;
      
      }
      else if (linum==17){ //DLN
         if (size<5||size>14){
            error=true;
            cout<<"Error - DLN: \""<<stremp<<"\"; ";
         }
         DLN=stremp;
      
      }	
      else if (linum> 17){//optional!!!
         if(stremp.substr(0,1)!="-")
            cout<<"\nIncorrect optional format - optional \""<<stremp<<"\" ignored. Review DFPINEX.txt\n";
         else{
            test4OPTIONALS(stremp);
         }
      }
         //done with errors for this app:
      if (error)
         cout<<endl;
   
   }



    void test4OPTIONALS(string stremp){
      bool error = false;
      int size=stremp.size();
   	/*
   	where 
   		v opt
   	-F: 080101
   	 ^opt head
   	AND optionals[n] = optional var
   	if (stremp.substr(1,len of opt head)="opt head")
   		optionals[n]=stremp.substr(len of opt head+1, len of opt (either fixed or size-pos))
   	*/
      if (stremp.substr(1,3)=="F: "){
         if (size!=10){
            error = true;
            cout<<"Error - MONTH/NAME OF EXCLUSION: \""<<stremp<<"\"; ";
         }
         MONTHF="F";		
         NAME_OF_EXCLUSION=stremp.substr(4,6);
      }
      else if (stremp.substr(1,5)=="NET: "){
         if (size>12||size<9){
            error = true;
            cout<<"Error - NET: \""<<stremp<<"\"; ";
         }
         NET=stremp.substr(6,(size-6));
      }
      else if (stremp.substr(1,4)=="CO: "){
         if (size<6||size>7){
            error = true;
            cout<<"Error - CO/JR/SR: \""<<stremp<<"\"; ";
         }
         COJRSR=stremp.substr(5,(size-5));
      
      }
      else if (stremp.substr(1,3)=="MVR"){
         MVR="Y";
      }
      else if (stremp.substr(1,5)=="MED: "){
         if (size!=7){
            error = true;
            cout<<"Error - MED PAY LIMIT: \""<<stremp<<"\"; ";
         }
         MED=stremp.substr(6,1);
      }
      else if (stremp.substr(1,4)=="UM: "){
         if (size!=6){
            error = true;
            cout<<"Error - UNINSURED MOTORIST: \""<<stremp<<"\"; ";
         }
         UNINSURED_MOTORIST=stremp.substr(5,1);
      } 
      else if (stremp.substr(1,2)=="PU"){ //PUNITIVE - CARPS DOT2
         car1psdot2="9";
      	/////////////////SKIPPING DOTS 3-6 FOR NOW 
      }
      else if (stremp.substr(1,2)=="DI"){ //DEV DISC
         DEVDISC1="010-";
      }
      else if (stremp.substr(1,4)=="SR22"){ //SR22
         SR22a_R="F";
         if (stremp.substr(5,1)=="A") //SR22A
            SR22a_FR="1";
         else
            SR22a_FR="9";
      }
      else if (stremp.substr(1,6)=="CPCL: "){
         if (size!=8){
            error = true;
            cout<<"Error - COMP/COLL: \""<<stremp<<"\"; ";
         }
         COMP_COLL=stremp.substr(7,1);
      }
      else if (stremp.substr(1,5)=="SYM: "){
         if (size<7||size>8){
            error = true;
            cout<<"Error - SYMBOL: \""<<stremp<<"\"; ";
         }
         SYMBOL=stremp.substr(6,(size-6));
      } 
      else if (stremp.substr(1,2)=="TW"){
         if (size!=3){
            error = true;
            cout<<"Error - TOWING AND LABOR: \""<<stremp<<"\"; ";
         }
         TOWING="3";
      }
      else if (stremp.substr(1,10)=="AYRMAKEVIN"){
         if (stremp.find(semi)==-1){
            error = true;
            cout<<"Error - ADDITIONAL VEHICLE:\""<<stremp<<"\"; ";
         }
         car1psdot1="1";//CAR1MC
         AYR_MAKE_VIN(stremp.substr(11,size-11));
      
      }
      else if (stremp.substr(1,4)=="LP: "){
         if (stremp.find(semi)==-1){
            error = true;
            cout<<"Error - LOSS PAYEE:\""<<stremp<<"\"; ";
         }
         LossPayee(stremp.substr(5,size-5));	   
      
      
      } 									
      else if (stremp.substr(1,13)=="AN/DOB/SM/DLN"){ //additional applicants:
         if (stremp.find(semi)==-1||stremp.find(comma)==-1){
            error = true;
            cout<<"Error - ADDITIONAL PERSON:\""<<stremp<<"\"; ";
         }
         AN_DOB_SM_DLN(stremp.substr(14,size-14));
      
      } 									
      else if (stremp.substr(1,4)=="PO: "){
         if (size!=7){
            error = true;
            cout<<"Error - POINTS: \""<<stremp<<"\"; ";
         }
         END_P_DOT12=stremp.substr(5,2);
      } 									
      else if (stremp.substr(1,5)=="OSL: "){
         if (size!=8){
            error = true;
            cout<<"Error - OUT OF STATE LICENSE: \""<<stremp<<"\"; ";
         }
         END_P_DOT34=stremp.substr(6,2);
      
      } 									
      else if (stremp.substr(1,3)=="STU"){ //student discount
         if (size!=4){
            error = true;
            cout<<"Error - : \""<<stremp<<"\"; ";
         }
         car3psdot1="5"; 
      
      	/*} 									
      else if (stremp.substr(1,)==""){
         if (size!=){
            error = true;
            cout<<"Error - : \""<<stremp<<"\"; ";
         }
         optionals[]=stremp.substr();
      	*/
      } 
      else cout<<"\nUnknown option - Mozel tov\n";
   
   }



    void AYR_MAKE_VIN(string B4){
   		//WHERE N=# OF ADDITIONAL VEHICLE
   		//B4 comes in like this: 
   			// n: YY MAKE; VIN
      int pos = B4.find_first_of(semi), size=B4.size();
      string n (B4.substr(0,1)), AYR(B4.substr(3,2)), AMAKE(B4.substr(6,pos-6)), AVIN(B4.substr(pos+2, size-pos));
      if (n=="2"){
         AYR2=AYR; 
         AMAKE2=AMAKE; 
         AVIN2=AVIN; 
         if (car1psdot1!=dot) 
            car2psdot1=car1psdot1; //CAR2MC or student discount
         car2psdot2=car1psdot2; //CAR2PU
         DEV2=DEVDISC1; //dev2
         AMI2="1";
         ASR22a2FR=SR22a_FR;
         //ASR22a2R=SR22a_R;
      }
      else if (n=="3"){
         AYR3=AYR; 
         AMAKE3=AMAKE; 
         AVIN3=AVIN; 
         if (car1psdot1!=dot) 
            car3psdot1=car1psdot1; //CAR3MC or student discount
         car3psdot2=car1psdot2;//CAR3PU
         DEV3=DEVDISC1; //dev3
         AMI3="1";
         ASR22a3FR=SR22a_FR;
         //ASR22a3R=SR22a_R;
      }
      else cout<<"Something funky happend with additional VEHICLE #"<<n<<endl;
   
   }



    void LossPayee(string B4){
      cout<<"\nLossPayee option coming soon in 2nd edition\n";
   }



    void AN_DOB_SM_DLN(string B4){
   		//WHERE N=# OF person
   		//B4 comes in like this: 
   			// n: NAME; DOB SM DLN
      int pos = B4.find_first_of(semi), size=B4.size();
      string n (B4.substr(0,1)), ANAME (B4.substr(3,pos-3));
      pos+=2;
      string ADOB (B4.substr(pos,6));
      pos+=7;
      string ASM (B4.substr(pos,2));
      pos+=3;
      string ADLN(B4.substr(pos, size-pos));
      if (n=="1"){
         AN1=ANAME;
         ADOB1=ADOB;
         ASM1=ASM;
         ADLN1=ADLN;
      
      }
      else if (n=="2"){
         AN2=ANAME;
         ADOB2=ADOB;
         ASM2=ASM;
         ADLN2=ADLN;
      
      }
      else if (n=="3"){
         AN3=NAME;
         ADOB3=DOB;
         ASM3=SM;
         ADLN3=DLN;
      
      }
      else cout<<"Something funky happend with additional PERSON #"<<n<<endl;
   
   }


