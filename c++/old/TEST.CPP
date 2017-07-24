//David Russell
//Seha Loo
//CS 220-02
//(date)
//Assignment #
//excercise #
//description

#include <iostream.h>
#include<math.h>
void Howmany ();
void Takeon (int);

void main()
{
Howmany();
}

void Howmany ()
{
int hm;
cout<<"How many?"<<endl;
cin>>hm;
Takeon(hm);
}

void Takeon (int mh)
{
const int n=mh;
float x[n]={0};
int a=0;
cout<< "this array is "<<n<<" numbers big.\n"
	 <<"What are the numbers in this array?\n";
while (a<n)
	{
	cin>>x[a];
	a++;
	}
cout<<x[2];
}
