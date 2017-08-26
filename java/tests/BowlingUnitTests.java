//Bowling unit tests in java
//DS 2012-08-29

package tests;

import java.util.Arrays;
import java.util.Collection;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import junit.framework.TestCase;
import com.dstrube.Bowling;

public class BowlingUnitTests {

	@RunWith(Parameterized.class) 
	public static class ParseAndOnlyValidsUnitTest extends TestCase{
		
		private String input;
		private int parseOutput;
		private boolean onlyValidsOutput;
		
		 public ParseAndOnlyValidsUnitTest(String input, int parseOutput, boolean onlyValidsOutput) {
			    this.input = input;
			    this.parseOutput = parseOutput;
			    this.onlyValidsOutput = onlyValidsOutput;
			 }

		 @Parameters
		 public static Collection<Object[]> data() {
		   Object[][] data = new Object[][] { 
				   {null,0, false}, { "",0, false}, { "invalid sequence",0, false}, { "XXX partially valid sequence XXX",0, false}, 
				   { "X",10,true}, { "XX",30,true}, { "XXX",60,true}, { "XXXX",90,true}, { "XXXXXX",150,true}, { "XXXXXXXXXXXX",300,true}, 
				   { "9-9-9-9-9-9-9-9-9-9-",90,true}, { "5/5/5/5/5/5/5/5/5/5/5",150,true}, { "5/36X81X4/265/X26",136,true} 
				   };
		   return Arrays.asList(data);
		 }
		 
		 @Test
		public void test_parse(){
			int result = 0;

			result = Bowling.parse(input);
			assertEquals("Function parse incorrectly tested "+ input +".",result,parseOutput);
		 }
	
		 @Test
		 public void test_hasOnlyValidCharacters(){
			boolean result = false;
				
			result = Bowling.hasOnlyValidCharacters(input);
			assertEquals("Function hasOnlyValidCharacters incorrectly tested "+ input +".",result,onlyValidsOutput);
		}
	}
	
	@RunWith(Parameterized.class) 
	public static class CharacterValueAndIsCharPostiveNumberUnitTest extends TestCase{
		
		private char input;
		private int characterValueOutput;
		private boolean charPostiveNumberOutput;
		//have to do this because passing the Character.UNASSIGNED in (instead of a char variable with its value) throws a datatype error:
		private static char nullChar =Character.UNASSIGNED;  
		
		 public CharacterValueAndIsCharPostiveNumberUnitTest(char input, int characterValueOutput, boolean charPostiveNumberOutput) {
			    this.input = input;
			    this.characterValueOutput = characterValueOutput;
			    this.charPostiveNumberOutput = charPostiveNumberOutput;
			 }

		 @Parameters
		 public static Collection<Object[]> data() {
		   Object[][] data = new Object[][] { 
				   {nullChar,0, false}, { ' ',0, false}, { '0',0, false}, { '-',0, false}, { '1',1, true}, 
				   { '/',10,false}, { 'x',10,false}, { 'X',10,false}, { '\\',0,false} 
				   };
		   return Arrays.asList(data);
		 }
		 
		 @Test
		public void test_getCharacterValue(){
			int result = 0;

			result = Bowling.getCharacterValue(input);
			assertEquals("Function getCharacterValue incorrectly tested "+ input +".",result,characterValueOutput);
		 }
	
		 @Test
		 public void test_isCharPostiveNumber(){
			boolean result = false;
				
			result = Bowling.isCharPostiveNumber(input);
			assertEquals("Function hasOnlyValidCharacters incorrectly tested "+ input +".",result,charPostiveNumberOutput);
		}
	}
}

