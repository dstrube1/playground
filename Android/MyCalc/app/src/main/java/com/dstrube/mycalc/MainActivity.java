package com.dstrube.mycalc;

import android.annotation.SuppressLint;
import android.app.Activity;
//import android.app.ActionBar;
import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
//import android.widget.Button;
//import android.os.Build;
import android.widget.EditText;
import android.widget.Toast;

//////////////////
/* 
* MyCalc
* one operation at a time
* operations can stack (ie: 1 + 2 = 3; +: 3 + ...)
* checks for invalid input: 00; +; =...
* 1/0 = Infinity
*/
//////////////////

@SuppressLint("NewApi") public class MainActivity extends Activity {

	private EditText window;
	private final String INVALID_OPERATION = "Invalid Operation";
	private float result;
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (savedInstanceState == null) {
            getFragmentManager().beginTransaction()
                    .add(R.id.container, new PlaceholderFragment())
                    .commit();
        }
    }

    @Override
    protected void onResume() {
    	super.onResume();
    	window = findViewById(R.id.editText1);
    }

    public void ClickClear(View V){
    	String t1 = "";
    	window.setText(t1);
    }
    
    public void ClickAdd(View V){
    	String t1 = window.getText().toString();
    	if (!isValidOperationString(t1)){
    		Toast.makeText(getApplicationContext(), INVALID_OPERATION, Toast.LENGTH_SHORT).show();
    		return;
    	}
    	
    	//getting it again in case it was reset by previous Equals
    	t1 = window.getText().toString();
    	t1 +=" + ";
    	window.setText(t1);
    }

    public void ClickSubtract(View V){
    	String t1 = window.getText().toString();
    	if (!isValidOperationString(t1)){
    		Toast.makeText(getApplicationContext(), INVALID_OPERATION, Toast.LENGTH_SHORT).show();
    		return;
    	}

    	//getting it again in case it was reset by previous Equals
    	t1 = window.getText().toString();
    	t1 +=" - ";
    	window.setText(t1);
    }
 
    public void ClickMultiply(View V){
    	String t1 = window.getText().toString();
    	if (!isValidOperationString(t1)){
    		Toast.makeText(getApplicationContext(), INVALID_OPERATION, Toast.LENGTH_SHORT).show();
    		return;
    	}

    	//getting it again in case it was reset by previous Equals
    	t1 = window.getText().toString();
    	t1 +=" * ";
    	window.setText(t1);
    }
    
    public void ClickDivide(View V){
    	String t1 = window.getText().toString();
    	if (!isValidOperationString(t1)){
    		Toast.makeText(getApplicationContext(), INVALID_OPERATION, Toast.LENGTH_SHORT).show();
    		return;
    	}

    	//getting it again in case it was reset by previous Equals
    	t1 = window.getText().toString();
    	t1 +=" / ";
    	window.setText(t1);
    }

    private boolean isValidOperationString(String s){
    	if (s.contains("=")){
//    		s = "";
    		//Toast.makeText(getApplicationContext(), "result = " +result , Toast.LENGTH_SHORT).show();
    		if (result % 1 == 0){
    			window.setText(Float.toString(result).substring(0,Float.toString(result).indexOf(".")));
        	}
        	else{
        		window.setText(Float.toString(result));
        	}
    		return true;
    	}
    	if (s.length()==0){
    		//Cannot operate with nothing to operate on.
    		return false;
    	}
    	if (s.contains("+") || s.contains("-") || s.contains("*") || s.contains("/") ){
    		//Only one operation at a time
    		return false;
    	}
    	try {
    		Integer.parseInt(s);
    	}
    	catch(NumberFormatException e){
    		//Trying to operate on a non-number
    		return false;
    	}
    	return true;
    }
    
    public void Click0(View v){
    	String t1 = window.getText().toString();
    	if (t1.contains("=")){
    		t1 = "";
    	}
    	if (t1.length()==0){
    		t1 = "0";
    	}
    	else if (t1.equals("0")){
    		//00 = invalid string
    		Toast.makeText(getApplicationContext(), INVALID_OPERATION, Toast.LENGTH_SHORT).show();
    		return;
    	}
    	else if (t1.endsWith(" + 0") || t1.endsWith(" - 0") || t1.endsWith(" / 0") || t1.endsWith(" * 0") ){
    		Toast.makeText(getApplicationContext(), INVALID_OPERATION, Toast.LENGTH_SHORT).show();
    		return;
    	}
    	else {
    		t1 += "0";
    	}
    	window.setText(t1);
    }

    public void Click1(View v){
    	ClickNonzeroNumber(1);
    }
    
    public void Click2(View v){
    	ClickNonzeroNumber(2);
    }
    
    public void Click3(View v){
    	ClickNonzeroNumber(3);
    }
    
    public void Click4(View v){
    	ClickNonzeroNumber(4);
    }
    
    public void Click5(View v){
    	ClickNonzeroNumber(5);
    }
    
    public void Click6(View v){
    	ClickNonzeroNumber(6);
    }
    
    public void Click7(View v){
    	ClickNonzeroNumber(7);
    }
    
    public void Click8(View v){
    	ClickNonzeroNumber(8);
    }
    
    public void Click9(View v){
    	ClickNonzeroNumber(9);
    }
    
    private void ClickNonzeroNumber(int i){
    	String t1 = window.getText().toString();
    	
    	if (t1.contains("=")){
    		t1 = "";
    	}
    	
    	if (t1.length()==0){
    		t1 = Integer.toString(i);
    	}
    	else if (t1.equals("0")){
    		//0n = invalid string
    		t1 = Integer.toString(i);
    	}
    	else if (t1.endsWith(" + 0") || t1.endsWith(" - 0") || t1.endsWith(" / 0") || t1.endsWith(" * 0") ){
    		t1 = t1.substring(0, t1.length()-1);
    		t1 += Integer.toString(i);
    	}
    	else {
    		t1 += Integer.toString(i);
    	}
    	
    	window.setText(t1);
    }

    public void ClickEquals(View v){
    	try{
	    	String t1 = window.getText().toString();
	    	if (t1.contains("=") || !t1.contains(" ") || t1.lastIndexOf(" ")==t1.length()-1){
	    		Toast.makeText(getApplicationContext(), INVALID_OPERATION, Toast.LENGTH_SHORT).show();
	    		return;
	    	}
	    	
	    	String operand1 = t1.substring(0,t1.indexOf(" "));
	    	String operand2 = t1.substring(t1.lastIndexOf(" ")+1);
	    	int i1 = Integer.parseInt(operand1);
	    	int i2 = Integer.parseInt(operand2);
	    	float f1 = (float) i1;
	    	float f2 = (float) i2;

	    	t1 += "\n = ";
	    	if (t1.contains("+")){
	    		result = f1 + f2;
	    	}
	    	else if (t1.contains("-")){
	    		result = f1 - f2;
	    	}
	    	else if (t1.contains("*")){
	    		result = f1 * f2;
	    	}
	    	else if (t1.contains("/")){
	    		result = f1 / f2;
	    	}
	    	if (result % 1 == 0){
	    		t1 += Float.toString(result).substring(0,Float.toString(result).indexOf("."));
	    	}
	    	else{
	    		t1 += Float.toString(result);
	    	}
	    	window.setText(t1);
    	}
    	catch (Exception e){
    		Toast.makeText(getApplicationContext(), e.toString(), Toast.LENGTH_LONG).show();
    	}
    }
    
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {

        public PlaceholderFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_main, container, false);
            return rootView;
        }
    }

}
