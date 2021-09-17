package tests;

import java.util.ArrayList;
import junit.framework.TestCase;
import com.dstrube.DataMunging;
import com.dstrube.WeatherRow;
import com.dstrube.FootballRow;
import com.dstrube.GenericDataRow;

public class DataMungingUnitTests extends TestCase{
	
	public void test_populateWeatherRow(){
		ArrayList<WeatherRow> result = null;
		ArrayList<WeatherRow> blank =new ArrayList<WeatherRow>(); 
		String validWeatherRow = "   9  86    32*   59       6  61.5       0.00         240  7.6 220  12  6.0  78 46 1018.6";
		
		result = DataMunging.populateWeatherRow(null, null);
		assertEquals("Function populateWeatherRow incorrectly tested null all.",result,null);

		result = DataMunging.populateWeatherRow("", null);
		assertEquals("Function populateWeatherRow incorrectly tested blank input & null rows.",result,null);

		result = DataMunging.populateWeatherRow("invalid", null);
		assertEquals("Function populateWeatherRow incorrectly tested invalid input & null rows.",result,null);
		
		result = DataMunging.populateWeatherRow(validWeatherRow, null);
		assertEquals("Function populateWeatherRow incorrectly tested null rows.",result,null);
		
		result = DataMunging.populateWeatherRow(null, blank);
		assertEquals("Function populateWeatherRow incorrectly tested null input.",result,null);

		result = DataMunging.populateWeatherRow("", blank);
		assertEquals("Function populateWeatherRow incorrectly tested blank input.",result,blank);

		result = DataMunging.populateWeatherRow("invalid", blank);
		assertEquals("Function populateWeatherRow incorrectly tested invalid input.",result,null);
		
		result = DataMunging.populateWeatherRow(validWeatherRow, blank);
		assertEquals("Function populateWeatherRow incorrectly tested valid input.",result.size(),1);
	}
	public void test_trimOffNonNumerics(){
		String result = null;
		
		result = DataMunging.trimOffNonNumerics(null);
		assertEquals("Function trimOffNonNumerics incorrectly tested null.",result,null);

		result = DataMunging.trimOffNonNumerics("");
		assertEquals("Function trimOffNonNumerics incorrectly tested blank.",result,null);
		
		result = DataMunging.trimOffNonNumerics("123");
		assertEquals("Function trimOffNonNumerics incorrectly tested 123.",result,"123");

		result = DataMunging.trimOffNonNumerics(" 1*2a3");
		assertEquals("Function trimOffNonNumerics incorrectly tested 1*2a3.",result,"123");

	}
	public void test_populateFootballRow(){
		ArrayList<FootballRow> result = null;
		ArrayList<FootballRow> blank =new ArrayList<FootballRow>(); 
		//using this instead of something simpler because this actually shows in the middle of the data:
		String invalidFootballRow = "   -------------------------------------------------------"; 
		String validFootballRow = " 1. Arsenal         38    26   9   3    79  -  36    87";

		result = DataMunging.populateFootballRow(null, null);
		assertEquals("Function populateFootballRow incorrectly tested null all.",result,null);

		result = DataMunging.populateFootballRow("", null);
		assertEquals("Function populateFootballRow incorrectly tested blank input & null rows.",result,null);

		result = DataMunging.populateFootballRow(invalidFootballRow, null);
		assertEquals("Function populateFootballRow incorrectly tested invalid input & null rows.",result,null);
		
		result = DataMunging.populateFootballRow(validFootballRow, null);
		assertEquals("Function populateFootballRow incorrectly tested null rows.",result,null);

		result = DataMunging.populateFootballRow(null, blank);
		assertEquals("Function populateFootballRow incorrectly tested null input.",result,null);

		result = DataMunging.populateFootballRow("", blank);
		assertEquals("Function populateFootballRow incorrectly tested blank input.",result,null);

		result = DataMunging.populateFootballRow(invalidFootballRow, blank);
		assertEquals("Function populateFootballRow incorrectly tested  invalid input.",result,null);

		result = DataMunging.populateFootballRow(validFootballRow, blank);
		assertEquals("Function populateFootballRow incorrectly tested  valid input.",result.size(),1);
	}
	public void test_getAndThrowAwayNextWord(){
		String result = null;
		
		result = DataMunging.getAndThrowAwayNextWord(null);
		assertEquals("Function getAndThrowAwayNextWord incorrectly tested null.",result,null);

		result = DataMunging.getAndThrowAwayNextWord("");
		assertEquals("Function getAndThrowAwayNextWord incorrectly tested blank.",result,null);

		result = DataMunging.getAndThrowAwayNextWord("abc");
		assertEquals("Function getAndThrowAwayNextWord incorrectly tested abc.",result,"");

		result = DataMunging.getAndThrowAwayNextWord("ab c");
		assertEquals("Function getAndThrowAwayNextWord incorrectly tested ab c.",result,"c");

	}
	public void test_populateGenericDataRow(){
		ArrayList<GenericDataRow> result = null;
		ArrayList<GenericDataRow> blank = new ArrayList<GenericDataRow>();
		String validWeatherRow = "   9  86    32*   59       6  61.5       0.00         240  7.6 220  12  6.0  78 46 1018.6";
		String validFootballRow = " 1. Arsenal         38    26   9   3    79  -  36    87";
		//using this instead of something simpler because this actually shows in the middle of the data:
		String invalidFootballRow = "   -------------------------------------------------------"; 

		//all falses for 3rd param
		result = DataMunging.populateGenericDataRow(null, null, false);
		assertEquals("Function populateGenericDataRow incorrectly tested null null false",result,null);

		result = DataMunging.populateGenericDataRow("", null, false);
		assertEquals("Function populateGenericDataRow incorrectly tested blank null false",result,null);

		result = DataMunging.populateGenericDataRow(invalidFootballRow, null, false);
		assertEquals("Function populateGenericDataRow incorrectly tested invalid null false",result,null);

		result = DataMunging.populateGenericDataRow(validFootballRow, null, false);
		assertEquals("Function populateGenericDataRow incorrectly tested valid null false",result,null);

		result = DataMunging.populateGenericDataRow(null, blank, false);
		assertEquals("Function populateGenericDataRow incorrectly tested null blank false",result,null);

		result = DataMunging.populateGenericDataRow("", blank, false);
		assertEquals("Function populateGenericDataRow incorrectly tested blank blank false",result,blank);

		result = DataMunging.populateGenericDataRow(invalidFootballRow, blank, false);
		assertEquals("Function populateGenericDataRow incorrectly tested invalid blank false",result,blank);

		result = DataMunging.populateGenericDataRow(validFootballRow, blank, false);
		assertEquals("Function populateGenericDataRow incorrectly tested valid blank false",result.size(),1);

		//all trues for 3rd param
		result = DataMunging.populateGenericDataRow(null, null, true);
		assertEquals("Function populateGenericDataRow incorrectly tested null null true",result,null);

		result = DataMunging.populateGenericDataRow("", null, true);
		assertEquals("Function populateGenericDataRow incorrectly tested blank null true",result,null);

		result = DataMunging.populateGenericDataRow("invalid", null, true);
		assertEquals("Function populateGenericDataRow incorrectly tested invalid null true",result,null);

		result = DataMunging.populateGenericDataRow(validWeatherRow, null, true);
		assertEquals("Function populateGenericDataRow incorrectly tested valid null true",result,null);

		result = DataMunging.populateGenericDataRow(null, blank, true);
		assertEquals("Function populateGenericDataRow incorrectly tested null blank true",result,null);

		result = DataMunging.populateGenericDataRow("", blank, true);
		assertEquals("Function populateGenericDataRow incorrectly tested blank blank true",result,blank);

		result = DataMunging.populateGenericDataRow("invalid", blank, true);
		assertEquals("Function populateGenericDataRow incorrectly tested invalid blank true",result,blank);

		blank = new ArrayList<GenericDataRow>();
		result = DataMunging.populateGenericDataRow(validWeatherRow, blank, true);
		assertEquals("Function populateGenericDataRow incorrectly tested valid blank true",result.size(),1);
	}
	public void test_processWeatherData(){
		ArrayList<GenericDataRow> result = null;
		String[] columnsString = new String[0]; 
		ArrayList<GenericDataRow> blank = new ArrayList<GenericDataRow>();

		result = DataMunging.processWeatherData(null, null);
		assertEquals("Function processWeatherData incorrectly tested null null",result,null);

		result = DataMunging.processWeatherData(columnsString, null);
		assertEquals("Function processWeatherData incorrectly tested empty null",result,null);

		result = DataMunging.processWeatherData(null, blank);
		assertEquals("Function processWeatherData incorrectly tested null blank",result,null);

		columnsString = new String[1]; 
		result = DataMunging.processWeatherData(columnsString, blank);
		assertEquals("Function processWeatherData incorrectly tested non-empty blank",result.size(), 1);
	}
	public void test_processFootballData(){
		ArrayList<GenericDataRow> result = null;
		String[] columnsString = new String[0]; 
		ArrayList<GenericDataRow> blank = new ArrayList<GenericDataRow>();

		result = DataMunging.processWeatherData(null, null);
		assertEquals("Function processFootballData incorrectly tested null null",result,null);

		result = DataMunging.processWeatherData(columnsString, null);
		assertEquals("Function processFootballData incorrectly tested empty null",result,null);

		result = DataMunging.processWeatherData(null, blank);
		assertEquals("Function processFootballData incorrectly tested null blank",result,null);

		columnsString = new String[1]; 
		result = DataMunging.processWeatherData(columnsString, blank);
		assertEquals("Function processFootballData incorrectly tested non-empty blank",result.size(), 1);
	}
	
}
