//David Russell
//Seha Loo
//CS 220-02
//3-5-98
//Assignment # 8
// utilizes appropriate PRE and POST comments in the prototype statement.
// Only the Prototype statements and the Function Definitions for these tasks.


#include <iostream.h>

void GETINPUTS ();
//PRE: user is asked for five intergers for an array
//POST: actually, user enters intergers for five separate yet identical arrays.
// (this is done because arrays are called by reference
// and some of these functions would change the values of the arrays that are
// best (most acurate) left original from the outset)

void SHOWARRAY (int[], int);
//PRE: takes on array c (from function GETINPUTS) in array f
//POST: each value inside array f is displayed


void DOUBLEARRAY (int[], int);
//PRE: takes on array ee (from function GETINPUTS) in array i
//POST: each value is first doulbed, then displayed

void FINDSMALLEST (int[], int);
//PRE: takes on array ff (from function GETINPUTS) in array m
//POST: outputs the smallest within the array

void FINDLARGEST (int[], int);
//PRE: takes on array gg (from function GETINPUTS) in array r
//POST: outputs the largest within the array

void SUMARRAY (int[], int);
//PRE: takes on array hh (from function GETINPUTS) in array w
//POST: ouputs the value of all the values in the array added together

void AVAGARRAY (int, int);
//PRE: takes on the values of the sum of the values (aa) and the size (y)
//	of the original array (from function SUMARRAY) in variables bb and cc
//POST: outputs the average of the values of the numbers in the original
//	array.



void GETINPUTS ()// IMPORTANT NOTE:
				//IF THIS PROGRAM WERE TO WORK, IT WOULD NEED A FUNCTION "MAIN",
					//BUT ONLY THE VOID FUNCTION "GETINPUTS"
					//SHOULD BE PUT INTO "MAIN";
					//THE REST ARE ALL ALREADY INVOKED ELSEWHERE.
{
const int a=5;	//array length
int b, c[a], d=-1, e, ee[a], ff[a], gg[a], hh[a];
cout << "There is an array 5 digits long.\n";
b = a;
cout<<"What are the numbers in this array in order?\n"
	 <<"(Press enter after each number)\n";
while (b>0)
	{
	d++;
	cin>>e;
	c[d]=e;
	ee[d]=e;
	ff[d]=e;
	gg[d]=e;
	hh[d]=e;
	b--;
	}
SHOWARRAY (c, a);
DOUBLEARRAY (ee, a);
FINDSMALLEST (ff, a);
FINDLARGEST (gg, a);
SUMARRAY (hh, a);
}

void SHOWARRAY (int f[], int g)
{
int h= -1;
cout<<"The array is as follows: "<<endl;
while (g>0)
	{
	h++;
	cout<<f[h]<<"  ";
	g--;
	}
cout<<endl;
}

void DOUBLEARRAY (int i[], int j)
{
int k=-1, l;
cout<<"The numbers of the array doubled are as follows:"<<endl;
while (j>0)
	{
	k++;
	l=i[k];
	l*=2;
	i[k]=l;
	cout<<i[k]<<"  ";
	j--;
	}
cout<<endl;
}

void FINDSMALLEST (int m[], int n)
{
int o=0, p, q;
p=m[o];
while (n>0)
	{
	o++;
	q=m[o];
	if (q<p)
		p=q;
	n--;
	}
cout<<p<<" is the smallest number in the array"<<endl;
}

void FINDLARGEST (int r[], int s)
{
int t=0, u, v;
u=r[t];
while (s>0)
	{
	t++;
	v=r[t];
	if (v>u)
		u=v;
	s--;
	}
cout<<u<<" is the largest number in the array"<<endl;
}

void SUMARRAY (int w[], int x)
{
int y, z=-1, aa=0;
y=x;
while (x>0)
	{
	z++;
	aa=aa+w[z];
	x--;
	}
cout<<"The sum of the numbers in the array is "<<aa<<".\n";
AVAGARRAY (aa, y);
}

void AVAGARRAY (int bb, int cc)
{
int dd;
dd=bb/cc;
cout<<"The average of numbers in this array is "<<dd
	 <<endl<<"The end.\n"
	 <<"Goodbye";
}
