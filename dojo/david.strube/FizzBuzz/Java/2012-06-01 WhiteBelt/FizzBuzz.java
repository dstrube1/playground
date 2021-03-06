//FizzBuzz in java
//DS 2012-06-01

public class FizzBuzz {
	public static void main(String[] args) {
		//TODO: make isStage2 a command line option
		
		boolean isStage2 = false;
		
		for (int i=1; i <= 100; i++){
		
			boolean isFizz =isFizz(i, isStage2);
			boolean isBuzz =isBuzz(i, isStage2);
			
			if (isFizz && isBuzz)
				System.out.println("FizzBuzz");
			else if (isFizz)
				System.out.println("Fizz");
			else if (isBuzz)
				System.out.println("Buzz");
			else //(!isFizz && !isBuzz)
				System.out.println(i);
		}
	}
	
	private static boolean isFizz(int i, boolean isStage2){
		//TODO: handle invalid input for i	
		String s = String.valueOf(i);
		
		if (i % 3 == 0  || (isStage2 && s.contains("3")))
			return true;
		return false;
	}
	
	private static boolean isBuzz(int i, boolean isStage2){
		//TODO: handle invalid input for i
		String s = String.valueOf(i);
		
		if (i % 5 == 0 || (isStage2 && s.contains("5")))
			return true;
		return false;
	}
}