/*
g++ hello.cpp
./a.out
or (if using cin)
./a.out < in.txt 
or
./a.out < in.txt > out.txt

https://www.cs.drexel.edu/~mcs171/Sp07/extras/g++/index.html
*/

#include <iostream>
#include <pthread.h>
//#include <cstdlib>
#include <cmath>
#include <ctime>

using namespace std;

//method declarations
void sizes();
void initialValues();
void ranges();
void *PrintRangeDots(void *threadid);
void mathTest();
void pointerTest();
void passPtrs(int *ptr1, int *ptr2, int *ptrA[], int a[], int size);
int * returnArray();
void referenceTest();
void refAsParam(int & a);
int & returnRef();
int & returnRef0();
void timeTest();
void streamTest();

//variable declarations
	bool b;
	//signed bool sb; //invalid
	
	char c;
	signed char sc;
	unsigned char uc;
	
	short s;
	signed short ss;
	unsigned short us;
	
	int i;
	signed int si;
	unsigned int ui;
	
	long l;
	signed long sl;
	unsigned long ul;
	
	float f;
	//signed float sf;//invalid
	//unsigned float uf;//invalid
	
	double d;
	//signed double sd;//invalid
	//unsigned double ud;//invalid
	long double ld;
	
	//void v; //error: variable has incomplete type 'void'
	
	wchar_t w;
	signed wchar_t sw;
	unsigned wchar_t uw;
	
	long long ll;
	int long il;
	long int li;
	//long long long lll;//invalid
	signed long long sll;
	signed int long sil;
	signed long int sli;
	unsigned long long ull;
	unsigned int long uil;
	unsigned long int uli;
	
	//short long shl;//invalid
	//long short lsh;//invalid
	short int shi;
	int short ish;
	signed short int sshi;
	signed int short sish;
	unsigned short int ushi;
	unsigned int short uish;
	
	//modulus values for printing progress of data type ranges
	//const int CHAR_MOD = 10;
	//const int SHORT_MOD = 1000;
	//const int INT_MOD = 10000000;
	//preprocessor, no specific type
	#define CHAR_MOD 10
	#define SHORT_MOD 1000 //1,000
	#define INT_MOD 10000000 //10,000,000
	//TODO #define LONG_MOD 1000000000 //1,000,000,000
	
	#define NUM_THREADS 1
	volatile bool waiting;

int main(void) {
	//int a = 0;
	//int _1 = 1;
	//cin >> a;
	//cout << "Hello " << a << "!\n";

	//cout << "??="; //this outputs: warning: trigraph ignored [-Wtrigraphs]
	
	//more info: https://www.tutorialspoint.com/cplusplus/cpp_data_types.htm	
//	sizes();
//	initialValues();
	ranges();
	
	//mathTest();
	//pointerTest();
	//referenceTest();
	//timeTest();
	//streamTest();
	
/*
//print alarm
	for (a = 0; a < 2; a++){
		cout << '\a';
	}
*/	
	return 0;
}

void sizes(){
	/////////////////////////////////////////////////////////////////////////////////
	//tests of type Sizes
	/////////////////////////////////////////////////////////////////////////////////
	cout << "sizeof(bool): " << sizeof(b) << "\n\n"; 							//1
	
	cout << "sizeof(char): " << sizeof(c) << "\n"; 								//1
	cout << "sizeof(signed char): " << sizeof(sc) << "\n";						//1
	cout << "sizeof(unsigned char): " << sizeof(uc) << "\n\n";					//1
	
	cout << "sizeof(short): " << sizeof(s) << "\n";								//2
	cout << "sizeof(signed short): " << sizeof(ss) << "\n";						//2
	cout << "sizeof(unsigned short): " << sizeof(us) << "\n\n";					//2
	
	cout << "sizeof(int): " << sizeof(i) << "\n";								//4
	cout << "sizeof(signed int): " << sizeof(si) << "\n";						//4
	cout << "sizeof(unsigned int): " << sizeof(ui) << "\n\n";					//4
	
	cout << "sizeof(long): " << sizeof(l) << "\n";								//8
	cout << "sizeof(signed long): " << sizeof(sl) << "\n";						//8
	cout << "sizeof(unsigned long): " << sizeof(ul) << "\n\n";					//8
	
	cout << "sizeof(float): " << sizeof(f) << "\n\n";							//4
	
	cout << "sizeof(double): " << sizeof(d) << "\n";							//8
	cout << "sizeof(long double): " << sizeof(ld) << "\n\n";					//16

	cout << "sizeof(wchar_t): " << sizeof(w) << "\n";							//4
	cout << "sizeof(signed wchar_t): " << sizeof(sw) << "\n";					//4
	cout << "sizeof(unsigned wchar_t): " << sizeof(uw) << "\n\n";				//4

	cout << "sizeof(long long): " << sizeof(ll) << "\n";						//8
	cout << "sizeof(int long): " << sizeof(il) << "\n";							//8
	cout << "sizeof(long int): " << sizeof(li) << "\n";							//8
	cout << "sizeof(signed long long): " << sizeof(sll) << "\n";				//8
	cout << "sizeof(signed int long): " << sizeof(sil) << "\n";					//8
	cout << "sizeof(signed long int): " << sizeof(sli) << "\n";					//8
	cout << "sizeof(unsigned long long): " << sizeof(ull) << "\n";				//8
	cout << "sizeof(unsigned int long): " << sizeof(uil) << "\n";				//8
	cout << "sizeof(unsigned long int): " << sizeof(uli) << "\n\n";				//8
	
	cout << "sizeof(short int): " << sizeof(shi) << "\n";						//2
	cout << "sizeof(int short): " << sizeof(ish) << "\n";						//2
	cout << "sizeof(signed short int): " << sizeof(sshi) << "\n";				//2
	cout << "sizeof(signed int short): " << sizeof(sish) << "\n";				//2
	cout << "sizeof(unsigned short int): " << sizeof(ushi) << "\n";				//2
	cout << "sizeof(unsigned int short): " << sizeof(uish) << "\n\n";			//2
	cout << "/////////////////////////////////////////////////////////////////////////////////\n\n";
}

void initialValues(){
	/////////////////////////////////////////////////////////////////////////////////
	//Initial values
	/////////////////////////////////////////////////////////////////////////////////
	//0*: non-zero if declared outside main and called inside main; 
	//if declared outside and called from outside main, 0
	
	//be careful about declaring methods (before main) before calling them
	
	cout << "initial value of bool: " << b << "\n\n"; 							//0

	cout << "initial value of char: " << c << "\n"; 							//0*
	cout << "initial value of signed char: " << sc << "\n"; 					//0*
	cout << "initial value of unsigned char: " << uc << "\n\n"; 				//0*

	cout << "initial value of short: " << s << "\n";							//0
	cout << "initial value of signed short: " << ss << "\n";					//0
	cout << "initial value of unsigned short: " << us << "\n\n";				//0
	
	cout << "initial value of int: " << i << "\n";								//0
	cout << "initial value of signed int: " << si << "\n";						//0
	cout << "initial value of unsigned int: " << ui << "\n\n";					//0
	
	cout << "initial value of long: " << l << "\n";								//0
	cout << "initial value of signed long: " << sl << "\n";						//0
	cout << "initial value of unsigned long: " << ul << "\n\n";					//0*
	
	cout << "initial value of float: " << f << "\n\n";							//0*
	
	cout << "initial value of double: " << d << "\n\n";							//0*

	cout << "initial value of wchar_t: " << w << "\n";							//0*
	cout << "initial value of signed wchar_t: " << sw << "\n";					//0*
	cout << "initial value of unsigned wchar_t: " << uw << "\n\n";				//0*

	cout << "initial value of long long: " << ll << "\n";						//0*
	cout << "initial value of int long: " << il << "\n";						//0*
	cout << "initial value of long int: " << li << "\n";						//0*
	cout << "initial value of signed long long: " << sll << "\n";				//0*
	cout << "initial value of signed int long: " << sil << "\n";				//0*
	cout << "initial value of signed long int: " << sli << "\n";				//0*
	cout << "initial value of unsigned long long: " << ull << "\n";				//0*
	cout << "initial value of unsigned int long: " << uil << "\n";				//0*
	cout << "initial value of unsigned long int: " << uli << "\n\n";			//0*
	cout << "/////////////////////////////////////////////////////////////////////////////////\n\n";
}

//TODO
void ranges(){
	/////////////////////////////////////////////////////////////////////////////////
	//Ranges
	/////////////////////////////////////////////////////////////////////////////////
	
	//for char, '',"", and 0 all print as blank
	
	unsigned long long count;
	
	/////////////////////////////////////////////////////////////////////////////////
	//Chars
	/////////////////////////////////////////////////////////////////////////////////
	char c_p = c;
	signed char sc_p = sc;
	unsigned char uc_p = uc;

	count = 0;
	c++;
	while (c_p < c){
		c_p++;
		c++;
		count++;
		if (count % CHAR_MOD == 0) cout << ".";
	}
	cout << "\nEnd of char range. count = " << count << "\n"; //127
	
	count = 0;
	sc++;
	while (sc_p < sc){
		sc_p++;
		sc++;
		count++;
		if (count % CHAR_MOD == 0) cout << ".";
	}
	cout << "\nEnd of signed char range. count = " << count << "\n"; //127
	
	count = 0;
	uc++;
	while (uc_p < uc){
		uc_p++;
		uc++;
		count++;
		if (count % CHAR_MOD == 0) cout << ".";
	}
	cout << "\nEnd of unsigned char range. count = " << count << "\n"; //255
	
	/////////////////////////////////////////////////////////////////////////////////
	//Shorts, Ints, and Longs
	/////////////////////////////////////////////////////////////////////////////////
	short s_p = s;
	signed short ss_p = ss;
	unsigned short us_p = us;
	
	count = 0;
	s++;
	while (s_p < s){
		s_p++;
		s++;
		count++;
		if (count % SHORT_MOD == 0) cout << ".";
	}
	cout << "\nEnd of short range. count = " << count << "\n"; //32,767
	
	count = 0;
	ss++;
	while (ss_p < ss){
		ss_p++;
		ss++;
		count++;
		if (count % SHORT_MOD == 0) cout << ".";
	}
	cout << "\nEnd of signed short range. count = " << count << "\n"; //32,767
	
	count = 0;
	us++;
	while (us_p < us){
		us_p++;
		us++;
		count++;
		if (count % SHORT_MOD == 0) cout << ".";
	}
	cout << "\nEnd of unsigned short range. count = " << count << "\n"; //65,535
	
	/*
	waiting = true;
	pthread_t threads[NUM_THREADS];
	pthread_attr_t attr;
	void *status;

	// Initialize and set thread joinable
	pthread_attr_init(&attr);
	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

	int rc = pthread_create(&threads[0], &attr, PrintRangeDots, (void *)0);
		
	if (rc){
		cout << "Error:unable to create thread," << rc << endl;
        exit(-1);
    }
    
	// free attribute and wait for the other threads
	pthread_attr_destroy(&attr);
	
	rc = pthread_join(threads[i], &status);
		
	if (rc){
		cout << "Error:unable to join," << rc << endl;
        exit(-1);
	}
	
	cout << "Joined thread." << endl;
	*/
	count = 0;

	int i_p = i;
	signed int si_p = si;
	unsigned int ui_p = ui;

	i++;
	while (i_p < i){
		i_p++;
		i++;
		count++;
		//this should update the program in realtime, but instead
		//this halts the program until the while loop is done.
//		if (count % INT_MOD == 0) cout << "."; 
		//that's because cout is buffered; 
		//solution: cerr is not buffered:
		if (count % INT_MOD == 0) cerr << "."; 
	}
	cout << "\nEnd of int range. count = " << count << "\n"; //2,147,483,647
	

//	while(waiting){}
	
	//pthread_exit(NULL);	
	
	/*
	count = 0;
	si++;
	while (si_p < si){
		si_p++;
		si++;
		count++;
		if (count % INT_MOD == 0) cout << ".";
	}
	cout << "End of signed int range. count = " << count << "\n";
	
	count = 0;
	ui++;
	while (ui_p < ui){
		ui_p++;
		ui++;
		count++;
		if (count % INT_MOD == 0) cout << ".";
	}
	cout << "End of unsigned int range. count = " << count << "\n\n";
	*/
	/*
	long l_p = l;
	signed long sl_p = sl;
	unsigned long ul_p = ul;

	count = 0;
	l++;
	while (l_p < l){
		l_p++;
		l++;
		count++;
		if (count % 100 == 0) cout << ".";
	}
	cout << "End of long range. count = " << count << "\n";
	
	count = 0;
	sl++;
	while (sl_p < sl){
		sl_p++;
		sl++;
		count++;
		if (count % 100 == 0) cout << ".";
	}
	cout << "End of signed long range. count = " << count << "\n";
	
	count = 0;
	ul++;
	while (ul_p < ul){
		ul_p++;
		ul++;
		count++;
		if (count % 100 == 0) cout << ".";
	}
	cout << "End of unsigned long range. count = " << count << "\n\n";
	*/
}

void *PrintRangeDots(void *threadid) {
	long tid = (long)threadid;
	cout << "Beginning thread " << tid << endl;
	
	unsigned long long count = 0;

	int i_p = i;
	signed int si_p = si;
	unsigned int ui_p = ui;

	i++;
	while (i_p < i){
		i_p++;
		i++;
		count++;
		//this should update the program in realtime, but instead
		//this halts the program until the while loop is done.
//		if (count % INT_MOD == 0) cout << "."; 
		//that's because cout is buffered; 
		//solution: cerr is not buffered:
		if (count % INT_MOD == 0) cerr << "."; 
	}
	cout << "\nEnd of int range. count = " << count << "\n"; //2,147,483,647
	
	waiting = false;
	
	cout << "Exiting thread " << tid << endl;
	pthread_exit(NULL);
	cout << "Exited thread " << tid << endl; //this doesn't print; thread's dead, baby
}

void mathTest(){
	cout<< "pow(0,0): " << pow(0,0) << "\n"; //inf
	cout<< "1/0: " << (1/(pow(0,0)-1)) << "\n"; //inf; done this way to avoid "division by zero" warning
	cout<< "pow(0,-1): " << pow(0,-1) << "\n"; //inf
	cout<< "hypot(4,3): " << hypot(4,3) << "\n"; //5
	cout<< "hypot(4,1): " << hypot(4,1) << "\n"; //4.something
	cout<< "sqrt(-1): " << sqrt(-1) << "\n"; //nan
	
	cout<< "time( NULL ): " << time( NULL ) << "\n";
	cout<< "(unsigned)time( NULL ): " << (unsigned)time( NULL ) << "\n";
	srand( (unsigned)time( NULL ) );
	cout<< "rand(): " << rand() << "\n";
	
}

void pointerTest(){
	//with non-array:
	int * p;
	int j = 10;
	p = & j;
	cout<< "j = " << * p << endl;
	
	int * null = NULL;
	cout<< "null=" << null << endl; // 0x0
	//if we tried to print *null, get this error at runtime: Segmentation fault: 11
	//cout<< "*null=" << *null << endl; 
	//nothing special here, just the address of the null pointer variable, not the null value (which causes segmentation fault)
	//cout<< "&null=" << &null << endl; // 0x0
	
	//with array:
	const int SIZE = 3;
	int var[SIZE] = {2,4,6};
	//this says "I am a pointer, give me something to point to"
	//note, it's not good to declare and define a pointer on the same line like this, as explained below
	int * ptr = var;
	
	for (int i = 0; i < SIZE; i++){
		cout<< "var[" << i << "]=" << var[i] << endl;
		//this says "here's not what I am, but what I point to."
		cout<< "* ptr=" << * ptr << endl;
		ptr++;
	}
	cout<< "* ptr=" << * ptr << endl;
	ptr--;
	cout<< "* ptr=" << * ptr << endl;

	cout<< "* var: " << * var << endl;
	*var = 0;
	cout<< "* var: " << * var << endl;
	for (int i = 0; i < SIZE; i++){
		cout<< "var[" << i << "]=" << var[i] << endl; //prints 0 4 6
	}
	
	//this resets ptr back to the beginning of var; 
	//this is why it's a good idea to not assign pointer on the same line as declaring it- 
	//it confuses the assignment / declaration syntax
	ptr = var;
	cout<< "*ptr=" << * ptr << endl;

	//neat indexed assignment trick, assigns last item
	cout<< "neat indexed assignment trick:" << endl; 
	*(var + (SIZE - 1)) = 8;
	for (int i = 0; i < SIZE; i++){
		cout<< "var[" << i << "]=" << var[i] << endl; //prints 0 4 8
	}
	
	//array of pointers
	cout<< "array of pointers test:" << endl; 
	int * ptrA[SIZE];
	for (int i = 0; i < SIZE; i++){
		ptrA[i] = & var[i];//assign the address of the int
	}
	for (int i = 0; i < SIZE; i++){
		cout<< "var[" << i << "]=" << * ptrA[i] << endl; //prints 0 4 8
	}
	
	//which leads us to an array of char*, aka string
	/*
	cout<< "char* test:" << endl; 
	char *strings[SIZE] = {"string 1","string 2","string 3"};
	for (int i = 0; i < SIZE; i++){
		cout<< "strings[" << i << "]=" << strings[i] << endl; //prints 0 4 8
	}
	//BUT this is deprecated (and throws compiler warning), so leaving it out for now
	*/
	
	//huh! string no longer requires its own include
	string s = "s1";
	cout<< "string s=" << s << endl; //prints 0 4 8
	
	passPtrs(& j, p, ptrA, var, SIZE);
	//can't do this: int a[] = returnArray();
	//must do this:
	int * a = returnArray();
}

void passPtrs(int * ptr1, int * ptr2, int * ptrA[], int a[], int size){
}

int * returnPtr0(){//return int pointer
	int j = 0;
	int * p; 
	p = & j;
	return p;
}

int * returnArray(){//return array- looks a lot like returning a pointer
	//should be static because:
	//C++ does not advocate to return the address of a local variable to outside of the function
	static int a[3];
	a[0] = 1;
	a[1] = 2;
	a[2] = 3;
	return a;
}

int * returnPtrA(){//return array of pointers
	int * ptrA[0];
	return * ptrA; //must have * here; using static won't help
}

void referenceTest(){
	//reference must not be null, and must be defined upon declaration, 
	//and cannot be reassigned
	int i = 0;
	//int & r = r; //won't throw an error, but will throw a warning, 
	//and trying to print it will cause Segmentation fault
	int & r = i;
	r = r; //this is fine;
	//int & b = b;//this will throw a warning, 
	//but the subsequent (and presumably illegal but apparently legal) 
	//assignment on the next line 
	//to r makes it not crash at runtime; interesting
	//b = r;
	cout << "i = " << i << endl;
	cout << "r = " << r << endl;
	//cout << "b = " << b << endl;

	refAsParam(i);
	cout << "i after refAsParam = " << i << endl;
	
	r = returnRef();
	cout << "r after returnRef = " << r << endl;
}

void refAsParam(int & a){
	a = 1;
}

int & returnRef(){
	int j = 2; //compiler throws warning without static here
	static int & i = j; //or here
	return i;
}

int & returnRef0(){
	static int j = 2; //interesting- don't have to declare variable as reference 
	//in order to return it as a reference but you do have to declare as static
	return j;
}

void timeTest(){
	//four time-related types: 
		//clock_t, 
		//time_t, 
		//size_t, 
		//and tm
		
	time_t now = time(0);
	cout << "now : " << now << endl;
	
	string nows = ctime(&now);
	cout << "now string : " << nows << endl;
	
	tm *gmtm = gmtime(&now);
	nows = asctime(gmtm);
	cout << "now string GMT : " << nows << endl;
	
	const time_t * t0 = & now;
	tm * local_time = localtime(t0); //"Segmentation fault" if t0 isn't assigned 
	//or assigned to NULL
//	cout << "local_time : " << * local_time << endl; // LONG error
//	cout << "local_time : " << local_time << endl; // memory location?
//	cout << "local_time : " << & local_time << endl; // memory location?
	cout << "local_time hour : " << local_time->tm_hour << endl; // 
}

void streamTest(){
	char s[] = "this is a character array not needing a size.";
	cout << s << endl;
	
	char input[0];
	cout << "Enter some text: " ;
	cin >> input; //this will expand larger as needed
	cout << "You entered: " << input << "." << endl;
	
}









