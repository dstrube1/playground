package demo.firstperformance.fpcandroid;

import android.os.Bundle;
import android.app.Activity;
import android.content.pm.ActivityInfo;

import android.view.View;
import android.widget.TextView;
import android.graphics.Color;

/**
 * Created by mtrussell on 6/30/15.
 * Copyright First Performance Corporation
 * <p>
 * This activity displays a text view and two buttons.
 * One of the buttons changes the window's background color.
 * Clicking the other button should begin a countdown from 100 to 1 and
 * display the count down in the text view.
 * Both buttons must be able to operate simultaneously.
 */
public class DemoActivity extends Activity implements DemoInterface {

    private TextView _countdownText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // DO NOT EDIT THIS METHOD
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_demo);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_NOSENSOR);
        _countdownText = findViewById(R.id.countdownText);
    }


    public void countdownButtonClicked(View view) {
        view.setEnabled(false);

        // 1) Begin the countdown when the countdown button is clicked
        new DemoAsyncTask(this).execute();
    }


    @Override
    public void setCountdownText(Integer count) {

        // 2) Update the text view with the countdown progress
        _countdownText.setText(String.valueOf(count));
    }


    // DO NOT EDIT BELOW THIS LINE
    private int _colorIndex = 0;

    public void colorButtonClicked(View view) {
        switch (_colorIndex) {
            case 0:
                getWindow().getDecorView().setBackgroundColor(Color.RED);
                break;
            case 1:
                getWindow().getDecorView().setBackgroundColor(Color.GREEN);
                break;
            case 2:
                getWindow().getDecorView().setBackgroundColor(Color.BLUE);
                break;
            default:
                getWindow().getDecorView().setBackgroundColor(Color.WHITE);
                break;
        }

        _colorIndex = (_colorIndex + 1) % 3;
    }

}