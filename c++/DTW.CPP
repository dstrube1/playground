# include <iostream.h>
# include <string>
//# include<vector>


   void main() {
   //    int pos;
   //      vector<string> test (20);
   	/*string dot(".");
      cout<<"Dot: "<<dot;
      cout<<"\nDot+Dot: "<<dot+dot<<endl;
   
   	test[0]=dot+dot+dot;
      cout<<"Test[0]: "<<test[0];
      cout<<"\nsize of dot is "<<dot.size();
   
      pos = test[0].find_first_of(dot);
      cout<<"\nposition of 1st dot in test[0] is "<<pos;
      pos=test[0].find_first_of(dot,pos+1);
      cout<<"\nnext position of first dot is "<<pos;
      test[0]+="a";
      pos=test[0].find_first_not_of(dot);
      cout<<"\nFirst place in test[0] without a dot: "<<pos<<endl;
   
      string AYRMAKEVIN("-AYRMAKEVIN2: 98 CADILLAC 6000 SUX; BLAH456BALH987HALB");
      int size=AYRMAKEVIN.size();
      test[1]=	AYRMAKEVIN;
      test[2]=test[1].substr(11,size-11);
      cout<<"for testing, this is B4: "<<test[2];
      pos = test[2].find_first_of(";"), size=test[2].size();
      string n (test[2].substr(0,1)), YR(test[2].substr(3,2)), MAKE(test[2].substr(6,pos-6)), 
         VIN(test[2].substr(pos+2, size-pos));
      cout<<"\nWe're workin on car# "<<n<<"\tposition of 1st ;: "<<pos<<"\tsize: "<<size<<"\nYR: "<<YR<<"\tMAKE: "<<MAKE<<"\tVIN: "<<VIN<<endl;
   
      string B4("1: Bob,Smith; 010101 MS 123456789");
      cout<<"for testing, this is B4: "<<B4<<endl;
      int size=B4.size();
      pos = B4.find_first_of(";"); 
      string n(B4.substr(0,1)), NAME(B4.substr(3,pos-3));
      pos+=2;
      string DOB(B4.substr(pos,6));
      pos+=7;
      string SM(B4.substr(pos,2));
      pos+=3;
      string DLN(B4.substr(pos, size-pos));
      cout<<"NAME: "<<NAME<<"\tDOB: "<<DOB<<"\tSM: "<<SM<<"\nDLN: "<<DLN<<endl;
   
      string blah(10u, ' ');
      cout<<"this->"<<blah<<"<- is blah\n";
      test[0]= blah;
      test[1]=(10u,' ');
      cout<<"this->"<<test[0]<<"<- is test[0]\n";
      cout<<"this->"<<test[1]<<"<- is test[1], which doesnt work\n";
   
      string blah("bleh");
      char hey='hi'; //this might not work, if not,
      char hey ='h';
   //THIS WONT WORK CUZ ITS A STRING, NOT CHAR:
   blah.strupr();
   //or is it called this way?:
   strupr(blah);
   //this probly will work:
   hey.strupr();
   //dtw?:
      strupr(blah.c_str());
      cout<<blah<<endl;
      cout <<hey<<endl;
   */
      //WHERE N=# of payee
   //B4 comes in like this:
   	//n: NAME; ADDRESS; CITY; STZIP
      string B4;
      cout<<"input loss payee: n: NAME; ADDRESS; CITY; STZIP\n";
      getline(cin, B4);
      int semi1=B4.find_first_of(";");
      int semi2=B4.find_first_of(";", semi1+1);
      int semi3=B4.find_first_of(";", semi2+1);
      int size=B4.size();
      cout<<"1st semi is here: "<<semi1<<endl;
      cout<<"2nd semi is here: "<<semi2<<endl;
      cout<<"3rd semi is here: "<<semi3<<endl;
   
      string n (B4.substr(0,1)), LPNAME (B4.substr(3, semi1-3));
      cout<<"Loss payee #"<<n<<"'s name: "<<LPNAME<<endl;
      string LPADDY (B4.substr(semi1+2, (semi2-semi1-2)));
      cout<<"addy :"<<LPADDY<<".\n";
      string LPCITY (B4.substr(semi2+2, (semi3-semi2-2)));
      cout<<"city :"<<LPCITY<<".\n";
      string LPSTZIP (B4.substr(semi3+2, (size-semi3-2)));
      cout<<"stzip :"<<LPSTZIP<<".\n";
   
      string LP1, LP2, LP3;
   	LPNAME.resize(22);
   	LPADDY.resize(29);
   	LPCITY.resize(18);
   	LPSTZIP.resize(7);
   
      if (n=="1"){
         LP1 = LPNAME+LPADDY+LPCITY+LPSTZIP;
      	cout<<LP1<<endl;
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