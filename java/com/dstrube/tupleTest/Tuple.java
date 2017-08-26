package com.dstrube.tupleTest;

/*
commands to compile and run:
from ~/Projects/java
javac -d ~/Projects/java/bin com/dstrube/tupleTest/TupleTest.java
java -cp ~/Projects/java/bin com.dstrube.tupleTest.TupleTest
*/

/**
 * Tuple are immutable objects.  Tuples should contain only immutable objects or
 * objects that won't be modified while part of a tuple.
 */
public interface Tuple {

    public TupleType getType();
    public int size();
    public <T> T getNthValue(int i);

}