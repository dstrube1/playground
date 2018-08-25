package com.dstrube.customdialog;

import android.app.AlertDialog;
import android.app.Dialog;
import android.media.AudioManager;
import android.media.ToneGenerator;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.widget.EditText;
import android.widget.Toast;

//////////////////
/*
 * Custom dialog
 * click the Custom Dialog button- pops up the username and password fields; password may or may not be *s
 * OK and Cancel I made, not default
 * OK = Toast with username and password - clear text both
 * Cancel makes the pop up disappear
 */
//////////////////
public class MainActivity extends AppCompatActivity {

    //private ImageButton okButton, cancelButton;
    private EditText usernameText, passwordText;
    private Dialog dialog;
    private ToneGenerator tg;
    //doesn't work:
//	private MediaPlayer mediaPlayer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    protected void onResume() {
        super.onResume();
        //okButton = (ImageButton) dialog.findViewById(R.id.okButton);
        //cancelButton = dialog.findViewById(R.id.cancelButton);
        dialog = new Dialog(MainActivity.this, android.R.style.Theme_Translucent);
        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.setCancelable(true);
        dialog.setContentView(R.layout.mydialog);
        //doesn't work:
        //mediaPlayer = MediaPlayer.create(this, 0);
        tg = new ToneGenerator(AudioManager.STREAM_NOTIFICATION, ToneGenerator.MAX_VOLUME);
    }

    public void imageClick(View v) {
        tg.startTone(ToneGenerator.TONE_PROP_BEEP);

        //doesn't work:
//    	if (!v.isSoundEffectsEnabled()){
//    		v.setSoundEffectsEnabled(true);
//    	}
//    	v.playSoundEffect(0);
        AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
        LayoutInflater inflater = MainActivity.this.getLayoutInflater();
        builder.setView(inflater.inflate(R.layout.mydialog, null));

        dialog = builder.create();
        dialog.show();
    }

    public void okClick(View v) {
//    	mediaPlayer.start();
//    	if (!v.isSoundEffectsEnabled()){
//    		v.setSoundEffectsEnabled(true);
//    	}
//    	v.playSoundEffect(1);
//    	tg.startTone(ToneGenerator.TONE_SUP_CONFIRM);
//    	tg.startTone(ToneGenerator.TONE_CDMA_CONFIRM);
        tg.startTone(ToneGenerator.TONE_PROP_ACK);//best so far

        //don't stop without stopTone:
//    	tg.startTone(ToneGenerator.TONE_DTMF_0);
//    	tg.startTone(ToneGenerator.TONE_DTMF_1);
//    	tg.startTone(ToneGenerator.TONE_DTMF_2);
//    	tg.startTone(ToneGenerator.TONE_DTMF_3);
//    	tg.stopTone();
        String output;// = "";

        //these values were always blank if the instantiations were in onResume
        usernameText = dialog.findViewById(R.id.usernameText1);
        passwordText = dialog.findViewById(R.id.passwordText);

        String username = usernameText.getText().toString();
        String password = passwordText.getText().toString();
        if (username.equals("")) {
            output = "Blank username";
        } else {
            output = "Username: " + username;
        }
        if (password.equals("")) {
            output += "\nBlank password";
        } else {
            output += "\nPassword: " + password;
        }
        Toast.makeText(MainActivity.this, output, Toast.LENGTH_LONG).show();
        dialog.dismiss();
    }

    public void cancelClick(View v) {
//    	if (!v.isSoundEffectsEnabled()){
//    		v.setSoundEffectsEnabled(true);
//    	}
//    	v.playSoundEffect(2);
//    	tg.startTone(ToneGenerator.TONE_CDMA_SOFT_ERROR_LITE);
//    	tg.startTone(ToneGenerator.TONE_SUP_ERROR); //doesn't stop without stopTone
        tg.startTone(ToneGenerator.TONE_CDMA_NETWORK_BUSY_ONE_SHOT); //best so far

        //don't stop without stopTone:
//    	tg.startTone(ToneGenerator.TONE_DTMF_3);
//    	tg.startTone(ToneGenerator.TONE_DTMF_2);
//    	tg.startTone(ToneGenerator.TONE_DTMF_1);
//    	tg.startTone(ToneGenerator.TONE_DTMF_0);
//    	tg.stopTone();

        if (usernameText == null)
            usernameText = dialog.findViewById(R.id.usernameText1);
        if (passwordText == null)
            passwordText = dialog.findViewById(R.id.passwordText);

        usernameText.setText("");
        passwordText.setText("");
        dialog.dismiss();
    }
}
