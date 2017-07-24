//
//  main.cpp
//  test
//
//  Created by David Strube on 3/2/17.
//  Copyright © 2017 David Strube. All rights reserved.
//

#include <iostream>

int main(int argc, const char * argv[]) {
    std::cout << "Hello, World!\n";
     
    int i = 1;
    int i_p = 0;
    long count = 0;
    
    while (i_p < i){
        i++;
        i_p++;
        count++;
        //if (count % 10000000 == 0)
          //  printf(".");
        //cout<<".";
    }
    printf("\n");
    printf("Max of int found : %li\n", count); //2,147,483,647

    return 0;
}
