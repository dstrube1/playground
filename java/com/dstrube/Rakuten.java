/*
From ~/java:

javac -d bin com/dstrube/Rakuten.java
java -cp bin com.dstrube.Rakuten



*/

package com.dstrube;

import java.util.*;
import java.math.BigInteger;
import java.io.*;

public class Rakuten {
	public static void main(String[] args) {
		int K = -4; 
		int L = 1; 
		int M = 2; 
		int N = 6; 
		int P = 0; 
		int Q = -1; 
		int R = 4; 
		int S = 3;
		System.out.println("solution: " +
			solution(K,L,M,N,P,Q,R,S));
	}
	
	//K = -4, L = 1,  M = 2, N = 6
	//P = 0,  Q = -1, R = 4, S = 3
	
    public static int solution(int K, int L, int M, int N, int P, int Q, int R, int S) {
        // write your code in Java SE 8
        long max = Integer.MAX_VALUE;
        
        long h1 = Math.abs(N - L); //height of rectangle 1
        long w1 = Math.abs(M - K); //width of rectangle 1
        long h2 = Math.abs(Q - S); //height of rectangle 2
        long w2 = Math.abs(R - P); //width of rectangle 2
        
        long area1 = h1 * w1;
        long area2 = h2 * w2;
        
        long sum = area1 + area2;
        
        if ((P > K && P < M && S < N && S > L) || 
            (R > K && R < M && S < N && S > L) ||
            (P > K && P < M && Q < N && Q > L)  ||
            (R > K && R < M && Q < N && Q > L) )
        { //there is intersection
        
        //(K,N) (M,N)
        //(K,L) (M,L)
        
        //(P,S) (R,S)
        //(P,Q) (R,Q)
        
            long hI = Math.abs(S - L); //height of intersection
            long wI = Math.abs(M - P); //width of intersection
            long areaI = hI * wI;
            sum -= areaI;
        } 
        
        if (sum > max) return -1;
        return (int) sum;
    }
	
}