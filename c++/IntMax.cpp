/*

g++ IntMax.cpp
./a.out

*/

#include <iostream>

//using namespace std;

int main(void) {
	register int i = 1;
	register int i_p = 0;
	register long count = 0;
	
	while (i_p < i){
		i++;
		i_p++;
		count++;
		if (count % 10000000 == 0)
			printf(".");
			//cout<<".";
	}
	printf("\n");
	printf("Max of int found : %li\n", count);
	return 0;
}