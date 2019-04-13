package com.dstrube;

/*
commands to compile and run:
from ~/Projects/java
javac -d bin com/dstrube/RotatedArraySearch.java
java -cp bin com.dstrube.RotatedArraySearch
*/

public class RotatedArraySearch{
	
	static int depthCount = -1;
	
	//Objective: find x in a possibly rotated sequential array of positive ints, 
		//(e.g., 3,4,5,6,7,1,2) not using brute force
		//numbers can be nonconsecutive and/or repeating, e.g., 3,3,3,3,3,10,3,3,3
	
	public static void main(String[] args){
		//Odd-sized array, non-rotated
					//  0 1 2 3 4
		int[] arrayA = {1,2,3,4,5}; //correct answer = 3
		int looking4 = 4;
		//findTest(arrayA);
		//System.out.println("index of " + looking4 + " : " + findX(arrayA, 0, arrayA.length-1, looking4));

		//Odd-sized array, rotated
					//   0 1 2 3 4
		int[] arrayAa = {3,4,5,1,2}; //correct answer = 1
		looking4 = 4;
		//findTest(arrayAa);
		//System.out.println("index of " + looking4 + " : " + findX(arrayAa, 0, arrayAa.length-1, looking4));

		//Even-sized array, rotated
					//  0 1 2 3 4 5 6 7
		int[] arrayB = {3,4,5,6,7,8,1,2}; //correct answer = 6
		looking4 = 1;
		//findTest(arrayB);
		//System.out.println("index of " + looking4 + " : " + findX(arrayB, 0, arrayB.length-1, looking4));
		
		//Even-sized array, non-rotated
					//   0 1 2 3 4 5 6 7
		int[] arrayBa = {1,2,3,4,5,6,7,8}; //correct answer = 1
		looking4 = 2;
		//findTest(arrayBa);
		//System.out.println("index of " + looking4 + " : " + findX(arrayBa, 0, arrayBa.length-1, looking4));
		
		//nonconsecutive and repeating with x on the right
					//  0 1 2 3 4 5  6 7 8
		int[] arrayC = {4,5,6,7,8,10,1,2,3}; //correct answer = 5
		looking4 = 10;
		//findTest(arrayC);
		//System.out.println("index of " + looking4 + " : " + findX(arrayC, 0, arrayC.length-1, looking4));		

		//nonconsecutive and repeating with x on the left
					//  0 1 2 3  4 5 6 7 8
		int[] arrayD = {6,7,8,10,1,2,3,4,5}; //correct answer = 3
		looking4 = 10;
		//findTest(arrayD);
		System.out.println("index of " + looking4 + " : " + findX(arrayD, 0, arrayD.length-1, looking4));	
		
		// rotation point on left, looking4 on left
		int[] arrayE = {9, 10, 1, 2, 3, 5, 7, 8};	//correct answer = 2
		looking4 = 1;
		//findTest(arrayE);
		System.out.println("index of " + looking4 + " : " + findX(arrayE, 0, arrayE.length-1, looking4));	

	}
	
	public static void findTest(int[] array){
		int mid = array.length / 2;
		System.out.println("mid = " + mid + "; array.length = " + array.length);

		System.out.println("left:");
		for (int i = 0; i < mid; i++){
			System.out.print(array[i]+",");
		}
		System.out.println();

		System.out.println("right:");
		for (int i = mid; i < array.length; i++){
			System.out.print(array[i]+",");
		}
		System.out.println();
	}
	
	public static int findX(int[] array, int begin, int end, int looking4){
		if (null == array || array.length == 0 || begin < 0 || begin >= array.length
			|| end < 0 || end >= array.length){
			System.out.println("Invalid input.");
			System.exit(0);
		}
		//returns index of x in a rotated sequential array of positive ints, e.g., 3,4,5,6,7,1,2
		//not using brute force
		//begin begins at 0; end begins at array.length - 1
		//numbers can be nonconsecutive and/or repeating, e.g., 3,3,3,3,3,10,3,3,3
		int mid = (end + begin + 1) / 2;
		
		//System.out.printf("begin = %d, end = %d, looking4 = %d, array = \n", begin, end, looking4);
		//for (int i = begin; i<= end; i++) System.out.print(array[i] + ",");
		//System.out.println();
		
		//System.out.printf("array[begin] = %d, array[end] = %d, mid = %d, array[mid] = %d\n", 
		//	array[begin], array[end], mid, array[mid]);
		
		
		depthCount++;
		//System.out.printf("depthCount = %d\n", depthCount);
		if (depthCount > 10){
			System.out.println("Depth count is too great.");
			System.exit(0);
		}

		if (looking4 == array[begin]) return begin;
		//else System.out.printf("beg, array["+begin+"], "+array[begin] + " != looking4, " + looking4+"\n");
		
		if (looking4 == array[end]) return end;
		//else System.out.printf("end, array["+end+"], "+array[end] + " != looking4, " + looking4+"\n");
		
		if (looking4 == array[mid]) return mid;
		//else System.out.printf("mid, array["+mid+"], "+array[mid] + " != looking4, " + looking4+"\n");
		
		int result = -1;
		
		if (begin == end) {
			System.out.println("Begin = end and it's not found yet.");
			return result;
			//System.exit(0);
		}
		
		if (looking4 < array[mid]) {
			if (looking4 > array[begin] || array[mid] < array[begin] ) {
				//look in left
				return findX(array, begin, mid, looking4);
			}
			else {
				//look in right
				return findX(array, array.length % 2 == 0 ? mid : mid + 1, end, looking4);
			}	
		} else { //looking4 > array[mid]
			if (looking4 < array[end] || array[mid] > array[end]){
				//look in right
				return findX(array, array.length % 2 == 0 ? mid : mid + 1, end, looking4);
			} else {
				//look in left
				return findX(array, begin, mid, looking4);
			}
		}
/*
		if (array[begin] < looking4 && looking4 < array[mid] ){
			//|| (looking4 > array[mid] && looking4 > array[end])) { 
			//^this is the beginning of the solution for arrayD, but as is, breaks arrayC
			result = findX(array, begin, mid, looking4);
if left is more than mid, there is rotation
if right is less than mid, there is rotation

use begin and mid to determine what is the min on the left
what is min on left
if at mid and looking4 is less than mid
if there is nothing on the left less than looking4, won't find 
 is greater than looking4 and there is rotation, 

first look for the rotation point
if rotation on the right, right end point value is infinity
else left end point value is negative infinity

		} else if (){
		}
		} else {
			result = findX(array, array.length % 2 == 0 ? mid : mid + 1, end, looking4);
		}
		
		if (result == -1){
			System.out.println("Error finding it!");
			return result;
			//System.exit(0);
		}
		return result;
*/
	}
	
}





