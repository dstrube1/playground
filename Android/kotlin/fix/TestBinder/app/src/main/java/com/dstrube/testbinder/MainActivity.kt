package com.dstrube.testbinder

import android.app.Activity
import android.content.Context
import android.widget.TextView
import android.widget.EditText
import android.content.Intent
import android.util.Log
import android.view.View
import android.content.ComponentName
import android.content.ServiceConnection
import android.os.*
import android.os.Process.myPid






class MainActivity : Activity() {

    private val TAG = "MainActivity"

    // we use it to communicate with the remote service
    private var messenger: Messenger? = null
    private var isBound: Boolean = false

    //	private IMultiplier multiplierService;
    private var mathService: IMather? = null
    private var isAidlbound: Boolean = false

    // private Button sendButton;
    // private Button multiplyButton;

    private var input1: EditText? = null
    private var input2: EditText? = null
    private var resultText: TextView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        input1 = this.findViewById(R.id.input1) as EditText
        input2 = this.findViewById(R.id.input2) as EditText
        resultText = this.findViewById(R.id.resultText) as TextView
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

        bindService()
        bindAidlService()
    }

    public override fun onDestroy() {

        if (isBound)
            this.unbindService(myConnection)
        if (isAidlbound)
            this.unbindService(myAidlConnection)
        super.onDestroy()

    }

    private fun bindAidlService() {
        val intent = Intent()
        intent.setClassName(this.packageName,
                "com.example.testbinder.ClientAidl")
        val b = this
                .bindService(intent, myAidlConnection, Context.BIND_AUTO_CREATE)
        Log.d(TAG, "bound? $b")

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

    fun Add(v: View) {
        if (isAidlbound) {

            try {
                val i1 = input1.getText().toString()
                val i2 = input2.getText().toString()

                val s = mathService.add(
                        Integer.parseInt(i1), Integer.parseInt(i2))
                //				Toast.makeText(this, s, Toast.LENGTH_LONG).show();
                resultText.setText(s)
            } catch (e: RemoteException) {
                e.printStackTrace()
            }

        }
    }

    fun Divide(v: View) {
        if (isAidlbound) {

            try {
                val i1 = input1.getText().toString()
                val i2 = input2.getText().toString()

                val s = mathService.divide(
                        Integer.parseInt(i1), Integer.parseInt(i2))
                //				Toast.makeText(this, s, Toast.LENGTH_LONG).show();
                resultText.setText(s)
            } catch (e: RemoteException) {
                e.printStackTrace()
            }

        }
    }

    private val myAidlConnection = object : ServiceConnection {

        override fun onServiceConnected(name: ComponentName, service: IBinder) {
            //			multiplierService = IMultiplier.Stub.asInterface(service);
            mathService = IMather.Stub.asInterface(service)
            isAidlbound = true
        }

        override fun onServiceDisconnected(name: ComponentName) {
            //			multiplierService = null;
            mathService = null
            isAidlbound = false
        }

    }

    private fun bindService() {
        val intent = Intent("com.example.testbinder.ClientService")
        this.bindService(intent, myConnection, Context.BIND_AUTO_CREATE)
    }

    fun sendMessage() {
        if (isBound) {
            val newMessage = Message.obtain()

            val data = Bundle()
            val pid = Process.myPid()
            val i1 = input1.getText().toString()
            val i2 = input2.getText().toString()

            // TODO: can we get the function name and put it here?
            data.putString("TITLE", "$i1 and $i2 sender pid: $pid")

            newMessage.setData(data)

            try {
                messenger.send(newMessage)
            } catch (e: RemoteException) {
                e.printStackTrace()
            }

        }
    }

    private val myConnection = object : ServiceConnection {

        override fun onServiceConnected(className: ComponentName, binder: IBinder) {
            messenger = Messenger(binder)
            isBound = true
        }

        override fun onServiceDisconnected(className: ComponentName) {
            messenger = null
            isBound = false
        }

    }
}
