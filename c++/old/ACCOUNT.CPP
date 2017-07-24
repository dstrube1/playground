//David Russell &Rachel Brockington
//Seha Loo
//CS 220-02
//3-5-98
//Assignment #8
//excercise #4.10
//

#include <iostream.h>

void salary ();

int main()
{
	salary(count);
return 0;
}

void salary ()
{
char choice;
float weex, pay, rate;
cout<<"Would you like for me to calculate the salary of an employee?\n"
	 <<"Press Y for yes; N for no.\n";
cin>>choice;
do{
	cout<<"Press M for managers."<<endl
		 <<"Press H for hourly workers."<<endl
		 <<"Press C for commission workers."<<endl
		 <<"Press P for pieceworkers."<<endl
		 <<"Press E to end."<<endl;
	cin>>emp;
		switch (emp)
		{
			case'M':
				cout<< "How many week's pay is this manager due?\n";
				cin>> weex;
				if (weex>0)
				{
					pay=weex*10000;
					cout.setf(ios::fixed);
					cout.setf(ios::showpoint);
					cout.precision(2);
					cout<<"This employee recieves $"<<pay<<".\n"<<endl;
				}
				else
					cout<<"This employee needs to work more."<<endl<<endl;
				break;
			case 'H':
			cout<<"Enter hours worked : ";
			cin>> hours;
			if (hours>0)
			{
				cout<< endl << "Enter hourly rate of worker ($00.00): ";
				cin>> rate ;
				if (hours<=40)
					pay=hours*rate;
				else
					{
					remainder=hours-40;
					pay=(rate*40)+(remainder*rate*1.5);
					}
				cout.setf(ios::fixed);
				cout.setf(ios::showpoint);
				cout.precision(2);
				cout<< "This employee recieves $" << pay <<".\n"<<endl;
			}
			else
				cout<<"Well they get nothing then, don't they?"<<endl<<endl;
			break;
		case'C':
			cout <<"What is this employee's gross weekly sales?.\n";
			cin>>GWS;
			if (GWS>0)
			{
				pay= 250+(.057*GWS);
				cout.setf(ios::fixed);
				cout.setf(ios::showpoint);
				cout.precision(2);
				cout<<"This employee recieves $"<<pay<<".\n"<<endl;
			}
			else
				cout<<"This slacker gets nothing."<<endl<<endl;
			break;
		case'P':
			cout<<"How many items has this employee produced \n"
			<<"since their last paycheck?\n";
			cin>>items;
			if (items>0)
			{
				pay=items*100;
				cout.setf(ios::fixed);
				cout.setf(ios::showpoint);
				cout.precision(2);
				cout<<"This employee recieves $"<<pay<<".\n"<<endl;
			}
			else
			cout<<"Well then why is this person on our payroll?\n"
				<<"Aw, whatever- I just work here."<<endl<<endl;
			break;
		case'E':
			cout<<"Goodbye.\n";
			break;
		default:
			cout<<"Please try again.\n"<<endl;
			break;
			}
		}while (emp!='E');
cout<<"End of program";
return 0;
}
