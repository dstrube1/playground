/*******************************
DFP01.cpp - DataFormatProgram01 like DFP0, but WITHOUT an input file
this prog reads input from the console
then reconstructs / outputs it in a manner as required by the Safeway Interface
*******************************/

# include <iostream.h>
//# include <iomanip.h>
# include <string>
# include <fstream.h>

	/************************FUNCTIONS***************************/
   void ResetStrings ();
	//pre: line, required and optional strings exist
	//post: strings are reset to pre-data input format (PDIF)
   void ReplaceLines();
	//pre: lines are in PDIF
	//post: post data input format
   void PrintLines();
   //pre:
	//post: lines printed to output file
   string setReqsnOpts(int linum);
   //pre: linum = number of line being tested; stremp = string being tested
	//post: stremp is either put into a required string, or sent to setOpts
   void setOpts(string stremp);
   //pre: stremp = string being tested
	//post: stremp is put into an optional string &/or spat back with error
   void AYR_MAKE_VIN(string B4);
   //pre: B4= string of additional vehicle data
	//post: additional vehicle data are put into optional strings
   void LossPayee(string B4);
	//pre: B4= string of Loss Payee data
	//post: Loss Payee data are put into optional strings
   void AN_DOB_SM_DLN(string B4);
   //pre: B4= string of additional applicant data
	//post: additional applicant data are put into optional strings

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
   ASR22a2FR, ASR22a2R, ASR22a3FR, ASR22a3R, LP1, LP2, LP3, 
   LP3STZIP, AN1, ADOB1, ASM1, ADLN1, AN2, ADOB2, ASM2, ADLN2, AN3, ADOB3, ASM3, ADLN3, 
   END_P_DOT12, END_P_DOT34, END_P_DOT5;
	//Constants:
   string MT(""), dot("."), semi(";"), comma(","), breaker("==="), breakreq(" or complete the app (===): "), 
   optreq("an optional"), endprog("!"), endprogreq(" (or ! to end program): "),
   enterreq("Enter "), refreq("a 6 digit reference number"), subreq("a 4 digit subagent: "), namereq("the name: "), 
   addyreq("the street address: "), cityreq("the city: "), stzipreq("the 7 digit stzip: "), 
   terreq("the 3 digit territory: "), fromreq("the 6 digit from: "), toreq("the 6 digit to: "), yrreq("the 2 digit year of the first car: "), 
   makereq("the make and model: "), vinreq("the vin: "), milereq("the miles: "), occreq("the occupation: "), 
   dobreq("the 6 digit date of birth: "), smreq("the sex and status: "), dlnreq("the dln: "), 
   output_cycle_break("==============================================================");

	// open file for output of formatted Safeway data
   ofstream outfile("out.txt");


   int main(){
      ResetStrings(); 
   
      cout<<" DISCLAIMER:\nTHE PURPOSE OF THIS PROGRAM IS MAINLY TO REARRANGE DATA, ie FORMAT TEXT.\n"
         <<"SEMANTICALLY & WITH A FEW EXCEPTIONS, IT DOES NOT COMPUTE OR CALCULATE ANYTHING.\n"
         <<"THEREFORE THE DATA ENTERER GENERALLY RETAINS THE RESPONSIBILITY TO BE PRECISE \n"
         <<"AND ACCURATE.\n";
   
      string temp;    
      unsigned int count=1, sum_of_apps=0;
   
      cout<<"What's yer name?: ";
      getline(cin, temp);
      cout <<"Guten Tag "<<temp<<".\n";
   
      while(temp!=endprog) {
      
         if (temp!=breaker){
            if (temp.size()>1&&temp.substr(temp.size()-1,1)==" ")
               //this permits one extra space, no more.
               temp=temp.substr(0,temp.size()-1);
         
            temp=setReqsnOpts(count);
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
         
         	//reset input string or prog will go into infinite loop:
         	//!=MT due to pre of test
            temp=dot;
         
         }
         count++;
      
         if (count>37){
            cout<<"\nSilly human- line count is too high - You forgot the app cycle breaker (===).\n";
            temp=endprog;
         }
      }
   
   
      //outfile.close(); //this doesnt seem necessary, nor harmful
   
      cout<<endl<<sum_of_apps<<" application(s) formatted and ready to be processed. Have a burger-rific day!=D\n"
         <<"Hit enter to end";
      getline(cin,temp);
   
      return 0;
   }





   string setReqsnOpts (int linum){
      string stremp;
      cout<<enterreq;
      if (linum==1){ //REF
         cout<<refreq<<endprogreq;
         getline(cin, stremp);
         if (stremp.size()>=4){
            SEQ=stremp.substr(2,4); 	//SEQ
            REF=stremp; 
         }
      } 
      else if (linum==2){ //SUBAGENT
         cout <<subreq;
         getline(cin, stremp);
         SUBAGENT=stremp;
      }
      else if (linum==3){ //NAME
         cout <<namereq;
         getline(cin, stremp);
         NAME=stremp;
      } 
      else if (linum==4){ //ADDRESS
         cout <<addyreq;
         getline(cin, stremp);
         ADDRESS=stremp;
      }
      else if (linum==5){ //CITY
         cout <<cityreq;
         getline(cin, stremp);
         CITY=stremp;
      }
      else if (linum==6){ //STZIP
         cout <<stzipreq;
         getline(cin, stremp);
         STZIP=stremp;
      }
      else if (linum==7){ //TER
         cout <<terreq;
         getline(cin, stremp);
         TER=stremp;
      
      }
      else if (linum==8){ //FROM
         cout <<fromreq;
         getline(cin, stremp);
         FROM=stremp;
      
      }
      else if (linum==9){ //TO
         cout <<toreq;
         getline(cin, stremp);
         TO=stremp;
      
      }
      else if (linum==10){ //YR
         cout <<yrreq;
         getline(cin, stremp);
         YR=stremp;
      }
      else if (linum==11){ // MAKE
         cout <<makereq;
         getline(cin, stremp);
         MAKE=stremp;
      
      }
      else if (linum==12){ //VIN 
         cout <<vinreq;
         getline(cin, stremp);
         VIN=stremp;
      
      }
      else if (linum==13){ //MILES
         cout <<milereq;
         getline(cin, stremp);
         MILES=stremp;
      
      }
      else if (linum==14){ //OCC
         cout <<occreq;
         getline(cin, stremp);
         OCC=stremp;
      
      }
      else if (linum==15){ //DOB 
         cout <<dobreq;
         getline(cin, stremp);
         DOB=stremp;
      
      }
      else if (linum==16){ //SM 
         cout <<smreq;
         getline(cin, stremp);
         SM=stremp;
      
      }
      else if (linum==17){ //DLN
         cout <<dlnreq;
         getline(cin, stremp);
         DLN=stremp;
      
      }	
      else if (linum> 17){//optional!!!
         cout<<optreq+breakreq;
         getline(cin, stremp); 
         if (stremp==breaker){
         //do nothin
         }
         else if(stremp.substr(0,1)!="-")
            cout<<"\nIncorrect optional format - optional \""<<stremp<<"\" ignored. Review DFPINEX.txt\n";
         else{
            setOpts(stremp);
         }
      }
   
      return stremp;
   }



   void setOpts(string stremp){
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
      if (size>=10&&stremp.substr(1,3)=="F: "){
         MONTHF="F";		
         NAME_OF_EXCLUSION=stremp.substr(4,6);
      }
      else if (size>=9&&stremp.substr(1,5)=="NET: "){
         NET=stremp.substr(6,(size-6));
      }
      else if (size>=7&&stremp.substr(1,4)=="CO: "){
         COJRSR=stremp.substr(5,(size-5));
      
      }
      else if (size>=3&&stremp.substr(1,3)=="MVR"){
         MVR="Y";
      }
      else if (size>=7 &&stremp.substr(1,5)=="MED: "){
         MED=stremp.substr(6,1);
      }
      else if (size>=6 &&stremp.substr(1,4)=="UM: "){
         UNINSURED_MOTORIST=stremp.substr(5,1);
      } 
      else if (size>=3 &&stremp.substr(1,2)=="PU"){ //PUNITIVE - CARPS DOT2
         car1psdot2="9";
      	/////////////////SKIPPING DOTS 3-6 FOR NOW 
      }
      else if (size>=3&& stremp.substr(1,2)=="DI"){ //DEV DISC
         DEVDISC1="010-";
      }
      else if (size>=5 &&stremp.substr(1,4)=="SR22"){ //SR22
         SR22a_R="F";
         if (stremp.substr(5,1)=="A") //SR22A
            SR22a_FR="1";
         else
            SR22a_FR="9";
      }
      else if (size>=8 &&stremp.substr(1,6)=="CPCL: "){
         COMP_COLL=stremp.substr(7,1);
      }
      else if (size>=7 &&stremp.substr(1,5)=="SYM: "){
         SYMBOL=stremp.substr(6,(size-6));
      } 
      else if (size>=3 &&stremp.substr(1,2)=="TW"){
         TOWING="3";
      }
      else if (size>=10 &&stremp.substr(1,10)=="AYRMAKEVIN"){
         if (stremp.find(semi)==-1){
            error = true;
            cout<<"Error - ADDITIONAL VEHICLE:\""<<stremp<<"\"; ";
         }
         car1psdot1="1";//CAR1MC
         AYR_MAKE_VIN(stremp.substr(11,size-11));
      
      }
      else if (size>=5 &&stremp.substr(1,2)=="LP"){
         if (stremp.find(semi)==-1){
            error = true;
            cout<<"Error - LOSS PAYEE:\""<<stremp<<"\"; ";
         }
         LossPayee(stremp.substr(3,size-3));	   
      
      
      } 									
      else if (size>=14 &&stremp.substr(1,13)=="AN/DOB/SM/DLN"){ //additional applicants:
         if (stremp.find(semi)==-1||stremp.find(comma)==-1){
            error = true;
            cout<<"Error - ADDITIONAL PERSON:\""<<stremp<<"\"; ";
         }
         AN_DOB_SM_DLN(stremp.substr(14,size-14));
      
      } 									
      else if (size>=7 &&stremp.substr(1,4)=="PO: "){
         END_P_DOT12=stremp.substr(5,2);
      } 									
      else if (size>=8 &&stremp.substr(1,5)=="OSL: "){
         END_P_DOT34=stremp.substr(6,2);
      
      } 									
      else if (size>=4 &&stremp.substr(1,3)=="STU"){ //student discount
         car3psdot1="5"; 
      
      	/*} 									
      else if (size>=&&stremp.substr(1,)==""){
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
   //WHERE N=# of payee
   //B4 comes in like this:
   	//n: NAME; ADDRESS; CITY; STZIP
      int semi1=B4.find_first_of(semi);
      int semi2=B4.find_first_of(semi, semi1+1);
      int semi3=B4.find_first_of(semi, semi2+1);
      int size=B4.size();
   
      string n (B4.substr(0,1)), LPNAME (B4.substr(3, semi1-3));
      string LPADDY (B4.substr(semi1+2, (semi2-semi1-2)));
      string LPCITY (B4.substr(semi2+2, (semi3-semi2-2)));
      string LPSTZIP (B4.substr(semi3+2, (size-semi3-2)));
   
      LPNAME.resize(22);
      LPADDY.resize(29);
      LPCITY.resize(18);
      LPSTZIP.resize(7);
   
      if (n=="1"){
         LP1 = LPNAME+LPADDY+LPCITY+LPSTZIP;
      }
      else if (n=="2"){
         LP2 = LPNAME+LPADDY+LPCITY+LPSTZIP;
      }
      else if (n=="3"){
         LP3 = LPNAME+LPADDY+LPCITY+LPSTZIP;
      
      }
      else
         cout<<"Something funky happened with Loss Payee #"<<n<<endl;
   
   
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
      AVIN3=DEV3=AMI2=AMI3=LP1=LP2=LP3=AN1=ADOB1=ASM1=ADLN1=AN2=ADOB2=ASM2=ADLN2=MT;
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
      line8.replace(28, DEV2.size(), DEV2);
      line9.replace(148, AMI2.size(),AMI2);
      line11.replace(78, AYR3.size(), AYR3);
      line11.replace(86, AMAKE3.size(), AMAKE3);
      line11.replace(116, AVIN3.size(), AVIN3);
      line10.replace(28, DEV3.size(), DEV3);
      line11.replace(148, AMI3.size(),AMI3);
      line14.replace(77, LP1.size(), LP1);
      line15.replace(77, LP2.size(), LP2);
      line16.replace(77, LP3.size(), LP3);
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

