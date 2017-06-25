package tests;

import java.security.InvalidParameterException;
import java.util.Arrays;
import java.util.Collection;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
//import org.junit.Rule;
//import org.junit.rules.ErrorCollector;
//import org.junit.BeforeClass;
//import org.junit.AfterClass;

import junit.framework.TestCase;
//import junitparams.*;
//import junitparams.JUnitParamsRunner;
//import junitparams.Parameters;
//disappointed: http://code.google.com/p/junitparams/
//this wasn't much more helpful with the Theories link:
//http://stackoverflow.com/questions/1206257/parameters-in-junit-4
//Looks like I'll just have to have one class per method- no, two classes, including ones for failed calls

import com.dstrube.FizzBuzz;

//@RunWith(Parameterized.class) 
//@RunWith(JUnitParamsRunner.class)
public class FizzBuzzUnitTests{
	
	@RunWith(Parameterized.class) 
	public static class FizzUnitTest extends TestCase{
		//it'd be nice if I didn't have to declare these for each subclass
		private int number;
		private boolean version2;
		private boolean expectedResult;
		 
		 public FizzUnitTest(int number, boolean version2, boolean expectedResult) {
		    this.number = number;
		    this.version2 = version2;
		    this.expectedResult  = expectedResult;
		 }

		 @Parameters
		 public static Collection<Object[]> data() {
		   Object[][] data = new Object[][] { 
				   { 1, false, false }, { 3, false, true }, { 5, false, false }, { 13, false, false }, { 31, false, false }, { 51, false, true}, //version 1 calls
				   { 1, true, false}, { 3, true, true }, { 5, true, false }, { 13, true, true }, { 31, true, true }, { 51, true, true} //version 2 calls
				   };
		   return Arrays.asList(data);
		 }
		 @Test
//		 @Parameters({"1, false, false"})
		public void testIsFizz(){//int number, boolean version2, boolean expectedResult
			boolean result = false;
			
			result = FizzBuzz.isFizz(number, version2);
			assertEquals("Function isFizz incorrectly tested "+number+".",result,expectedResult);
		}
	}

	@RunWith(Parameterized.class) 
	public static class BuzzUnitTest extends TestCase{
		
		private int number;
		private boolean version2;
		private boolean expectedResult;
		 
		 public BuzzUnitTest(int number, boolean version2, boolean expectedResult) {
		    this.number = number;
		    this.version2 = version2;
		    this.expectedResult  = expectedResult;
		 }

		 @Parameters
		 public static Collection<Object[]> data() {
		   Object[][] data = new Object[][] { 
				   { 1, false, false }, { 3, false, false }, { 5, false, true }, { 13, false, false }, { 31, false, false }, { 51, false, false}, //version 1 calls
				   { 1, true, false}, { 3, true, false }, { 5, true, true }, { 13, true, false }, { 31, true, false }, { 51, true, true} //version 2 calls
				   };
		   return Arrays.asList(data);
		 }
		 
		 @Test
		public void testIsBuzz(){
			boolean result = false;
			
			result = FizzBuzz.isBuzz(number, version2);
			assertEquals("Function isBuzz incorrectly tested "+number+".",result,expectedResult);
		}


	}

	@RunWith(Parameterized.class) 
	public static class FizzUnitTestFails extends TestCase{
		private int number;
		private boolean version2;
		
		public FizzUnitTestFails(int number, boolean version2) {
		    this.number = number;
		    this.version2 = version2;
		}
		
		@Parameters
		public static Collection<Object[]> data() {
			 Object[][] data = new Object[][] { 
					   { 0, false}, { -1, false}, { 0, true}, { -1, true} //version 1&2 calls with bad parameters <-------------LEFTOFF
					   };
			   return Arrays.asList(data);
		}
		
		@Test
		public void testIsFizzFails(){
		 try{
			 	FizzBuzz.isFizz(number, version2);
				fail("Function isFizz did not throw expected exception.");
			}
			catch(InvalidParameterException e){
				//expected
			}
		}
	}
	
	@RunWith(Parameterized.class) 
	public static class BuzzUnitTestFails extends TestCase{
		private int number;
		private boolean version2;
		
		public BuzzUnitTestFails(int number, boolean version2) {
		    this.number = number;
		    this.version2 = version2;
		}
		
		@Parameters
		public static Collection<Object[]> data() {
			 Object[][] data = new Object[][] { 
					   { 0, false}, { -1, false}, { 0, true}, { -1, true} //version 1&2 calls with bad parameters <-------------LEFTOFF
					   };
			   return Arrays.asList(data);
		}
		
		@Test
		public void testIsBuzzFails(){
			try{
				FizzBuzz.isBuzz(number, version2);
				fail("Function isBuzz did not throw expected exception.");
			}
			catch(InvalidParameterException e){
				//expected
			}
		}
		
	}
	///////////////////////////////////

//	@Rule
//   	public static ErrorCollector errCollect = new ErrorCollector();
//   	@BeforeClass
//	public static void setUp() throws Exception {
//   		System.out.println("test");
//   	}
//	@AfterClass
//	public static void tearDown() throws Exception {
//		System.out.println("After Test");
	//}
}


