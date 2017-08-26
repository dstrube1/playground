package tests;

import junit.framework.TestCase;
import com.dstrube.FizzBuzz01;

public class FizzBuzz01UnitTests extends TestCase{
	public void testIsFizz(){
		boolean result = false;
		
		//tests with isStage2=false
		result = FizzBuzz01.isFizz(1, false);
		assertEquals("Function isFizz incorrectly tested 1.",result,false);
		
		result = FizzBuzz01.isFizz(3, false);
		assertEquals("Function isFizz incorrectly tested 3.",result,true);
		
		result = FizzBuzz01.isFizz(5, false);
		assertEquals("Function isFizz incorrectly tested 5.",result,false);
		
		result = FizzBuzz01.isFizz(13, false);
		assertEquals("Function isFizz incorrectly tested 13.",result,false);
		
		result = FizzBuzz01.isFizz(31, false);
		assertEquals("Function isFizz incorrectly tested 31.",result,false);

		//tests with isStage2=true
		result = FizzBuzz01.isFizz(1, true);
		assertEquals("Function isFizz incorrectly tested 1.",result,false);
		
		result = FizzBuzz01.isFizz(3, true);
		assertEquals("Function isFizz incorrectly tested 3.",result,true);
		
		result = FizzBuzz01.isFizz(5, true);
		assertEquals("Function isFizz incorrectly tested 5.",result,false);
		
		result = FizzBuzz01.isFizz(13, true);
		assertEquals("Function isFizz incorrectly tested 13.",result,true);
		
		result = FizzBuzz01.isFizz(31, true);
		assertEquals("Function isFizz incorrectly tested 31.",result,true);
		
	}

	public void testIsBuzz(){
		boolean result = false;
		
		//tests with isStage2=false
		result = FizzBuzz01.isBuzz(1, false);
		assertEquals("Function isBuzz incorrectly tested 1.",result,false);
		
		result = FizzBuzz01.isBuzz(3, false);
		assertEquals("Function isBuzz incorrectly tested 3.",result,false);
		
		result = FizzBuzz01.isBuzz(5, false);
		assertEquals("Function isBuzz incorrectly tested 5.",result,true);
		
		result = FizzBuzz01.isBuzz(51, false);
		assertEquals("Function isBuzz incorrectly tested 51.",result,false);
		
		//tests with isStage2=true
		result = FizzBuzz01.isBuzz(1, true);
		assertEquals("Function isBuzz incorrectly tested 1.",result,false);
		
		result = FizzBuzz01.isBuzz(3, true);
		assertEquals("Function isBuzz incorrectly tested 3.",result,false);
		
		result = FizzBuzz01.isBuzz(5, true);
		assertEquals("Function isBuzz incorrectly tested 5.",result,true);
		
		result = FizzBuzz01.isBuzz(51, true);
		assertEquals("Function isBuzz incorrectly tested 51.",result,true);
		
	}

}
