//
//  classA.cpp
//  0_hello
//
//  Created by David Strube on 11/6/18.
//  Copyright © 2018 David Strube. All rights reserved.
//

#include "classA.hpp"
#include <iostream>

void classA::myMethod(){
    myInt = 1;
    std::cout<<"myInt is " << myInt << "\n"; //endl is not an option here (without std namespace?)
}

int classA::getConst() const{
    return 1;
}
