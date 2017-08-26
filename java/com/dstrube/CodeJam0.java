/*
From ~/java:

javac -d bin com/dstrube/CodeJam0.java
java -cp bin com.dstrube.CodeJam0

*/

package com.dstrube;

import java.util.*;
import java.io.*;

public class CodeJam0 {

  public static void main(String[] args) {
    Scanner in = new Scanner(new BufferedReader(new InputStreamReader(System.in)));

	System.out.println("Enter the number of cases you want to test: ");
    int t = in.nextInt();  // Scanner has functions to read ints, longs, strings, chars, etc.

    for (int i = 1; i <= t; ++i) {
    	System.out.println("Enter the number n (for case "+i+"): ");
    	int n = in.nextInt();
    	System.out.println("Enter the number m (for case "+i+"): ");
    	int m = in.nextInt();
    	System.out.println("Case #" + i + ": n+m=" + (n + m) + "; n*m=" + (n * m));
    }
  }
}