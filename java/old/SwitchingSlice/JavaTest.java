
public class JavaTest {

	public JavaTest() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		int[] A = new int[8]; 
		A[0]= 5;
		A[1]= 4;
		A[2]= -3;
		A[3]= 4;
		A[4]= -3;
		A[5]= 5;
		A[6]= -3;
		A[7]= 5;
		int solved = solution(A);
		System.out.print(solved);
	}
	 public static int solution(int[] A) {
	        // write your code in Java SE 8
	        int p=0;
//	        int q = 0;
//	        boolean isSwitching = false;
	        int sizeOfSwitch = 0;
	        int largestSwitch = 0;
	        for (int i=0; i<A.length; i++){
	            if (i < A.length-2 && A[p] == A[p+2]){
//	                isSwitching = true;
	                p += 2;
	                sizeOfSwitch += 2;
	                for (int j=p; j<A.length; j++){
	                    if (j < A.length-2 && A[p] == A[p+2]){
	                        sizeOfSwitch += 2;
	                    }
	                    else{
	                        break;
	                    }
	                }
	                if (sizeOfSwitch > largestSwitch){
	                    largestSwitch = sizeOfSwitch;
	                }
	            }
	            else{
	                 p++;   
	            }
	            
	        }
	        return largestSwitch;
	    }

}
