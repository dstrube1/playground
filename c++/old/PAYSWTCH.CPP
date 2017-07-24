//David Russell
//Seha Loo
//CS 220-02
//2-4-98
//Assignment #4
//excercise # 2.56
//calculates the payrolls of various employees
#include <iostream.h>
#include <iomanip.h>
int main()
{
char emp;
int hours, remainder, GWS, items;
float weex, pay, rate;
  cout<<"I will now calculate the payrolls of various employees.\n"<<endl;
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
//the book says "manager's recieve a fixed
//weekly salary", but it fails to explain what that fixed
//weekly salary is. I have made up a
//fixed weekly salary, but we should bring this logical error to
//Mrs Loo's attetion.	End of digression.
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
//Again, we are not specifically told how the pay is to be found.
//So, I fall back on an old program
//until instructed otherwise:
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
//(See complaints above)
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

