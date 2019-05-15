package tests;

import java.security.InvalidParameterException;

//import junit.framework.Test;
import junit.framework.TestCase;
import com.dstrube.FizzBuzz;

public class FizzBuzzUnitTests extends TestCase{

	public void testIsFizz(){
		boolean result = false;
		
		//tests with isStage2=false
		result = FizzBuzz.isFizz(1, false);
		assertEquals("Function isFizz incorrectly tested 1.",result,false);
		
		result = FizzBuzz.isFizz(3, false);
		assertEquals("Function isFizz incorrectly tested 3.",result,true);
		
		result = FizzBuzz.isFizz(5, false);
		assertEquals("Function isFizz incorrectly tested 5.",result,false);
		
		result = FizzBuzz.isFizz(13, false);
		assertEquals("Function isFizz incorrectly tested 13.",result,false);
		
		result = FizzBuzz.isFizz(31, false);
		assertEquals("Function isFizz incorrectly tested 31.",result,false);
		
		try{
			result = FizzBuzz.isFizz(0, false);
			fail("Function isFizz did not throw expected exception.");
		}
		catch(InvalidParameterException e){
			//expected
		}
		
		try{
			result = FizzBuzz.isFizz(-1, false);
			fail("Function isFizz did not throw expected exception.");
		}
		catch(InvalidParameterException e){
			//expected
		}
		
		//tests with isStage2=true
		result = FizzBuzz.isFizz(1, true);
		assertEquals("Function isFizz incorrectly tested 1.",result,false);
		
		result = FizzBuzz.isFizz(3, true);
		assertEquals("Function isFizz incorrectly tested 3.",result,true);
		
		result = FizzBuzz.isFizz(5, true);
		assertEquals("Function isFizz incorrectly tested 5.",result,false);
		
		result = FizzBuzz.isFizz(13, true);
		assertEquals("Function isFizz incorrectly tested 13.",result,true);
		
		result = FizzBuzz.isFizz(31, true);
		assertEquals("Function isFizz incorrectly tested 31.",result,true);
		
		try{
			result = FizzBuzz.isFizz(0, true);
			fail("Function isFizz did not throw expected exception.");
		}
		catch(InvalidParameterException e){
			//expected
		}
		
		try{
			result = FizzBuzz.isFizz(-1, true);
			fail("Function isFizz did not throw expected exception.");
		}
		catch(InvalidParameterException e){
			//expected
		}
	}

	public void testIsBuzz(){
		boolean result = false;
		
		//tests with isStage2=false
		result = FizzBuzz.isBuzz(1, false);
		assertEquals("Function isBuzz incorrectly tested 1.",result,false);
		
		result = FizzBuzz.isBuzz(3, false);
		assertEquals("Function isBuzz incorrectly tested 3.",result,false);
		
		result = FizzBuzz.isBuzz(5, false);
		assertEquals("Function isBuzz incorrectly tested 5.",result,true);
		
		result = FizzBuzz.isBuzz(51, false);
		assertEquals("Function isBuzz incorrectly tested 51.",result,false);
		
		try{
			result = FizzBuzz.isBuzz(0, false);
			fail("Function isBuzz did not throw expected exception.");
		}
		catch(InvalidParameterException e){
			//expected
		}
		
		try{
			result = FizzBuzz.isBuzz(-1, false);
			fail("Function isBuzz did not throw expected exception.");
		}
		catch(InvalidParameterException e){
			//expected
		}
		
		//tests with isStage2=true
		result = FizzBuzz.isBuzz(1, true);
		assertEquals("Function isBuzz incorrectly tested 1.",result,false);
		
		result = FizzBuzz.isBuzz(3, true);
		assertEquals("Function isBuzz incorrectly tested 3.",result,false);
		
		result = FizzBuzz.isBuzz(5, true);
		assertEquals("Function isBuzz incorrectly tested 5.",result,true);
		
		result = FizzBuzz.isBuzz(51, true);
		assertEquals("Function isBuzz incorrectly tested 51.",result,true);
		
		try{
			result = FizzBuzz.isBuzz(0, true);
			fail("Function isBuzz did not throw expected exception.");
		}
		catch(InvalidParameterException e){
			//expected
		}
		
		try{
			result = FizzBuzz.isBuzz(-1, true);
			fail("Function isBuzz did not throw expected exception.");
		}
		catch(InvalidParameterException e){
			//expected
		}
	}
}
