#include<iostream.h>
int main()
{
char beep='y';
while (beep=='y'||beep=='Y')
{
	cout<<"Would you like to hear a beep?\n";
	cin>>beep;
	if (beep=='y'||beep=='Y')
		cout<<"Okay\a\a\a\a\a\a\a\a\a\a\a\a"<<endl;
	else
		cout<<"Okay\n";
}
return 0;
}