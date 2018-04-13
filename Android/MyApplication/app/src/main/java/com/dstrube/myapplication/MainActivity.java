package com.dstrube.myapplication;

import android.os.AsyncTask;
import android.util.Log;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

import android.app.PendingIntent;
import java.io.File;

import java.io.IOException;
//import java.nio.charset.Charset;
//import java.util.Arrays;
//import java.util.List;
//import java.util.Scanner;

//import com.google.android.gms.ads.AdRequest;
//import com.google.android.gms.ads.AdView;
//import com.splunk.mint.Mint;

import org.jsoup.Jsoup;
import org.jsoup.Connection.Response;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = MainActivity.class.getSimpleName();
    private static String text;
    private TextView tv;

    // Used to load the 'native-lib' library on application startup.
    static {
        System.loadLibrary("native-lib");
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        testBugSenseStart();
        text = "blah";

        // Example of a call to a native method
        tv = /*(TextView)*/ findViewById(R.id.sample_text);
        try {
            //TODO continue: sortTests();
//            comboTest();

            //this still throws an error about running a network call on the main thread
//            Jsouper jsouper = new Jsouper("jsouper");
//            jsouper.run();

            new MyAsyncTask().execute();
        } catch (Exception e) {
            tv.setText(e.toString());

        }
        tv.setText(stringFromJNI());
    }

//https://atlantabeltline.checkfront.com/reserve/?inline=1&provider=wordpress&pipe=https%3A%2F%2Fbeltline.org%2Fwp-content%2Fplugins%2Fcheckfront-wp-booking%2Fpipe.html&ssl=1&src=https%3A%2F%2Fbeltline.org&1510641802977#D20171117
    //https://atlantabeltline.checkfront.com/reserve/?1510641802977#D20171117
    private static final String URL = "https://atlantabeltline.checkfront.com/reserve/?#D20171117";
    /*"https://atlantabeltline.checkfront.com/reserve/?inline=1&provider=wordpress" +
            "&pipe=https%3A%2F%2Fbeltline.org%2Fwp-content%2Fplugins%2Fcheckfront-wp-booking%2Fpipe.html" +
            "&ssl=1&src=https%3A%2F%2Fbeltline.org&1510641802977#D20171117";
*/
    /*
    private class Jsouper implements Runnable {
        private final String name;

        Jsouper(String n) {
            name = n;
        }

        @Override
        public void run() {
            Log.i(TAG, "Running " + name);
            try {
                jsoupTest();
                Log.i(TAG, "Stopping " + name);
            } catch (Exception ex) {
                Log.i(TAG, "Caught exception with " + name);
                ex.printStackTrace();
            }
        }

    }
    */

    private class MyAsyncTask extends AsyncTask<Void, Void, Void>{
        @Override
        protected Void doInBackground(Void ... params){
            jsoupTest();
            return null;
        }
    }

    private static void jsoupTest(){
        try {

            Response res = Jsoup.connect(URL).timeout(6000).execute();
//
            Document doc = res.parse();
            Element ele = doc.select("div[class=cf-item-list]").first();
            if (ele == null){
                Log.e(TAG, "Null jsoup element");
                return;
            }
            Elements lines = ele.select("div");
            for (Element elt : lines) {
                System.out.println(elt.text());
                System.out.println("------------------------");
            }

        } catch (IOException c) {
            System.out.println("IOException");
            //JOptionPane.showMessageDialog(null, "IOException");
            c.printStackTrace();
        }
    }

    //region test

    void comboTest(){
        char [] arr = null;
		/*
		System.out.println("Testing null");
		printCombinations(arr, 0, 0);

		System.out.println("Testing {}");
		arr = new char[] {};
		printCombinations(arr, arr.length, arr.length);

		System.out.println("Testing {a}");
		arr = new char[] {'a'};
		printCombinations(arr, arr.length, arr.length);
*/
        Log.d(TAG, "Testing {a,b}");
        arr = new char[] {'a','b'};
        printCombinations(arr, arr.length, arr.length);

/*
		System.out.println("Testing {a,b,c}");
		arr = new char[] {'a','b','c'};
		printCombinations(arr, arr.length, arr.length);
		*/
    }

    void printCombinations(char arr[], int n, int r)
    {
        if (arr == null || arr.length == 0) {
            Log.d(TAG, "No combinations");
            return;
        }

        // A temporary array to store all combination one by one
        char data[]=new char[r];

        // Print all combination using temprary array 'data[]'
        combinationUtil(arr, data, 0, n-1, 0, r);
    }

    @Override
    protected void onStop() {
        super.onStop();
        testBugSenseEnd();
        File file = new File("");
        File[] files = file.listFiles();

    }

    /*
arr[]  ---> Input Array
data[] ---> Temporary array to store current combination
start & end ---> Staring and Ending indexes in arr[]
index  ---> Current index in data[]
r ---> Size of a combination to be printed
*/
    static int startingIndex = 0;
    static void combinationUtil(char arr[], char data[], int start,
                                int end, int index, int r)
    {
        Log.d(TAG, "X index = " + index + "; start = " + start + "; end = " + end
                + "; startingIndex = " + startingIndex + "; r = " + r);
        StringBuilder output = new StringBuilder();
        for (int j = 0; j < r; j++)
            output.append(data[j]+" ");
        Log.d(TAG,output.toString());

        // Current combination is ready to be printed, print it
        if (index == r)
        {
            output = new StringBuilder();
            for (int j = 0; j < r; j++)
                output.append(data[j]+" ");
            Log.d(TAG,output.toString());

            startingIndex++;
            Log.d(TAG,"Y index = " + index + "; start = " + start + "; end = " + end
                    + "; startingIndex = " + startingIndex + "; r = " + r);

            if (startingIndex == r){
                return;
            } else {
                index = 0;
                start = startingIndex;
            }
        }

        // replace index with all possible elements. The condition
        // "end-i+1 >= r-index" makes sure that including one element
        // at index will make a combination with remaining elements
        // at remaining positions
        Log.d(TAG,"Z index = " + index + "; start = " + start + "; end = " + end
                + "; startingIndex = " + startingIndex + "; r = " + r);
        for (int i = start; i <= end && end - i + 1 >= r - index; i++)
        {
            data[index] = arr[i];
            combinationUtil(arr, data, i + 1, end, index + 1, r);
        }
    }

    private void sortTests() {
        final int SIZE = 4;
        int[] array = null;
        MySortTest mySortTest = new MySortTest();

        //Bubble sort
        array = MySortTest.generateRandomArray(SIZE);
        text = "unsorted random array: " + OldStuff.stringifyIntArray(array);
        MySortTest.bubbleSort(array);
        text += "\nbubble sorted: " + OldStuff.stringifyIntArray(array);
        if (!MySortTest.isSorted(array)) {
            text += "\nWait, what? NOT SORTED!?!!!!!!!!!!!!!!!!!!!!!!";
        }

        //Selection sort
        array = MySortTest.generateRandomArray(SIZE);
        text += "\nnew unsorted random array: " + OldStuff.stringifyIntArray(array);
        MySortTest.selectionSort(array);
        text += "\nselection sorted: " + OldStuff.stringifyIntArray(array);
        if (!MySortTest.isSorted(array)) {
            text += "\nWait, what? NOT SORTED!?!!!!!!!!!!!!!!!!!!!!!!";
        }

        //Insertion sort
        array = MySortTest.generateRandomArray(SIZE);
        text += "\nnew unsorted random array: " + OldStuff.stringifyIntArray(array);
        MySortTest.insertionSort(array);
        text += "\ninsertion sorted: " + OldStuff.stringifyIntArray(array);
        if (!MySortTest.isSorted(array)) {
            text += "\nWait, what? NOT SORTED!?!!!!!!!!!!!!!!!!!!!!!!";
        }

        //Quick sort
        array = MySortTest.generateRandomArray(SIZE);
        text += "\nnew unsorted random array: " + OldStuff.stringifyIntArray(array);
        MySortTest.quickSort(array);
        text += "\nquick sorted: " + OldStuff.stringifyIntArray(array);
        if (!MySortTest.isSorted(array)) {
            text += "\nWait, what? NOT SORTED!?!!!!!!!!!!!!!!!!!!!!!!";
        }

        //Merge sort
        array = MySortTest.generateRandomArray(SIZE);
        text += "\nnew unsorted random array: " + OldStuff.stringifyIntArray(array);
        MySortTest.mergeSort(array);
        text += "\nmerge sorted: " + OldStuff.stringifyIntArray(array);
        if (!MySortTest.isSorted(array)) {
            text += "\nWait, what? NOT SORTED!?!!!!!!!!!!!!!!!!!!!!!!";
        }

        //Gnome sort
        array = MySortTest.generateRandomArray(SIZE);
        text += "\nnew unsorted random array: " + OldStuff.stringifyIntArray(array);
        MySortTest.gnomeSort(array);
        text += "\ngnome sorted: " + OldStuff.stringifyIntArray(array);
        if (!MySortTest.isSorted(array)) {
            text += "\nWait, what? NOT SORTED!?!!!!!!!!!!!!!!!!!!!!!!";
        }

        //Comb sort
        array = MySortTest.generateRandomArray(SIZE);
        text += "\nnew unsorted random array: " + OldStuff.stringifyIntArray(array);
        MySortTest.combSort(array);
        text += "\ncomb sorted: " + OldStuff.stringifyIntArray(array);
        if (!MySortTest.isSorted(array)) {
            text += "\nWait, what? NOT SORTED!?!!!!!!!!!!!!!!!!!!!!!!";
        }

        //Heap sort
        array = MySortTest.generateRandomArray(SIZE);
        text += "\nnew unsorted random array: " + OldStuff.stringifyIntArray(array);
        MySortTest.heapSort(array);
        text += "\nheap sorted: " + OldStuff.stringifyIntArray(array);
        if (!MySortTest.isSorted(array)) {
            text += "\nWait, what? NOT SORTED!?!!!!!!!!!!!!!!!!!!!!!!";
        }

    }

    private void testBugSenseStart() {
        //To get this to work:
        //1: in Finder, put the jar file in the project's /app/libs folder
        //2: in Android Studio, push the Sync Project with Gradle Files button
        //3 Alt+Enter when prompted to import com.splunk.mint.Mint
//        Mint.initAndStartSession(MainActivity.this, "eb6de0bc");
    }

    private void testBugSenseEnd() {
//        Mint.closeSession(MyActivity.this);
//        Mint.setFlushOnlyOverWiFi(true);
//        Mint.flush();
    }

    //    @Override
//    public boolean onCreateOptionsMenu(Menu menu) {
//        // Inflate the menu; this adds items to the action bar if it is present.
//        getMenuInflater().inflate(R.menu.menu_main, menu);
//        return true;
//    }
//
//    @Override
//    public boolean onOptionsItemSelected(MenuItem item) {
//        // Handle action bar item clicks here. The action bar will
//        // automatically handle clicks on the Home/Up button, so long
//        // as you specify a parent activity in AndroidManifest.xml.
//        int id = item.getItemId();
//
//        //noinspection SimplifiableIfStatement
//        if (id == R.id.action_settings) {
//            return true;
//        }
//
//        return super.onOptionsItemSelected(item);
//    }

    //endregion

    /**
     * A native method that is implemented by the 'native-lib' native library,
     * which is packaged with this application.
     */
    public native String stringFromJNI();
}
