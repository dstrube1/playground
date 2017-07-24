//DANGER WILL ROBINSON!!! DANGER

//David Russell (leader) & Rachel Brockington
//Seha Loo
//CS 220-02
//2-19-98
//Assignment #6
//calculates perfect numbers between 1 & 100


#include<iostream.h>
int Check (long);

int main()
{
int num1=1;
cout<<"These are the perfect numbers between 1 & 10,000,000:"<<endl;
Check(num1);
return 0;
}

int Check (long num2)
{
int fact, sum;
	while (num2<=10000000)
	{
	sum=0;
	for (fact=1; fact<num2;fact++)
		{
		if(num2%fact==0)
			sum=fact+sum;
		}

	if (sum==num2)
		{
		for (fact=1; fact<num2; fact++)
			{
			if (num2%fact==0)
				sum=fact+ sum;
			}
			cout<<num2<<" is a perfect number."<<endl;
		}
		num2++;
	}
return 0;
}
