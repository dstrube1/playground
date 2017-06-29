//RomanCalculator Unit Tests in java
//DS 2012-08-29

package tests;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import junit.framework.TestCase;
import com.dstrube.RomanCalculator;

public class RomanCalculatorUnitTests {

	@RunWith(Parameterized.class) 
	public static class ToArabicAndIsRomanUnitTest extends TestCase{
		
		private String input;
		private int toArabicOutput;
		private boolean isRomanOutput;
		
		 public ToArabicAndIsRomanUnitTest(String input, int toArabicOutput, boolean isRomanOutput) {
			    this.input = input;
			    this.toArabicOutput = toArabicOutput;
			    this.isRomanOutput = isRomanOutput;
		 }

		 @Parameters
		 public static Collection<Object[]> data() {
		   Object[][] data = new Object[][] { 
				   {null,0, false}, { "",0, false}, { "Roman Polanski and The Holy Roman Empire",0, false}, { "DIM MCDIMDIM",0, false}, { "LIVID-XXX",0, false}, 
				   { "iiiiiiiiiiii",12, true},{ "iIiIiIiIiIiI",12,true}, { "MCMDCDCXCLXLXIXVIVI",3109,true}, { "MDCLXVI",1666,true}, { "LIVIDXXX",585,true}
				   };
		   return Arrays.asList(data);
		 }

		 @Test
		public void test_toArabic(){
			int result = 0;

			result = RomanCalculator.toArabic(input);
			assertEquals("Function toArabic incorrectly tested "+ input +".",result,toArabicOutput);
		 }

		@Test
		public void test_isRoman(){
			boolean result = false;
				
			result = RomanCalculator.isRoman(input);
			assertEquals("Function isRoman incorrectly tested "+ input +".",result,isRomanOutput);
		}
	}
		
	@RunWith(Parameterized.class) 
	public static class GetNumeralTotalUnitTest extends TestCase{
		
		private ArrayList<String> input;
		private String output;
		
		public GetNumeralTotalUnitTest(ArrayList<String> input, String output) {
			this.input = input;
		    this.output = output;
		}
		
		 @Parameters
		 public static Collection<Object[]> data() {
			 ArrayList<String> aL0 = null;
			 ArrayList<String> aL1 = new ArrayList<String>();
			 ArrayList<String> aL2 = new ArrayList<String>();
			 aL2.add("");
			 aL2.add("");
			 aL2.add("");
			 ArrayList<String> aL3 = new ArrayList<String>();
			 aL3.add("invalid");
			 aL3.add("invalid");
			 aL3.add("so very invalid");
			 ArrayList<String> aL4 = new ArrayList<String>();
			 aL4.add("X");
			 aL4.add("invalid");
			 aL4.add("C");
			 ArrayList<String> aL5 = new ArrayList<String>();
			 aL5.add("X");
			 aL5.add("C");
			 ArrayList<String> aL6 = new ArrayList<String>();
			 aL6.add("V");
			 aL6.add("V");
			 ArrayList<String> aL7 = new ArrayList<String>();
			 aL7.add("LIVIDXXX");
			 aL7.add("MDCLXVI");
			 Object[][] data = new Object[][] { 
				   {aL0,""}, {aL1,""}, {aL2,""}, {aL3,""}, {aL4,"CX"}, {aL5,"CX"}, {aL6,"X"}, {aL7,"MMCCXLVVI"}
				   };
		   return Arrays.asList(data);
		 }

		 @Test
		public void test_getNumeralTotal(){
			String result = "";
			
			result = RomanCalculator.getNumeralTotal(input);
			assertEquals("Function getNumeralTotal incorrectly tested "+ input +".",result,output);
			
//				numerals.add("LIVIDXXX"); //585
//				numerals.add("MDCLXVI"); //1666
//				numerals.add("MCMDCDCXCLXLXIXVIVI"); //3109
//				result = RomanCalculator.getNumeralTotal(numerals);
//				assertEquals("Function getNumeralTotal incorrectly tested LIVIDXXX + MDCLXVI + MCMDCDCXCLXLXIXVIVI.",result,"");//5360);
			
		}
	}

}
