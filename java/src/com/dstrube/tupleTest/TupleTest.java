package com.dstrube.tupleTest;


import com.dstrube.tupleTest.Tuple;
import com.dstrube.tupleTest.TupleType;

//from http://stackoverflow.com/questions/3642452/java-n-tuple-implementation

/*
commands to compile and run:
from ~/Projects/java
javac -d ~/Projects/java/bin com/dstrube/tupleTest/TupleTest.java
java -cp ~/Projects/java/bin com.dstrube.tupleTest.TupleTest
*/

public class TupleTest{
	
	public static void main(String[] args) {

        // This code probably should be part of a suite of unit tests
        // instead of part of this a sample program

        final TupleType tripletTupleType =
            TupleType.DefaultFactory.create(
                    Number.class,
                    String.class,
                    Character.class);

        final Tuple t1 = tripletTupleType.createTuple(1, "one", 'a');
        final Tuple t2 = tripletTupleType.createTuple(2l, "two", 'b');
        final Tuple t3 = tripletTupleType.createTuple(3f, "three", 'c');
        final Tuple tnull = tripletTupleType.createTuple(null, "(null)", null);
        System.out.println("t1 = " + t1);
        System.out.println("t2 = " + t2);
        System.out.println("t3 = " + t3);
        System.out.println("tnull = " + tnull);

        final TupleType emptyTupleType =
            TupleType.DefaultFactory.create();

        final Tuple tempty = emptyTupleType.createTuple();
        System.out.println("\ntempty = " + tempty);

        // Should cause an error
        System.out.println("\nCreating tuple with wrong types: ");
        try {
            final Tuple terror = tripletTupleType.createTuple(1, 2, 3);
            System.out.println("Creating this tuple should have failed: "+terror);
        } catch (IllegalArgumentException ex) {
            ex.printStackTrace(System.out);
        }

        // Should cause an error
        System.out.println("\nCreating tuple with wrong # of arguments: ");
        try {
            final Tuple terror = emptyTupleType.createTuple(1);
            System.out.println("Creating this tuple should have failed: "+terror);
        } catch (IllegalArgumentException ex) {
            ex.printStackTrace(System.out);
        }

        // Should cause an error
        System.out.println("\nGetting value as wrong type: ");
        try {
            final Tuple t9 = tripletTupleType.createTuple(9, "nine", 'i');
            final String verror = t9.getNthValue(0);
            System.out.println("Getting this value should have failed: "+verror);
        } catch (ClassCastException ex) {
            ex.printStackTrace(System.out);
        }
        
        System.out.println();
        final TupleType Pair =
            TupleType.DefaultFactory.create(
                    Integer.class,
                    Integer.class);
        final Tuple t1_0 = Pair.createTuple(1, 2);
        final Tuple t2_0 = Pair.createTuple(2, 3);
        System.out.println("t1_0 = " + t1_0);
        System.out.println("t2_0 = " + t2_0);
    }
	
}