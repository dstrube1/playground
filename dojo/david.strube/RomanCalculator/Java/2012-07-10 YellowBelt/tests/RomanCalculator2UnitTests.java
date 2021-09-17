//RomanCalculator2 Unit Tests in java
//DS 2012-07-10

package tests;

import java.util.ArrayList;
import com.dstrube.RomanCalculator2;
import junit.framework.TestCase;

public class RomanCalculator2UnitTests extends TestCase{
	public void test_getNumerals(){
		ArrayList<String> result = null;
		
		result = RomanCalculator2.getNumerals(null);
		assertEquals("Function getNumerals incorrectly tested null.",result,null);
		
		result = RomanCalculator2.getNumerals("");
		assertEquals("Function getNumerals incorrectly tested ''.",result,null);
		
		result = RomanCalculator2.getNumerals("I");
		assertEquals("Function getNumerals incorrectly tested I.",result,null);

		result = RomanCalculator2.getNumerals("I+");
		assertEquals("Function getNumerals incorrectly tested I+.",result,null);

		result = RomanCalculator2.getNumerals("+I");
		assertEquals("Function getNumerals incorrectly tested +I.",result,null);
		
		result = RomanCalculator2.getNumerals("o+I");
		assertEquals("Function getNumerals incorrectly tested o+I.",result,null);
		
		result = RomanCalculator2.getNumerals("I++I");
		assertEquals("Function getNumerals incorrectly tested I++I.",result,null);

		result = RomanCalculator2.getNumerals("I+I");
		assertEquals("Function getNumerals incorrectly tested I+I.",result.size(),2);

	}
	
	public void test_isRoman(){
		boolean result = false;
		
		result = RomanCalculator2.isRoman(null);
		assertEquals("Function isRoman incorrectly tested null.",result,false);

		result = RomanCalculator2.isRoman("");
		assertEquals("Function isRoman incorrectly tested ''.",result,false);
		
		result = RomanCalculator2.isRoman("Roman Polanski and The Holy Roman Empire");
		assertEquals("Function isRoman incorrectly tested Roman Polanski and The Holy Roman Empire.",result,false);

		result = RomanCalculator2.isRoman("iiiiiiiiiiii");
		assertEquals("Function isRoman incorrectly tested iiiiiiiiiiii.",result,true);

		result = RomanCalculator2.isRoman("iIiIiIiIiIiI");
		assertEquals("Function isRoman incorrectly tested iIiIiIiIiIiI.",result,true);
		
		result = RomanCalculator2.isRoman("MCMDCDCXCLXLXIXVIVI");
		assertEquals("Function isRoman incorrectly tested MCMDCDCXCLXLXIXVIVI.",result,true);
		
		result = RomanCalculator2.isRoman("MDCLXVI");
		assertEquals("Function isRoman incorrectly tested MDCLXVI.",result,true);
		
		result = RomanCalculator2.isRoman("DIM MCDIMDIM");
		assertEquals("Function isRoman incorrectly tested DIMMCDIMDIM.",result,false);
		
		result = RomanCalculator2.isRoman("LIVIDXXX");
		assertEquals("Function isRoman incorrectly tested LIVIDXXX.",result,true);
		
		result = RomanCalculator2.isRoman("LIVID-XXX");
		assertEquals("Function isRoman incorrectly tested LIVID-XXX.",result,false);
		
}
	
	public void test_getNumeralTotal(){
		ArrayList<String> numerals = null;
		int result = 0;
		
		result = RomanCalculator2.getNumeralTotal(numerals);
		assertEquals("Function getNumeralTotal incorrectly tested null.",result,0);
		
		numerals = new ArrayList<String>();
		result = RomanCalculator2.getNumeralTotal(numerals);
		assertEquals("Function getNumeralTotal incorrectly tested empty list.",result,0);
		
		numerals.add("");
		numerals.add("");
		numerals.add("");
		result = RomanCalculator2.getNumeralTotal(numerals);
		assertEquals("Function getNumeralTotal incorrectly tested list of empties.",result,0);
		
		numerals = new ArrayList<String>();
		numerals.add("invalid");
		numerals.add("invalid");
		numerals.add("so very invalid");
		result = RomanCalculator2.getNumeralTotal(numerals);
		assertEquals("Function getNumeralTotal incorrectly tested list of invalids.",result,0);
		
		numerals = new ArrayList<String>();
		numerals.add("X");
		numerals.add("invalid"); //ignored
		numerals.add("C");
		result = RomanCalculator2.getNumeralTotal(numerals);
		assertEquals("Function getNumeralTotal incorrectly tested list with an invalid.",result,110);

		numerals = new ArrayList<String>();
		numerals.add("X");
		numerals.add("C");
		result = RomanCalculator2.getNumeralTotal(numerals);
		assertEquals("Function getNumeralTotal incorrectly tested X + C.",result,110);

		numerals = new ArrayList<String>();
		numerals.add("V");
		numerals.add("V");
		result = RomanCalculator2.getNumeralTotal(numerals);
		assertEquals("Function getNumeralTotal incorrectly tested V + V.",result,10);
		
		numerals = new ArrayList<String>();
		numerals.add("LIVIDXXX"); //585
		numerals.add("MDCLXVI"); //1666
		numerals.add("MCMDCDCXCLXLXIXVIVI"); //3109
		result = RomanCalculator2.getNumeralTotal(numerals);
		assertEquals("Function getNumeralTotal incorrectly tested LIVIDXXX + MDCLXVI + MCMDCDCXCLXLXIXVIVI.",result,5360);
		
	}
	
	public void test_toArabic(){
		int result = 0;

		result = RomanCalculator2.toArabic(null);
		assertEquals("Function toArabic incorrectly tested null.",result,0);

		result = RomanCalculator2.toArabic("");
		assertEquals("Function toArabic incorrectly tested ''.",result,0);
		
		result = RomanCalculator2.toArabic("Roman Polanski and The Holy Roman Empire");
		assertEquals("Function toArabic incorrectly tested Roman Polanski and The Holy Roman Empire.",result,0);

		result = RomanCalculator2.toArabic("iiiiiiiiiiii");
		assertEquals("Function toArabic incorrectly tested iiiiiiiiiiii.",result,12);

		result = RomanCalculator2.toArabic("iIiIiIiIiIiI");
		assertEquals("Function toArabic incorrectly tested iIiIiIiIiIiI.",result,12);
		
		result = RomanCalculator2.toArabic("MCMDCDCXCLXLXIXVIVI");
		assertEquals("Function toArabic incorrectly tested MCMDCDCXCLXLXIXVIVI.",result,3109);
		
		result = RomanCalculator2.toArabic("MDCLXVI");
		assertEquals("Function toArabic incorrectly tested MDCLXVI.",result,1666);
		
		result = RomanCalculator2.toArabic("DIM MCDIMDIM");
		assertEquals("Function toArabic incorrectly tested DIMMCDIMDIM.",result,0);
		
		result = RomanCalculator2.toArabic("LIVIDXXX");
		assertEquals("Function toArabic incorrectly tested LIVIDXXX.",result,585);
		
		result = RomanCalculator2.toArabic("LIVID-XXX");
		assertEquals("Function toArabic incorrectly tested LIVID-XXX.",result,0);
	}

	public void test_toRoman(){
		String result = "";
		
		result = RomanCalculator2.toRoman(-1);
		assertEquals("Function toRoman incorrectly tested -1.",result,"");
		
		result = RomanCalculator2.toRoman(0);
		assertEquals("Function toRoman incorrectly tested 0.",result,"");
		
		result = RomanCalculator2.toRoman(1);
		assertEquals("Function toRoman incorrectly tested 1.",result,"I");

		result = RomanCalculator2.toRoman(2);
		assertEquals("Function toRoman incorrectly tested 2.",result,"II");

		result = RomanCalculator2.toRoman(4);
		assertEquals("Function toRoman incorrectly tested 4.",result,"IV");
		
		result = RomanCalculator2.toRoman(5);
		assertEquals("Function toRoman incorrectly tested 5.",result,"V");
		
		result = RomanCalculator2.toRoman(6);
		assertEquals("Function toRoman incorrectly tested 6.",result,"VI");
		
		result = RomanCalculator2.toRoman(10);
		assertEquals("Function toRoman incorrectly tested 10.",result,"X");
		
		result = RomanCalculator2.toRoman(40);
		assertEquals("Function toRoman incorrectly tested 40.",result,"XL");

		result = RomanCalculator2.toRoman(90);
		assertEquals("Function toRoman incorrectly tested 90.",result,"XC");

		result = RomanCalculator2.toRoman(400);
		assertEquals("Function toRoman incorrectly tested 400.",result,"CD");
		
		result = RomanCalculator2.toRoman(900);
		assertEquals("Function toRoman incorrectly tested 900.",result,"CM");
		
		result = RomanCalculator2.toRoman(999);
		assertEquals("Function toRoman incorrectly tested 999.",result,"CMXCIX");

		result = RomanCalculator2.toRoman(3109);
		assertEquals("Function toRoman incorrectly tested 3109.",result,"MMMCIX");
	}
	
}
