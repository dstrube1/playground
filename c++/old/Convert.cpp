//David Russell &Rachel Brockington (leader)
//Seha Loo
//CS 220-02
//2-26-98
//Assignment #7- convert.cpp
//allows a user to convert lengths &/or weights.


#include<iostream.h>
#include<math.h>
#include<float.h>

//these are the functions for type of conversion:
void conlen ();
void conwet ();

//these are the functions for actual conversions:
void conm2ft ();
void conft2m ();
void conkg2lb ();
void conlb2kg ();

const float gponz= 28.35, cmpin= 2.54; //constants for conversions.
const int gpkg= 1000, onzplb=16, cmpm=100, inpft=12;  //cfc
int choice, ft, in, m, cm, kg, g, lb, onz;  //variables for input/output
char choice2;          //variable for "does user want to continue/repeat?"

int main()
{
char convype;    //type of conversion
cout<<"I will now calculate the conversions "
	 <<"of various measurements.\n";
do{
	cout<<endl<<"Press L for conversions of length."<<endl
		 <<"Press W for conversions of weight."<<endl
		 <<"Press E to end."<<endl;
	cin>>convype;
	switch (convype)
		{
		case'L':
			conlen();
			break;
		case'W':
			conwet();
			break;
		case'E':
			cout<<"Goodbye.\n";
			break;
		default:
			cout<<"Please try again.\n"<<endl;
			break;
			}
		}while (convype!='E');
cout<<"End of program";
return 0;
}

void conlen ()  //if user chooses conversions of length
{
choice2='a';
while (choice2=='a')
	{
	cout<<endl<< "To convert from feet and inches to meters and centimeters,\n"
		 <<"press 1."<<endl
		 <<"To convert from meters and centimeters to feet and inches,\n"
		 <<"press2."<<endl;
	cin>> choice;
	if (choice==1)
		 conft2m();
	if (choice==2)
		conm2ft();
	if (choice!=1&&choice!=2)
		cout<<"Incorrect!"<<endl;
	cout<<endl<<"Does user wish to continue with conversions of length?\n"
		 <<"If so, press a."<<endl;
	cin>>choice2;
	}
}

void conwet ()  //if user chooses conversions of weight
{
choice2='a';
while (choice2=='a')
	{
	cout<< endl<<"To convert from kilograms and grams to pounds and ounces,\n"
		 <<"press 1."<<endl<<"To convert from pounds and ounces to "
		 <<"kilograms and grams,"<<endl<<"press 2.\n";
	cin>>choice;
	if (choice==1)
		 conkg2lb();
	if (choice==2)
		conlb2kg();
	if (choice!=1&&choice!=2)
		cout<<"Incorrect!"<<endl;
	cout<<endl<<"Does user wish to continue with conversions of weight?\n"
		 <<"If so, press a."<<endl;
	cin>>choice2;
	}
}

void conft2m ()          //if user chooses feet to meters
{
choice2='a';
while (choice2=='a')
	{
	cout<<endl<<"How many feet?\n";
	cin>>ft;
	cout<<endl<<"How many inches?\n";
	cin>> in;
	m=(ft*inpft+in)*cmpin;
	cm=m%100;
	m=m/100;
	cout<<endl<<"In "<<ft<<" feet and "<<in<<" inches, "
		 <<"there are approximately "<<m<<" meter(s) and "<<cm
		 <<" centimeter(s)."<<endl;
	cout<<endl<<"Does user wish to repeat this type of conversion?\n"
		 <<"If so, press a."<<endl;
	cin>>choice2;
	}
}

void conm2ft ()			//if user chooses meters to feet
{
choice2='a';
while (choice2=='a')
	{
	cout<<endl<<"How many meters?\n";
	cin>>m;
	cout<<endl<<"How many centimeters?\n";
	cin>>cm;
	ft=(m*cmpm+cm)/cmpin;
	in=ft%inpft;
	ft/=inpft;
	cout<<endl<<"In "<<m<<" meters and "<<cm<<" centimeters, "
		 <<"there are approximately "<<ft<<" feet and "<<in<<" inches."<<endl;
	cout<<endl<<"Does user wish to repeat this type of conversion?\n"
		 <<"If so, press a."<<endl;
	cin>>choice2;
	}
}

void conkg2lb ()    //if user chooses kilograms to pounds
{
choice2='a';
while (choice2=='a')
	{
	cout<<endl<<"How many kilograms?\n";
	cin>>kg;
	cout<<"How many grams?\n";
	cin>>g;
	lb=(kg*gpkg+g)/gponz;
	onz=lb%onzplb;
	lb=lb/onzplb;
	cout<<endl<<"In "<<kg<<" kilograms and "<<g<<" grams, there are "
		 <<"approximately "<<lb<<" pounds and "<<onz<<" ounces."<<endl;
	cout<<endl<<"Does user wish to repeat this type of conversion?\n"
		 <<"If so, press a."<<endl;
	cin>>choice2;
	}
}

void conlb2kg ()      //if user chooses pounds to kilograms
{
choice2='a';
while (choice2=='a')
	{
	cout<<endl<<"How many pounds?\n";
	cin>>lb;
	cout<<"How many ounces?\n";
	cin>>onz;
	kg=(lb*onzplb+onz)*gponz;
	g=kg%gpkg;
	kg=kg/gpkg;
	cout<<endl<<"In "<<lb<<" pounds and "<<onz<<" ounces, there are "
		 <<"approximately "<<kg<<" kilograms and "<<g<<" grams."<<endl;
	cout<<endl<<"Does user wish to repeat this type of conversion?\n"
		 <<"If so, press a."<<endl;
	cin>>choice2;
	}
}

