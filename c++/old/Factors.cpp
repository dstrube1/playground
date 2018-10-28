#include<iostream.h>
int main()
{                        // main
int count=0, x, y, fact1, fact2;
while (count<=100)
	{                       //count while
	count++;
	x=0;
	y=0;
	while (x<count)
		{                      //x while
		x++;
		while (y<count)
			{                     //y while
			y++;
			if (x*y==count)
				{                    //if open
				fact1=x;
				fact2=y;
				cout<< fact1 << " & " << fact2 << "are factors of " << count;
				}                    //close if
			 }                    //close y
		}                     //close x
	}                      //close count
return 0;
}
