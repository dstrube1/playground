#include <iostream>

using namespace std;

//currently testing:
void staticArray(void);

//old
//void stringStuff();
//void fizzBuzz(int a);

//todo:
//int b[] = makeArray();
//int[] makeArray();

int main (int argc, char *argv[])
{
	cout << "First time calling staticArray: " << endl;
	staticArray();

	cout << "Second time calling staticArray: " << endl;
	staticArray();

//	stringStuff();
	
//	cout << "Enter a number" << endl;
	int a;
//	cin >> a;
//	fizzBuzz(a);
//	b = new int[1];

	//this is how you execute a system command from the program:
//	system("ls");
	return 0;
}

void staticArray(void){
	const int size = 3;
	static int array1[size];

	cout << "static values before:" << endl;

	for (int i = 0; i < size; i++){
		cout << "array[" << i << "] = " <<  array1[i] << ";";
	}

	cout << endl;

	cout << "static values after:" << endl;

	for (int i = 0; i < size; i++){
		cout << "array[" << i << "] = " <<  (array1[i] += 5) << ";";
	}
	cout << endl;

}

void stringStuff(){
	//char array can be initialized with value, literal size, or constant size; 
	//variable size not allowed, even from a variable whose value doesn't change

	const int size = 7;
	//int size0 = 8;
	char string1[] = "string1", string2[6], string3[size];//, string4[size0];

	cout << "string1: " << string1 << endl;
	for (int i = 0; i <= size; i++){
		cout << "string1[" << i << "] = " << string1[i] << endl;
	}
	string s = "hey";
	cout << "string s = " << s << endl;	
}

void fizzBuzz(int a){
	for (int i = 0; i < a; i++){
		if (i % 15 == 0){
			cout << " fizz buzz"; 
		}
		else if (i % 3 == 0){
			cout << " fizz "; 
		}
		else if (i % 5 == 0){
			cout << " buzz "; 
		}
		else{
			cout << i;
		}
		cout << endl;

	}

}

//how to make a function that returns an array?
//int[] makeArray(){
//return null;
//}

