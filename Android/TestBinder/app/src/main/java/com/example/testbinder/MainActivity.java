package com.example.testbinder;

import android.os.Bundle;
import android.os.Process;
import android.os.IBinder;
import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;
import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.content.ServiceConnection;
//import android.text.Editable;
import android.util.Log;
import android.view.Menu;
import android.view.View;
//import android.view.View.OnClickListener;
//import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
//import android.widget.Toast;

//////////////////
/* 
* TestBinder
* Using Remote Services.
* Given project was just a one-way ServiceConnection, multiplying of two numbers, displaying the result in Toast.
* Now it's a two way ServiceConnection, adding or dividing two numbers, displaying the result in a TextView in MainActivity
*/
//////////////////

public class MainActivity extends Activity {

	private static final String TAG = "MainActivity";

	// we use it to communicate with the remote service
	private Messenger messenger;
	private boolean isBound;

//	private IMultiplier multiplierService;
	private IMather mathService;
	private boolean isAidlbound;

	// private Button sendButton;
	// private Button multiplyButton;

	private EditText input1, input2;
	private TextView resultText;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		input1 = (EditText) this.findViewById(R.id.input1);
		input2 = (EditText) this.findViewById(R.id.input2);
		resultText = (TextView) this.findViewById(R.id.resultText);
		// sendButton = (Button)this.findViewById(R.id.sendButton);
		// sendButton.setOnClickListener(new OnClickListener(){
		//
		// @Override
		// public void onClick(View v) {
		// sendMessage();
		// }
		//
		// });
		//
		// multiplyButton = (Button)this.findViewById(R.id.buttonMultiply);
		// multiplyButton.setOnClickListener(new OnClickListener(){
		//
		// @Override
		// public void onClick(View v) {
		// doMultiply();
		// }
		//
		// });

		bindService();
		bindAidlService();
	}

	public void onDestroy() {

		if (isBound)
			this.unbindService(myConnection);
		if (isAidlbound)
			this.unbindService(myAidlConnection);
		super.onDestroy();

	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}

	private void bindAidlService() {
		Intent intent = new Intent();
		intent.setClassName(this.getPackageName(),
				"com.example.testbinder.ClientAidl");
		boolean b = this
				.bindService(intent, myAidlConnection, BIND_AUTO_CREATE);
		Log.d(TAG, "bound? " + b);

	}

//	private void doMultiply() {
//		if (isAidlbound) {
//
//			try {
//				String[] input = input1.getText().toString().split(",");
//				String i1 = input1.getText().toString();
//				String i2 = input2.getText().toString();
//
//				String s = multiplierService.multiply(
//						Integer.parseInt(input[0]), Integer.parseInt(input[1]));
//				Toast.makeText(this, s, Toast.LENGTH_LONG).show();
//			} catch (RemoteException e) {
//				e.printStackTrace();
//			}
//
//		}
//	}

	public void Add(View v) {
		if (isAidlbound) {

			try {
				String i1 = input1.getText().toString();
				String i2 = input2.getText().toString();

				String s = mathService.add(
						Integer.parseInt(i1), Integer.parseInt(i2));
//				Toast.makeText(this, s, Toast.LENGTH_LONG).show();
				resultText.setText(s);
			} catch (RemoteException e) {
				e.printStackTrace();
			}

		}
	}

	public void Divide(View v) {
		if (isAidlbound) {

			try {
				String i1 = input1.getText().toString();
				String i2 = input2.getText().toString();

				String s = mathService.divide(
						Integer.parseInt(i1), Integer.parseInt(i2));
//				Toast.makeText(this, s, Toast.LENGTH_LONG).show();
				resultText.setText(s);
			} catch (RemoteException e) {
				e.printStackTrace();
			}

		}
	}

	private ServiceConnection myAidlConnection = new ServiceConnection() {

		@Override
		public void onServiceConnected(ComponentName name, IBinder service) {
//			multiplierService = IMultiplier.Stub.asInterface(service);
			mathService = IMather.Stub.asInterface(service);
			isAidlbound = true;
		}

		@Override
		public void onServiceDisconnected(ComponentName name) {
//			multiplierService = null;
			mathService = null;
			isAidlbound = false;
		}

	};

	private void bindService() {
		Intent intent = new Intent("com.example.testbinder.ClientService");
		this.bindService(intent, myConnection, BIND_AUTO_CREATE);
	}

	public void sendMessage() {
		if (isBound) {
			Message newMessage = Message.obtain();

			Bundle data = new Bundle();
			int pid = Process.myPid();
			String i1 = input1.getText().toString();
			String i2 = input2.getText().toString();

			// TODO: can we get the function name and put it here?
			data.putString("TITLE", i1 + " and " + i2 + " sender pid: " + pid);

			newMessage.setData(data);

			try {
				messenger.send(newMessage);
			} catch (RemoteException e) {
				e.printStackTrace();
			}

		}
	}

	private ServiceConnection myConnection = new ServiceConnection() {

		@Override
		public void onServiceConnected(ComponentName className, IBinder binder) {
			messenger = new Messenger(binder);
			isBound = true;
		}

		@Override
		public void onServiceDisconnected(ComponentName className) {
			messenger = null;
			isBound = false;
		}

	};

}
