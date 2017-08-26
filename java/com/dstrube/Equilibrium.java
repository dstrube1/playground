/*
From ~/java:

javac -d bin com/dstrube/Equilibrium.java
java -cp bin com.dstrube.Equilibrium

A zero-indexed array A consisting of N integers is given. 
An equilibrium index of this array is any integer P such that 0 ≤ P < N 
and the sum of elements of lower indices is equal to the sum of elements 
of higher indices, i.e.

    A[0] + A[1] + ... + A[P−1] = A[P+1] + ... + A[N−2] + A[N−1].

Sum of zero elements is assumed to be equal to 0. This can happen if P = 0 or if P = N−1.

For example, consider the following array A consisting of N = 8 elements:
  A[0] = -1
  A[1] =  3
  A[2] = -4
  A[3] =  5
  A[4] =  1
  A[5] = -6
  A[6] =  2
  A[7] =  1

P = 1 is an equilibrium index of this array, because:

        A[0] = −1 = A[2] + A[3] + A[4] + A[5] + A[6] + A[7]

P = 3 is an equilibrium index of this array, because:

        A[0] + A[1] + A[2] = −2 = A[4] + A[5] + A[6] + A[7]

P = 7 is also an equilibrium index, because:

        A[0] + A[1] + A[2] + A[3] + A[4] + A[5] + A[6] = 0

and there are no elements with indices greater than 7.

P = 8 is not an equilibrium index, because it does not fulfill the condition 0 ≤ P < N.

Write a function:

    class Solution { public int solution(int[] A); }

that, given a zero-indexed array A consisting of N integers, returns any of its 
equilibrium indices. The function should return −1 if no equilibrium index exists.

For example, given array A shown above, the function may return 1, 3 or 7, as explained above.

Assume that:

        N is an integer within the range [0..100,000];
        each element of array A is an integer within the range [−2,147,483,648..2,147,483,647].

Complexity:

        expected worst-case time complexity is O(N);
        expected worst-case space complexity is O(N), beyond input storage 
        (not counting the storage required for input arguments).

Elements of input arrays can be modified.
*/

package com.dstrube;

public class Equilibrium {

/*
Tested with 
[]
[1]
[1,0]
[1,0,1]
[1,0,2]

TODO: test with -2147483648 at A[0]
*/
    public int solution(int[] A) {
        if (A == null || A.length == 0) return -1;
        if (A.length == 1) return 0;
        
        long sum0 = A[0];
        long sum1 = 0L;
        int index = 1;
        for (int i = 2; i< A.length; i++){
            sum1 += A[i];
        }
        boolean found = false;
        if (sum0 == sum1) return index;
        else
            while (sum0 != sum1 && index < A.length){
                sum0 += A[index];
                index++;
                if (index >= A.length) break;
                sum1 -= A[index];
                if (sum0 == sum1) found = true;
            }
        return (found) ? index : -1;
    }
}