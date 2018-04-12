package com.dstrube.myapplication;

import android.app.Activity;
import android.app.AlarmManager;
import android.app.PendingIntent;
import android.app.ProgressDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothManager;
import android.content.BroadcastReceiver;
import android.content.ContentValues;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.res.AssetFileDescriptor;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.graphics.Bitmap;
import android.graphics.NinePatch;
import android.net.Uri;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Environment;
import android.os.Message;
import android.os.PowerManager;
import android.security.KeyPairGeneratorSpec;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.math.BigInteger;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyPairGenerator;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.PrivateKey;
import java.security.SecureRandom;
import java.security.Signature;
import java.security.SignatureException;
import java.security.UnrecoverableEntryException;
import java.security.cert.Certificate;
import java.security.cert.CertificateException;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Queue;
import java.util.Random;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ConcurrentLinkedDeque;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.DelayQueue;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.LinkedTransferQueue;
import java.util.concurrent.PriorityBlockingQueue;
import java.util.concurrent.SynchronousQueue;
import java.util.concurrent.TimeUnit;
import java.util.zip.CRC32;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import javax.security.auth.x500.X500Principal;

/**
 * Created by dstrubex on 12/7/15.
 */
public class OldStuff {
    private final String TAG = this.getClass().getSimpleName();
    private String text;

//    @Override
    protected void onStop() {
//        super.onStop();
        stopAlarmTest();
//        testBugSenseEnd();
    }

    private void startAlarmTest() {
//        Intent myIntent = new Intent(MainActivity.this, MyAlarmService.class);
//        pendingIntent = PendingIntent.getService(MainActivity.this, 0, myIntent, 0);

//        AlarmManager alarmManager = (AlarmManager) getSystemService(ALARM_SERVICE);

        // Calendar takes the responsibility to initiate/ Start the service.
        // Service is not starting from the current activity

        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(System.currentTimeMillis());
        calendar.add(Calendar.SECOND, 5);

        Log.i(TAG, "calendar (+5 seconds).getTimeInMillis(): " + calendar.getTimeInMillis());
        //setting the internal to calendar.getTimeInMillis() doesn't work because it's way more than 5000
        //set phone to sleep in 15 seconds, set the repeat interval to 16000, watch this wake the phone up IF it buzzes in time
//        alarmManager.setInexactRepeating(AlarmManager.RTC_WAKEUP, calendar.getTimeInMillis(), 5000, //AlarmManager.INTERVAL_FIFTEEN_MINUTES,
//                pendingIntent);
//        Toast.makeText(MainActivity.this, "Start Alarm", Toast.LENGTH_LONG).show();
    }

    private void stopAlarmTest() {
//        AlarmManager alarmManager = (AlarmManager) getSystemService(ALARM_SERVICE);
//        //alarmManager.cancel(pendingIntent);
//
//        // Tell the user about what we did.
//        Toast.makeText(this, "Cancel!",
//                Toast.LENGTH_LONG).show();

        //this doesn't work:
        MyAlarmService myAlarmService = new MyAlarmService();
        myAlarmService.stop();
    }

    private void timerTest() {
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                text += "\nTimer Task done";

            }
        };
        Timer timer = new Timer("", false);
        text += "\nScheduling timer task...";
        timer.schedule(task, 0);
        text += "\nScheduled timer task...";
    }

    private void progressBarTest() {
        /*
        //Objective: make a progress bar dialog with a Cancel button
        ProgressDialog barProgressDialog = new ProgressDialog(this);
        barProgressDialog.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
        barProgressDialog.setProgress(0);
        barProgressDialog.setMax(100);
        barProgressDialog.setCanceledOnTouchOutside(false);
        barProgressDialog.setTitle("Title");
        barProgressDialog.setMessage("Message");
        barProgressDialog.setIndeterminate(false);
        barProgressDialog.setCancelable(true);
        Message message = null;
//        barProgressDialog.setButton(0, "text", message);


        final Activity parent = this;
        barProgressDialog.setOnCancelListener(
                new DialogInterface.OnCancelListener() {
                    @Override
                    public void onCancel(DialogInterface dialogInterface) {
                        Log.e(TAG, "Back Button Pressed");
                        Toast.makeText(getApplicationContext(),
                                "Pushed back", Toast.LENGTH_LONG).show();
                        parent.onBackPressed();
                    }
                }
        );
        barProgressDialog.show();

        for (int i = 0; i < barProgressDialog.getMax(); i++) {
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                text = "InterruptedException in progressBarTest: " + e.getMessage();
                Log.e(TAG, text);
            }
            barProgressDialog.setProgress(barProgressDialog.getProgress() + 1);
        }
        */
    }

    private void md5Test() {
        int size = 0;
        InputStream inputStream;
        final String fileInAssets = "binary.bin";
        byte[] content = null;
        try {

            //if file doesn't exist, this is the line where it fails:
//            inputStream = getResources().getAssets().open(fileInAssets);
//            size = inputStream.available();
            content = new byte[size];
//            int result = inputStream.read(content);
//            text += "\nsize in the try catch: " + size;
//            text += "\nsize of bytes read: " + result;
//            if (result == -1) {
//                return;
//            }
//
//            inputStream.close();
//            http://stackoverflow.com/questions/4846484/md5-hashing-in-android
            final String MD5 = "MD5";
            // Create MD5 Hash
            MessageDigest digest = MessageDigest
                    .getInstance(MD5);
            digest.update(content);
            byte messageDigest[] = digest.digest();

            // Create Hex String
            StringBuilder hexString = new StringBuilder();
            for (byte aMessageDigest : messageDigest) {
                String h = Integer.toHexString(0xFF & aMessageDigest);
                while (h.length() < 2)
                    h = "0" + h;
                hexString.append(h);
            }

            text += "\nMD5 of file: " + hexString.toString();

        } catch (NoSuchAlgorithmException e) {
            text = "NoSuchAlgorithmException while getInstance(MD5)";
//        } catch (IOException e) {
//            text = "IOException while checking size of InputStream ";
        }
        text += "\nsize outside the try catch: " + size;
        text += "\nsize of content outside the try catch: " + content.length;
    }

    private void filesMiscTest() {
        final String fileAnywhere = "";
        //Environment.getRootDirectory(); // = /system
        //contains: 14 top level items

        // Environment.getDownloadCacheDirectory(); //= /cache, can't read
        // Environment.getDataDirectory(); // = /data, can't read

        // Environment.getExternalStorageDirectory(); = // /storage/emulated/0
        //contains: 49 top level items
        // Environment.getExternalStoragePublicDirectory(""); // = same as above

        // getCacheDir(); ///storage/emulated/0/Android/data/com.example.dstrubex.myapplication/cache
        //has this file: [path]/com.android.opengl.shaders_cache
        // getExternalCacheDir() = same as above, but empty

        //these require API 21
        // getCodeCacheDir();
        // getNoBackupFilesDir();

        // getFilesDir(); // /data/data/com.example.dstrubex.myapplication/files
        // getExternalFilesDir("") // /storage/emulated/0/Android/data/com.example.dstrubex.myapplication/files
        // getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);// /storage/emulated/0/Android/data/com.example.dstrubex.myapplication/files/Download
        try {
            //http://stackoverflow.com/questions/4905743/android-how-to-gain-root-access-in-an-android-application

            /*This doesn't work; maybe seen as a security hole and patched up?

            boolean exitSu = false;
            Runtime runtime = Runtime.getRuntime();
            Process process = runtime.exec("su");
            DataOutputStream outputStream = new DataOutputStream(process.getOutputStream());
            DataInputStream inputStream = new DataInputStream(process.getInputStream());
            // Getting the id of the current user to check if this is root
            outputStream.writeBytes("id\n");
            outputStream.flush();

            String currUid = inputStream.readLine();
            text+="\ncurrUid = "+currUid;

            if (null == currUid)
            {
                exitSu = false;
                text += "\nCan't get root access or denied by user";
            }
            else if (currUid.contains("uid=0"))
            {
                exitSu = true;
                text += "\nRoot access granted";
            }
            else
            {
                exitSu = true;
                text += "\nRoot access rejected: " + currUid;
            }

            if (exitSu)
            {
                outputStream.writeBytes("exit\n");
                outputStream.flush();
            }
            */

            File allFiles = Environment.getExternalStorageDirectory();

            if (!allFiles.exists()) {
                text += "\nallFiles doesn't exist: " + allFiles.getAbsolutePath();
                return;
            }
            if (!allFiles.canRead()) {
                text += "\nallFiles can't read: " + allFiles.getAbsolutePath();
                return;
            } else {
                text += "\n\nallFiles getAbsolutePath: " + allFiles.getAbsolutePath();
                text += "\n\nallFiles getCanonicalPath: " + allFiles.getCanonicalPath();
            }
            if (allFiles.listFiles().length > 0 || allFiles.list().length > 0) {
                text += "\n\nNot empty";
            } else {
                text += "\n\nEmpty";
            }
            int count = 0;
            text += "\nallFiles (unordered list) : ";

            for (File f : allFiles.listFiles()) {
//                if (count > 5) {
                text += "\n " + f.getAbsolutePath();
//                }
                count++;
            }
            text += "\ntotal items at top level = " + count;


//            File file = new File(fileAnywhere);
//            if (!file.exists()) {
//                text += "\nfile doesn't exist: " + fileAnywhere;
//                return;
//            }
//            if (!file.canRead()) {
//                text += "\nfile can't read: " + fileAnywhere;
//                return;
//            }
        } catch (IOException e) {
            text += "\nIOException in filesMiscTest";
        } catch (NullPointerException npe) {
            text += "\nNullPointerException in filesMiscTest";

        }
    }

    private void adsTest() {
        //To get this to work, go to Project Structure (Command+;),
        //Dependencies, click on the Lower + (not the upper one),
        //select Library Dependencies, search for com.google,
        // select com.google.android.gms:play-services
        //then add the elements in activity_main.xml
//        AdView mAdView = (AdView) findViewById(R.id.adView);
//        AdRequest adRequest = new AdRequest.Builder().build();
//        mAdView.loadAd(adRequest);
    }

    private void test64bytes() {
//        byte b1 = Byte.MAX_VALUE; //127
//        text = "\nbyte max = " + b1;

//        short s1 = Short.MAX_VALUE; //32,767
//        text += "\nshort max = " + myNumberFormatter(""+s1);

//        int i1 = Integer.MAX_VALUE; //~2 billion
//        text += "\ninteger max = " + myNumberFormatter(""+i1);

//        long meLoveYouLongTime = Long.MAX_VALUE; //~9.2 quintillion
//        text += "\nlong max = " + myNumberFormatter(""+meLoveYouLongTime);

//        float f1 = Float.MAX_VALUE; //3.4 E38
//        text += "\nfloat max = " + f1;

//        double d1 = Double.MAX_VALUE; //1.8 E308
//        text += "\ndouble max = " + d1;
//        float f2 = new Float(d1); //Infinity
//        text += "\nFloat instantiated with double max = " + f2;

        byte[] bits64 = new byte[64];
        for (int index = 1; index <= bits64.length; index++) {
//            Log.i(TAG,"bits64["+index+"] = " +index);
            bits64[index - 1] = (byte) index;
        }

//        text += "\nbyte array used to instantiated bigInteger = " + stringifyByteArray(bits64);
        BigInteger bigInteger = new BigInteger(bits64);
//        text += "\nbigInteger = " + myNumberFormatter(bigInteger.toString());

//        ByteBuffer byteBuffer = ByteBuffer.allocate(64);
        byte[] array = null; //byteBuffer.putDouble(bigInteger.doubleValue()).array();
//        text += "\nbyte array instantiated with bigInteger (as a double from byteBuffer) = " + stringifyByteArray(array);
        array = bigInteger.toByteArray();
//        text += "\nbyte array size = " + array.length;
//        text += "\nbyte array instantiated with bigInteger directly = " + stringifyByteArray(array);

        text += "\nBuild.CPU_ABI = " + Build.CPU_ABI;
        text += "\nBuild.CPU_ABI2 = " + Build.CPU_ABI2;
        text += "\nBuild.SERIAL = " + Build.SERIAL;

        text += "\nBuild.VERSION.SDK_INT: " + Build.VERSION.SDK_INT;
        if (Build.VERSION.SDK_INT > 20) {
            //Requires SDK 21, which is not an option on my Moto G at this time
            text += "\nBuild.SUPPORTED_ABIS: ";
//            for (String s : Build.SUPPORTED_ABIS) {
//                text += "\n" + s;
//            }

            text += "\nBuild.SUPPORTED_32_BIT_ABIS: ";
//            String[] supported32Bits = Build.SUPPORTED_32_BIT_ABIS;
//            if (null == supported32Bits) {
//                text += "\nBuild.SUPPORTED_32_BIT_ABIS is null ";
//            } else if (supported32Bits.length == 0) {
//                text += "\nBuild.SUPPORTED_32_BIT_ABIS is empty ";
//            } else {
//                for (String s : supported32Bits) {
//                    text += "\n" + s;
//                }
//            }

            text += "\nBuild.SUPPORTED_64_BIT_ABIS: ";
//            String[] supported64Bits = Build.SUPPORTED_64_BIT_ABIS;
//            if (null == supported64Bits) {
//                text += "\nBuild.SUPPORTED_64_BIT_ABIS is null ";
//            } else if (supported64Bits.length == 0) {
//                text += "\nBuild.SUPPORTED_64_BIT_ABIS is empty ";
//            } else {
//                for (String s : supported64Bits) {
//                    text += "\n" + s;
//                }
//            }
        }
    }

    private String myNumberFormatter(String s) {
        int steps = 0;
        //1000
        for (int i = s.length(); i > 0; i--) {
            if (steps != 0 && steps % 3 == 0) {
                String lastHalf = s.substring(i);
                String firstHalf = s.substring(0, i);
                s = firstHalf + "," + lastHalf;
            }
            steps++;
        }
        return s;
    }

    private void inputStreamCloseTest() {
        int size = 0;
        InputStream inputStream;
        boolean on = true;
//        try {
//            inputStream = getResources().getAssets().open("invalidname");//blah.txt");
//            size = inputStream.available();
            text += "\nsize in the try catch: " + size;
//            inputStream.close();
//        } catch (IOException e) {
//            text = "IOException while checking size of InputStream ";
//        }
        text += "\nsize outside the try catch: " + size;

    }

    private void byteArrayEqualityTest() {
        final byte[] b1 = {0, 0};
        final byte[] b2 = {1, 0};
        final byte[] b3 = {0, 1};
        final byte[] b4 = {1, 1};
        final byte[] b5 = {0, 0};
        final byte[] b6 = null;
        final byte[] b7 = null;
        text = "";
        text += "b1: " + stringifyByteArray(b1);
        text += "\nb2: " + stringifyByteArray(b2);
        text += "\nb3: " + stringifyByteArray(b3);
        text += "\nb4: " + stringifyByteArray(b4);
        text += "\nb5: " + stringifyByteArray(b5);
        text += "\nb6: " + stringifyByteArray(b6);
        text += "\nb7: " + stringifyByteArray(b7);
        text += "\nb1 == b2? " + (b1 == b2);
        text += "\nb1 == b3? " + (b1 == b3);
        text += "\nb1 == b4? " + (b1 == b4);
        text += "\nb1 == b5? " + (b1 == b5);
        text += "\nb1 == b6? " + (b1 == b6);
        text += "\nb6 == b7? " + (b6 == b7);
        //all false, so it tests for whether it's the same object :(

        text += "\nareByteArraysEqual: b1, b2? " + areByteArraysEqual(b1, b2);
        text += "\nareByteArraysEqual: b1, b3? " + areByteArraysEqual(b1, b3);
        text += "\nareByteArraysEqual: b1, b4? " + areByteArraysEqual(b1, b4);
        text += "\nareByteArraysEqual: b1, b5? " + areByteArraysEqual(b1, b5);

    }

    private void byteArrayToStringLengthTest() {
        final int size = 20;
        byte[] bytes = new byte[size];
        Random random = new Random();
        random.nextBytes(bytes);

        String data = new String(bytes);

        //This doesn't work
        byte[] bytes1 = data.getBytes();

        //This doesn't work
        String data2 = new String(bytes, 0, size);
        byte[] bytes2 = new byte[size];
        data2.getBytes(0, 19, bytes2, 0);

        int sizeofBytes = bytes.length;
        int sizeofBytes1 = bytes.length;
        int sizeofBytes2 = bytes2.length;

        text = "Random bytes: " + bytes.toString();
        text += "\nstringified: " + stringifyByteArray(bytes);
        text += "\ndata = " + data;
        text += "\ngetBytes of data, stringified: " + stringifyByteArray(bytes1);
        text += "\ngetBytes(deprecated) of data, stringified: " + stringifyByteArray(bytes2);
        text += "\nsize of bytes: " + sizeofBytes;
        text += "\nsize of bytes1: " + sizeofBytes1;
        text += "\nsize of bytes2: " + sizeofBytes2;

    }

    private boolean areByteArraysEqual(final byte[] b1, final byte[] b2) {
        if (null == b1 && null == b2) {
            return true;
        }
        if (null != b1 && null == b2) {
            return false;
        }
        if (null == b1 && null != b2) {
            return false;
        }

        if (b1.length != b2.length) {
            return false;
        }

        for (int i = 0; i < b1.length; i++) {
            if (b1[i] != b2[i]) {
                return false;
            }
        }
        return true;

    }

    private void unpairBluetoothTest() {
        /*
        //This requires BLUETOOTH permission
        final BluetoothManager bluetoothManager =
                (BluetoothManager) getSystemService(Context.BLUETOOTH_SERVICE);

        final BluetoothAdapter adapter = bluetoothManager.getAdapter();

        final Set<BluetoothDevice> bondedDevices = adapter.getBondedDevices();

        try {
            final Class<?> btDeviceInstance = Class.forName(BluetoothDevice.class.getCanonicalName());
            //requires BLUETOOTH_ADMIN permission
            final Method removeBondMethod = btDeviceInstance.getMethod("removeBond");
            final String currentMac = "E7:84:B0:BC:6A:98";
            boolean cleared = false;

            for (BluetoothDevice bluetoothDevice : bondedDevices) {
                String mac = bluetoothDevice.getAddress();
                if (mac.equals(currentMac)) {
                    //requires BLUETOOTH_ADMIN permission
                    removeBondMethod.invoke(bluetoothDevice);
                    text += "\nCleared pairing with " + currentMac;
                    cleared = true;
                    break;
                }
            }

            if (!cleared) {
                text += "\nNot paired with " + currentMac;
            }
        } catch (Exception e) { //Throwable?
            text += "\nError unpairing: " + e.toString();
        }*/
    }

    private String stringifyByteArray(byte[] bytes) {
        if (null == bytes)
            return "null";

        StringBuilder sb = new StringBuilder("");
        for (byte b : bytes) {
            sb.append(b);
            sb.append(",");
        }
        sb.deleteCharAt(sb.length() - 1);
        return sb.toString();
    }

    public static String stringifyIntArray(int[] ints) {
        if (null == ints)
            return "null";

        StringBuilder sb = new StringBuilder("");
        for (int i : ints) {
            sb.append(i);
            sb.append(",");
        }
        sb.deleteCharAt(sb.length() - 1);
        return sb.toString();
    }

    private static final String ANDROID_KEY_STORE_PROVIDER = "AndroidKeyStore";
    private static final String KEY_PAIR_GENERATOR_ALGORITHM = "RSA";
    private static final String SIGNATURE_ALGORITHM = "SHA256withRSA";
    private static final byte SIGNATURE_DATA = 0;

    private void keystoreTest() {
        //https://developer.android.com/training/articles/keystore.html
//        String text = tv.getText().toString();
        try {
            final String alias = null;//"alias0";

            final KeyStore keyStore = KeyStore.getInstance(ANDROID_KEY_STORE_PROVIDER);

            //load the default key store
            keyStore.load(null);

            //if it doesn't exist, create it
            if (!isKeyStoreAliasFound(alias)) {
                text += "\ngiven keystore alias not found; trying to generate key pair...";
                myGenerateKeyPair(alias);
            }
            //if it still doesn't exist, something is wrong
            if (!isKeyStoreAliasFound(alias)) {
                text += "\ngiven keystore alias still not found; key pair generation failed";
                return;
            }

            final Enumeration<String> aliases = keyStore.aliases();


//            PrivateKey privateKey = keyPair.getPrivate();
//            PublicKey publicKey = keyPair.getPublic(); //is this what we'd send to the device?
            //These are both big
//            text += "\nprivateKey = " + privateKey.toString();
//            text += "\npublicKey = " + publicKey.toString();

            if (!aliases.hasMoreElements()) {
                text += "\nno keystore aliases found";
                return;
//            } else {
//                String aliasTemp = aliases.nextElement();
//                text += "\nalias = " + aliasTemp;
//                Certificate certificate = keyStore.getCertificate(aliasTemp);
//                PublicKey publicKey = certificate.getPublicKey();
//                //this is big:
//                //text += "\npublicKey = " + publicKey.toString();
////                final ByteBuffer result = ByteBuffer.allocate(4);
////                result.order(ByteOrder.LITTLE_ENDIAN);
//                byte[] FWUKey = publicKey.getEncoded();//result.put(publicKey.getEncoded()).array();
////                text += "\nFWUKey: " + stringifyByteArray(FWUKey);
//                text += "\nFWUKey size: " + FWUKey.length;
//
//                byte[] FWUKey1st4 = new byte[4];
//                System.arraycopy(FWUKey, 0, FWUKey1st4, 0, 4);
//                text += "\nFWUKey 1st 4: " + stringifyByteArray(FWUKey1st4);
//
//                byte[] FWUKeyLast4 = new byte[4];
//                System.arraycopy(FWUKey, FWUKey.length - 4, FWUKeyLast4, 0, 4);
//                text += "\nFWUKey last 4: " + stringifyByteArray(FWUKeyLast4);
            }

            final KeyStore.Entry entry = keyStore.getEntry(alias, null);
            if (null == entry) {
                text += "\nnull key store entry";
                return;
            }

            if (!(entry instanceof KeyStore.PrivateKeyEntry)) {
                text += "\nKeyStore.Entry is NOT an instance of a PrivateKeyEntry";
                return;
//            } else {
//                text += "\nKeyStore.Entry is an instance of a PrivateKeyEntry";
            }


            signatureStuff(entry);


        } catch (NoSuchAlgorithmException nsae) {
            text += "\nNoSuchAlgorithmException: " + nsae.getMessage();
        } catch (NoSuchProviderException nspe) {
            text += "\nNoSuchProviderException: " + nspe.getMessage();
        } catch (IllegalArgumentException iae) {
            text += "\nIllegalArgumentException";
        } catch (InvalidAlgorithmParameterException iape) {
            text += "\nInvalidAlgorithmParameterException: " + iape.getMessage();
        } catch (KeyStoreException kse) {
            text += "\nKeyStoreException: " + kse.getMessage();
        } catch (IOException ioe) {
            text += "\nIOException: " + ioe.getMessage();
        } catch (CertificateException ce) {
            text += "\nCertificateException: " + ce.getMessage();
        } catch (UnrecoverableEntryException uree) {
            text += "\nUnrecoverableEntryException: " + uree.getMessage();
        } catch (InvalidKeyException ike) {
            text += "\nInvalidKeyException: " + ike.getMessage();
        } catch (SignatureException se) {
            text += "\nSignatureException: " + se.getMessage();
//        } finally {
//            tv.setText(text);
        }
    }

    private boolean isKeyStoreAliasFound(final String alias)
            throws KeyStoreException, IOException, NoSuchAlgorithmException, CertificateException {
//        try {
        final KeyStore keyStore = KeyStore.getInstance(ANDROID_KEY_STORE_PROVIDER);
        keyStore.load(null);
        final Enumeration<String> aliases = keyStore.aliases();
        if (!aliases.hasMoreElements()) {
            return false;
        }
        while (aliases.hasMoreElements()) {
            final String aliasTemp = aliases.nextElement();
            if (alias.equals(aliasTemp)) {
                return true;
            }
        }
        return false;
//        }catch (KeyStoreException kse){
//            return false;
//        }catch (IOException ioe){
//            return false;
//        }catch (NoSuchAlgorithmException nsa){
//            return false;
//        } catch (CertificateException ce) {
//            return false;
//        }
    }

    private void myGenerateKeyPair(final String alias)
            throws NoSuchAlgorithmException, NoSuchProviderException, InvalidAlgorithmParameterException {

        final KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(KEY_PAIR_GENERATOR_ALGORITHM,
                ANDROID_KEY_STORE_PROVIDER);

        final Calendar cal = Calendar.getInstance();
        final Date now = cal.getTime();
        cal.add(Calendar.YEAR, 3);
        final Date end = cal.getTime();
        final SecureRandom secureRandom = new SecureRandom();
        final BigInteger serialNumber = BigInteger.valueOf(Math.abs(secureRandom.nextLong()));

        //This recreates the key:
//        keyPairGenerator.initialize(new KeyPairGeneratorSpec.Builder(getApplicationContext())
//                        .setAlias(alias) //device address
//                        .setStartDate(now)
//                        .setEndDate(end)
//                        .setSerialNumber(serialNumber)
//                        .setSubject(new X500Principal("CN=test1")) //https://developer.android.com/reference/javax/security/auth/x500/X500Principal.html
//                                //also: http://en.wikipedia.org/wiki/X.509
//                        .build()
//        );

        //This doesn't work without the above call
//        final KeyPair keyPair =
        keyPairGenerator.generateKeyPair();

        //no need to return anything;
        // once the key is generated, it's stored
    }


    private void signatureStuff(final KeyStore.Entry entry)
            throws NoSuchAlgorithmException, InvalidKeyException, SignatureException {

        final byte[] sigBytes = signPrivateKey(entry);

        verifySignature(entry, sigBytes);
    }

    private byte[] signPrivateKey(final KeyStore.Entry entry)
            throws NoSuchAlgorithmException, InvalidKeyException, SignatureException {

        final Signature signature0 = Signature.getInstance(SIGNATURE_ALGORITHM);

        final PrivateKey privateKey = ((KeyStore.PrivateKeyEntry) entry).getPrivateKey();
        byte[] sigBytes = null;
        if (null != privateKey) {
            signature0.initSign(privateKey);
            signature0.update(SIGNATURE_DATA);//most likely params: byte or byte[]
            //^same input = same signature
            sigBytes = signature0.sign();

            text += "\nsignature size: " + sigBytes.length;
            //256 bytes is big:
//            text += "\nsignature: "+stringifyByteArray(signature);
            final byte[] sigBytes1st4 = new byte[4];
            System.arraycopy(sigBytes, 0, sigBytes1st4, 0, 4);
            text += "\nsignature 1st 4: " + stringifyByteArray(sigBytes1st4);

            final byte[] sigBytesLast4 = new byte[4];
            System.arraycopy(sigBytes, sigBytes.length - 4, sigBytesLast4, 0, 4);
            text += "\nsignature last 4: " + stringifyByteArray(sigBytesLast4);

        } else {
            text += "\nnull private key; can't sign key";
        }
        return sigBytes;
    }

    private void verifySignature(final KeyStore.Entry entry, final byte[] sigBytes)
            throws NoSuchAlgorithmException, InvalidKeyException, SignatureException {

        final Signature signature1 = Signature.getInstance(SIGNATURE_ALGORITHM);
        final Certificate certificate = ((KeyStore.PrivateKeyEntry) entry).getCertificate();
        if (null != certificate) {

            signature1.initVerify(certificate);
            signature1.update(SIGNATURE_DATA);
            final boolean valid = signature1.verify(sigBytes);
            if (valid) {
                text += "\nSignature is valid";
            } else {
                text += "\nSignature is invalid";
            }
        } else {
            text += "\nnull certificate; can't validate signature";
        }
    }


    private void switchTest() {
        final StringBuilder text = new StringBuilder();
        for (int i = 0; i < 3; i++) {
            switch (i) {
                case 0:
                    text.append("\n" + i);
                    break;
                case 1:
                    text.append("\n" + i);
                    //Missing break means do lines below until break as well
                case 2:
                    text.append("\n" + i);
                    break;
                default:
                    text.append("\ndefault");
            }
        }
    }

    private void readFromSDCard() {
//Environment.getExternalStorageDirectory().getPath()+"/pictures/“;
        final String DOWNLOAD_DIR = Environment.getExternalStorageDirectory().getPath() + "/Download/";
        final File folder = new File(DOWNLOAD_DIR);

        if (folder.exists()) {
            final FilenameFilter binFilter = new FilenameFilter() {
                public boolean accept(File dir, String name) {
                    return name.toLowerCase().endsWith(".bin");
                }
            };
            final FilenameFilter applicationFilter = new FilenameFilter() {
                public boolean accept(File dir, String name) {
                    return name.toLowerCase().startsWith("application.ota")
                            && name.toLowerCase().endsWith(".bin");
                }
            };
            final FilenameFilter packageFilter = new FilenameFilter() {
                public boolean accept(File dir, String name) {
                    return name.toLowerCase().startsWith("package.sd")
                            && name.toLowerCase().endsWith(".bin");
                }
            };

            final String s1 = Environment.getExternalStorageState();
            final String s2 = Environment.getDataDirectory().toString();

            //Must include READ_EXTERNAL_STORAGE in the manifest
            String[] binFiles = folder.list(binFilter);
            File[] applicationFiles = folder.listFiles(applicationFilter);
            File[] packageFiles = folder.listFiles(packageFilter);
            File[] allFiles = folder.listFiles();

            String s3 = "", s4 = "", s5 = "";

            if (binFiles.length > 0) {
                s3 = binFiles[0]; //file.list just gives the file names
            }
            if (applicationFiles.length > 0)
                s4 = applicationFiles[0].getAbsolutePath();
            try {
                if (packageFiles.length > 0)
                    s5 = packageFiles[0].getCanonicalPath();
            } catch (IOException e) {
                s5 = e.getMessage();
            }
//            final String text = tv.getText().toString();
//            tv.setText(text
//                            + "\n# binFiles: " + binFiles.length
//                            + "\n# applicationFiles: " + applicationFiles.length
//                            + "\n# packageFiles: " + packageFiles.length
//                            + "\n# allFiles: " + allFiles.length
//                            + "\n# bin[0]: " + s3
//                            + "\n# app[0]: " + s4
//                            + "\n# pkg[0]: " + s5
//
//            );
        }

    }

    private void dateTest() {
        Date date = new Date();
//        tv.setText(tv.getText() + "\nDate at begin: " + date.toString());
//        try {
//            Thread.sleep(1000 * 63);
//            Date newDate = new Date();
//            long diff = newDate.getTime() - date.getTime();
//            long diffSeconds = diff / 1000 % 60;
//            long diffMinutes = diff / (60 * 1000) % 60;
//            tv.setText(tv.getText() + "\nDifference : " + diffSeconds + " seconds and "
//                    + diffMinutes + " minutes later");
//        } catch (InterruptedException e) {
//            tv.setText(tv.getText() + "\nInterruptedException");
//        }
//
//        Date date0 = new Date();
//        Date date1 = new Date(Long.MAX_VALUE);
//        tv.setText(tv.getText() + "\nLong.MAX_VALUE = " + Long.MAX_VALUE);
//        tv.setText(tv.getText() + "\ndate0 = " + date0);
//        tv.setText(tv.getText() + "\ndate1 = " + date1); //the year 292,278,994, August 16, a little after 11PM PST


    }

    private void myRunnableTest() {
//        tv.setText(tv.getText() + "\nRunning my runnable...");
//        MyRunnable myRunnable = new MyRunnable("hey");
//        new Thread(myRunnable).start();
//        tv.setText(tv.getText() + "\nRunned my runnable...");
    }

    static void ninePatchTest(){
        Bitmap bitmap = null;
        byte[] chunk = null;
        String srcName = "";
        NinePatch ninePatch = new NinePatch(bitmap, chunk, srcName);
    }

    public static void queueTest() {
        Queue arrayBlockingQueue = new ArrayBlockingQueue(1);//capacity must be > 0
        Queue arrayDeque = new ArrayDeque();
//        ArrayDeque arrayDeque1 = new ArrayDeque();
//        Iterator<Character> iterator = arrayDeque.iterator();
//        arrayDeque.
        Queue priorityQueue = new PriorityQueue();
        Queue linkedList = new LinkedList();
        Queue concurrentLinkedDeque = new ConcurrentLinkedDeque();
        Queue concurrentLinkedQueue = new ConcurrentLinkedQueue();
        Queue delayQueue = new DelayQueue();
        Queue linkedBlockingDeque = new LinkedBlockingDeque();
        Queue linkedBlockingQueue = new LinkedBlockingQueue();
        Queue linkedTransferQueue = new LinkedTransferQueue();
        Queue priorityBlockingQueue = new PriorityBlockingQueue();
        Queue<String> synchronousQueue = new SynchronousQueue();


        List list = new ArrayList<>();
        list.add(arrayBlockingQueue);    //0
        list.add(arrayDeque);            //1
        list.add(priorityQueue);        //2
        list.add(linkedList);            //3
        list.add(concurrentLinkedDeque);//4
        list.add(concurrentLinkedQueue);//5
        list.add(delayQueue);            //6
        list.add(linkedBlockingDeque);    //7
        list.add(linkedBlockingQueue);    //8
        list.add(linkedTransferQueue);    //9
        list.add(priorityBlockingQueue);//10
        list.add(synchronousQueue);        //11

        for (int i = 0; i < list.size(); i++) {
            System.out.println("adding stuff to queue #" + i);
            list.set(i, forEachQueue((Queue) list.get(i)));
        }
        for (int i = 0; i < list.size(); i++) {
            System.out.println("removing stuff from queue #" + i);
            Queue queue = (Queue) list.get(i);
            while (null != queue.peek()) {
                System.out.println(queue.remove());
                //ArrayBlockingQueue only has 1;
                //all others have all, except for DelayQueue & SynchronousQueue which have none
            }
        }

    }

    public static Queue forEachQueue(Queue queue) {
        if (null == queue) {
            System.out.println("null queue");
            return null;
        }
        try {
            queue.add(1);
            try {
                queue.add(1);
                queue.add(2);
                queue.add(3);
                queue.add(5);
            } catch (IllegalStateException illegalStateException) {
                //otherwise ArrayBlockingQueue complains that queue is full on second add
            }
            queue.offer(8);
        } catch (ClassCastException classCastException) {
            //otherwise DelayQueue complains "Integer cannot be cast to java.util.concurrent.Delayed" on first add
        } catch (IllegalStateException illegalStateException) {
            //otherwise SynchronousQueue complains that queue is full on first add
        }
        return queue;
    }

    private void hashTest() {
        Integer i = 1;
        Integer j = 1;
        text = "hashcode of i = " + i.hashCode();
        text += "\nhashcode of j = " + j.hashCode();
        j = i;
        text += "\nhashcode of j (=i) = " + j.hashCode();
        int[] array = new int[0];
        text += "\nhashcode of array[0] = " + array.hashCode();
        array = new int[1];
        text += "\nhashcode of array[1] = " + array.hashCode();
        text += "\nhashcode of array[1] = " + array.hashCode();
        array[0] = 1;
        text += "\nhashcode of array[1] = " + array.hashCode();
    }

    private void unzipFile() {
        //http://stackoverflow.com/questions/3382996/how-to-unzip-files-programmatically-in-android
        final String path = "";
        final String zipname = "";
        //TODO come back to this

        String filename;
        InputStream inputStream;
        ZipInputStream zipInputStream;
        try {
            inputStream = new FileInputStream(path + zipname);
            zipInputStream = new ZipInputStream(new BufferedInputStream(inputStream));
            ZipEntry zipEntry;
            final byte[] buffer = new byte[1024];
            int data;

            while ((zipEntry = zipInputStream.getNextEntry()) != null) {
                filename = zipEntry.getName();

                // Need to create directories if not exists, or
                // it will generate an Exception...
                if (zipEntry.isDirectory()) {
                    File directory = new File(path + filename);
                    final boolean mkdirResult = directory.mkdirs();
                    final String log = "mkdirResult of " + (path + filename) + " : " + mkdirResult;
                    Log.i(TAG, log);
                    text += log + "\n";
                    continue;
                }

                final String log = "writing " + (path + filename) + " ...\n ";
                Log.i(TAG, log);
                text += log + "\n";

                FileOutputStream fileOutputStream = new FileOutputStream(path + filename);

                while ((data = zipInputStream.read(buffer)) != -1) {
                    fileOutputStream.write(buffer, 0, data);
                }

                fileOutputStream.close();
                zipInputStream.closeEntry();
            }

            zipInputStream.close();
        } catch (final IOException e) {
            Log.e(TAG, e.getMessage());
            text += e.getMessage();
        }
    }


    private void enumTest() {

        MyEnum myEnum;
        myEnum = MyEnum.BANJO;
//        tv.setText(tv.getText() + "\nmyEnum = " + myEnum);
    }

    private void batteryTest() {
//        Intent batteryIntent = registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
//        int level = batteryIntent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
//        int scale = batteryIntent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
////        float batteryPct = (int)(level / (float)scale)*100;
//        int batteryPctInt = (int) ((level / (float) scale) * 100);//(int)batteryPct;
//
//        tv.setText(tv.getText() + "\nbattery percent: " + batteryPctInt + "%");
    }

    private void preferenceTest() {
        /*
        //how to do pref test outside an activity:
        AtomicByteArray atomicByteArray = new AtomicByteArray(0);
        atomicByteArray.setContext(this);
        String result = atomicByteArray.prefTest();
        tv.setText(tv.getText() + "\nPreference found: isUpdateNeeded = " + result);

        //inside an activity
        SharedPreferences prefs = getSharedPreferences(TAG, MODE_WORLD_WRITEABLE); //other options: MODE_WORLD_READABLE, MODE_PRIVATE
        if (prefs.getAll().size() > 0) {

            boolean isUpdateNeeded = prefs.getBoolean("updateNeeded", true);

            tv.setText(tv.getText() + "\nPreference found: isUpdateNeeded = " + isUpdateNeeded);

            SharedPreferences.Editor editor0 = prefs.edit();
            if (isUpdateNeeded) {
                editor0.putBoolean("updateNeeded", false);
            } else {
                editor0.putBoolean("updateNeeded", true);
            }
            editor0.apply();
        } else {
            tv.setText(tv.getText() + "\nPreference not found");
        }
*/
    }

    private void atomicByteArrayTest() {
        StringBuilder text = new StringBuilder();

        text.append("\nbyte min: " + Byte.MIN_VALUE);
        text.append("\nbyte max: " + Byte.MAX_VALUE);

        text.append("\nCycling thru byte values:\n");
        byte b = Byte.MIN_VALUE;
        for (; b < Byte.MAX_VALUE; b++) {
            if (b < -125 || b > 125) {
                text.append("" + b + " ");
            } else if ((b % 10) == 0) {
                text.append(".");
            }
        }
        text.append("" + b + " ");//127
        b++;
        text.append(";+1=" + b + " ");//-128

        text.append("\nCycling thru AtomicByteArray values:\n");
        AtomicByteArray atomicByteArray = new AtomicByteArray((Byte.MAX_VALUE * 2) + 2);
        b = Byte.MIN_VALUE;
        for (int i = 0; i < atomicByteArray.length(); i++) {
            atomicByteArray.set(i, b++);
        }

        for (int j = 0; j < atomicByteArray.length(); j++) {
            if (atomicByteArray.getByte(j) < -125 || atomicByteArray.getByte(j) > 125) {
                text.append("" + atomicByteArray.getByte(j) + " ");
            } else if ((j % 10) == 0) {
                text.append(".");
            }
        }

        text.append("\nTesting with ints too big to be bytes:");
        atomicByteArray.set(0, Byte.MIN_VALUE - 1);
        text.append("\n@0 = " + atomicByteArray.getByte(0));
        atomicByteArray.set(1, Byte.MAX_VALUE + 1);
        text.append("\n@1 = " + atomicByteArray.getByte(1));
        atomicByteArray.set(2, 200);
        text.append("\n@2 = " + atomicByteArray.getByte(2));
        atomicByteArray.set(3, -200);
        text.append("\n@3 = " + atomicByteArray.getByte(3));

        text.append("\nWhat if we instantiate with an array of invalid ints?:\n");
        int[] ints = new int[2];
        ints[0] = 200;
        ints[1] = -200;
        atomicByteArray = new AtomicByteArray(ints);
        for (int k = 0; k < atomicByteArray.length(); k++) {
            text.append("" + atomicByteArray.getByte(k) + " ");
        }


    }

    private void floatTest() {
        int index = 420;
        int bytesPerPacket = 19;
        int totalFileSize = 102152;
        int progress = (index * bytesPerPacket * 100) / totalFileSize;

        text = "\nprogress = " + progress;
    }

    private void arrayListCapacityTest() {
        ArrayList<Integer> blah = new ArrayList<Integer>(3);
        text = "\nsize before trimming=" + blah.size();
        blah.trimToSize();
        text += "\nsize before adding=" + blah.size();
        blah.add(0);
        blah.add(1);
        blah.add(2);
        blah.add(3);
        text +=  "\nsize before ensuring=" + blah.size();
        blah.ensureCapacity(3);
        blah.add(4);
        text +=  "\nsize=" + blah.size();

//        ensureCapacity does not ensure size; that must be done by hand
    }

    private void producerConsumerTest() {

        ArrayBlockingQueue<AtomicByteArray> queue = new ArrayBlockingQueue<AtomicByteArray>(10, true);
        DataGetterFromFile producer = new DataGetterFromFile(queue, "producer");
        DataSenderToDevice consumer1 = new DataSenderToDevice(queue, "c1");
        DataSenderToDevice consumer2 = new DataSenderToDevice(queue, "c2");
        new Thread(producer).start();
        new Thread(consumer1).start();
        new Thread(consumer2).start();
    }

    //in Clark code, producer can produce up to MAX_FILE_SIZE at a time,
    // but consumer can consume no more than 4 at a time.
    private class DataGetterFromFile implements Runnable {
        private final ArrayBlockingQueue<AtomicByteArray> queue;
        private final String name;

        DataGetterFromFile(ArrayBlockingQueue<AtomicByteArray> q, String n) {
            queue = q;
            name = n;
        }

        @Override
        public void run() {
            Log.i(TAG, "Running " + name);
            try {
                while (queue.offer(produce(), 10, TimeUnit.MILLISECONDS)) {
                    Log.i(TAG, "Producing with capacity = " + queue.remainingCapacity());
                }
                Log.i(TAG, "Stopping " + name);
            } catch (InterruptedException ex) {
            }
        }

        AtomicByteArray produce() {
            Random random = new Random();
            final int SIZE = 3;
            byte[] buffer = new byte[SIZE];
            int[] ints = new int[SIZE];
            random.nextBytes(buffer);

            for (int i = 0; i < buffer.length; i++) {
                ints[i] = buffer[i];
            }

            AtomicByteArray array = new AtomicByteArray(ints);
            return array;
        }
    }

    private class DataSenderToDevice implements Runnable {
        private final ArrayBlockingQueue<AtomicByteArray> queue;
        private final String name;

        DataSenderToDevice(ArrayBlockingQueue<AtomicByteArray> q, String n) {
            queue = q;
            name = n;
        }

        @Override
        public void run() {
            Log.i(TAG, "Running " + name);
            try {
                if (queue.peek() == null) {
                    Thread.sleep(200);
                }
                while (queue.peek() != null) {
                    consume(queue.poll(5, TimeUnit.MILLISECONDS));
                }
                Log.w(TAG, "Stopping " + name);
//                runOnUiThread(new Runnable() {
//                    @Override
//                    public void run() {
//                        tv.setText(tv.getText() + "; Stopping" + name + "; ");
//                    }
//                });
            } catch (InterruptedException ex) {
            }
        }

        void consume(AtomicByteArray x) {
            final String output = name + queue.size();//" consumes Byte[] this big: " + x.length() + "x"+
//            runOnUiThread(new Runnable() {
//                @Override
//                public void run() {
//                    tv.setText(tv.getText() + " " + output);
//                }
//            });
            Log.w(TAG, output);
        }
    }

    private void misc() {
        Log.d(TAG, "d = black");
        Log.e(TAG, "e = red");
        Log.w(TAG, "w = blue");
        Log.i(TAG, "i = black");
        Log.wtf(TAG, "wtf = red");
        Log.v(TAG, "v = black");
/*
        text += "\n" + Environment.getExternalStorageDirectory().getPath() + "/Download/";

        try {
            tv.setText("Index of blank in blah: " + tv.getText().toString().indexOf(""));
        } catch (Exception e) {
            tv.setText("Exception: " + e.toString());
        }
    }

    private void randomIntFromHex() {
//        String address = "E9:F5:F1:06:5A:45";//-827756322
        String address = "D1:C7:3C:53:95:48"; //-1245460205

        address = address.replace(":", "");
//        Long myLong = Long.decode(address);
        BigInteger bigInteger = new BigInteger(address, 16);//""+(Long.MAX_VALUE + 1));

        tv.setText(tv.getText() + "\nLong.MAX: " + Long.MAX_VALUE);
        tv.setText(tv.getText() + "\nbigInteger: " + bigInteger);

        Random random = new Random(bigInteger.longValue());
//        Random random = new Random(myLong);

        int randomInt = random.nextInt();
//        long randomLong = random.nextLong();
        tv.setText(tv.getText() + "\nRandom: " + randomInt);

        SecureRandom secureRandom = new SecureRandom();
        long myLong = 1;
        secureRandom.setSeed(myLong);

        int r0 = secureRandom.nextInt();
        tv.setText(tv.getText() + "\nRandom: " + r0);
*/
    }

    private void dbTest() {
        /*
        DBController dbController = new DBController(this);
        Hashtable<String, String> rowsIn = new Hashtable<String, String>();
        for (int i = 0; i < dbController.columnNames.size(); i++) {
            rowsIn.put(dbController.columnNames.get(i), "" + i);
        }
//        dbController.insertRow(rowsIn);

        ArrayList<Hashtable<String, String>> rowsOut = dbController.getAll();

        for (Hashtable<String, String> row : rowsOut) {
            Enumeration<String> enumKey = row.keys();
            while (enumKey.hasMoreElements()) {
                String key = enumKey.nextElement();
                String val = row.get(key);
                tv.setText(tv.getText() + "\n " + key
                        + " = " + val);
            }
        }
        */
    }

    private void byteToIntAndHex() {
        long test = Long.parseLong(
                "FFFFFFFF", 16);/*
        tv.setText(tv.getText() + "\n" + test);

        float f = 10.5f;

        byte b = Byte.MAX_VALUE;
        byte c = Byte.MIN_VALUE;
        tv.setText(tv.getText() + "\nByte.MAX_VALUE = " + b + ", in Hex =  " + String.format("%02X", b));
        tv.setText(tv.getText() + "\nByte.MIN_VALUE = " + c + ", in Hex =  " + String.format("%02X", c));
        byte d = -2;
        byte e = -1;
        //fails:
//        tv.setText(tv.getText()+"\n-2 = " + d + ", in Hex =  "+String.format("%02X",d) + ", back to byte: " + Byte.parseByte(String.format("%02X",d),16));
//        tv.setText(tv.getText()+"\n-1 = " + e + ", in Hex =  "+String.format("%02X",e) + ", back to byte: " + Byte.parseByte(String.format("%02X",e),16));
        String hex1 = String.format("%02X", d);
        String hex2 = String.format("%02X", e);
        int i1 = Integer.parseInt(hex1, 16);
        int i2 = Integer.parseInt(hex2, 16);
        byte d1 = (byte) (i1 & 0xFF);
        byte e1 = (byte) (i2 & 0xFF);
        tv.setText(tv.getText() + "\n-2 = " + d + ", in Hex =  " + hex1 + ", back to byte: " + d1);
        tv.setText(tv.getText() + "\n-1 = " + e + ", in Hex =  " + hex2 + ", back to byte: " + e1);
        */
    }

    private byte[] prependByteToByteArray(byte b, byte[] bytes) {
        byte[] newBytes = null;

        if (null == bytes) {
            newBytes = new byte[1];
            newBytes[0] = b;
            return newBytes;
        }

        newBytes = new byte[bytes.length + 1];
        newBytes[0] = b;

        for (int i = 0; i < bytes.length; i++) {
            newBytes[i + 1] = bytes[i];
        }

        return newBytes;
    }

    private void byteArrayManipulation() {
        ArrayBlockingQueue<Byte> fourMostRecent = new ArrayBlockingQueue<Byte>(4);
        byte[] last4;

        byte[] total = new byte[10];
//        for (byte i = 0; i < total.length; i++) {
//            total[i] = i;
//            tv.setText(tv.getText() + "\ntotal[" + i + "]" + total[i]);
//
//            try {
//                fourMostRecent = getFourMostRecent(fourMostRecent, total[i]);
//            } catch (InterruptedException e) {
//                tv.setText(tv.getText() + "\n" + e.toString());
//            } catch (IllegalStateException e) {
//                tv.setText(tv.getText() + "\n" + e.toString());
//            }
//            tv.setText(tv.getText() + "\n4 Most Recent:" + fourMostRecent.toString());
//
//            last4 = getLast4Bytes(total);
//            tv.setText(tv.getText() + "\nLast 4:" + stringifyByteArray(last4));
//        }
    }

    /**
     * Not exactly what I expected.
     * When byte[] has fixed size, last 4 are 0 until the last 4 are set
     *
     * @param last4
     * @param b
     * @return
     * @throws InterruptedException
     * @throws IllegalStateException
     */
    private ArrayBlockingQueue<Byte> getFourMostRecent(ArrayBlockingQueue<Byte> last4, byte b)
            throws InterruptedException, IllegalStateException {
        if (last4.remainingCapacity() > 0) {
            last4.add(b);
        } else {
            try {
                last4.take();
                last4.add(b);
            } catch (InterruptedException e) {
                throw new InterruptedException(e.toString());
            } catch (IllegalStateException e) {
                throw new IllegalStateException(e.toString());
            }
        }

        return last4;
    }

    private byte[] getLast4Bytes(byte[] chunk) {
        if (chunk.length <= 4) {
            return chunk;
        }

        byte[] last4 = new byte[4];

        int j = 3;
        for (int i = chunk.length - 1; i >= chunk.length - 4; i--) {
            last4[j] = chunk[i];
            j--;
        }

        return last4;
    }

    private byte[] inputStreamToByteArray(final InputStream inputStream, final int begin, final int BYTE_COUNT) {
        try {
            if (inputStream.available() > 1048576) { //1MB
                throw new IllegalArgumentException("InputStream is too large.");
            }
        } catch (IOException e) {
            Log.e(TAG,
                    "IOException in inputStreamToByteArray while checking size of InputStream ", e);
        }
        int bytesRead = 0;
        int byteSize = 0;

        byte[] buffer = null;

        ByteArrayOutputStream byteArrayOutputStream = null;

        try {
            if (begin + BYTE_COUNT > inputStream.available()) {
                Log.d(TAG, "begin + BYTE_COUNT = " + (begin + BYTE_COUNT)
                        + "; inputStream.available = " + inputStream.available());
                byteSize = inputStream.available() - begin;
            } else {
                byteSize = BYTE_COUNT;
            }
            buffer = new byte[byteSize];

            byteArrayOutputStream = new ByteArrayOutputStream(byteSize);

            if ((bytesRead = inputStream.read(buffer, begin, byteSize)) >= 0) {
                byteArrayOutputStream.write(buffer, 0, bytesRead);
            }

        } catch (IOException e) {
            Log.e(TAG, "IOException in inputStreamToByteArray while reading InputStream " +
                    "/ writing ByteArrayOutputStream", e);
        } finally {
            try {
                if (null != byteArrayOutputStream) {
                    byteArrayOutputStream.close();
                }
            } catch (IOException e) {
                Log.e(TAG, "IOException in inputStreamToByteArray while " +
                        "closing ByteArrayOutputStream", e);
            }
        }

        if (null == byteArrayOutputStream) {
            return null;
        } else {
            return byteArrayOutputStream.toByteArray();
        }
    }

    private PowerManager.WakeLock wakeLock;

    private void testWakeLock() {
        //http://stackoverflow.com/questions/2039555/how-to-get-an-android-wakelock-to-work
//        PowerManager powerManager = (PowerManager) getSystemService(Context.POWER_SERVICE);
//        wakeLock = powerManager.newWakeLock(PowerManager.SCREEN_DIM_WAKE_LOCK, "");
    }

    public void wakeLockClick1(View v) {
        //this is all well and good if running this from a UI,
        //but not an option in coding for a library with no UI
//        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
/*
        if (wakeLock != null) {
            if (wakeLock.isHeld()) {
                tv.setText("wakelock already acquired; ignoring this button push");
            } else {
                wakeLock.acquire();
                tv.setText("wakelock acquired");
            }
        } else {
            Toast.makeText(getApplicationContext(), "wakelock is null on acquire", Toast.LENGTH_SHORT).show();
        }
*/
    }

    public void wakeLockClick2(View v) {
//        getWindow().addFlags(WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON);
//        getWindow().addFlags(WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED);
        /*
        if (wakeLock != null) {
            if (wakeLock.isHeld()) {
                wakeLock.release();
                tv.setText("wakelock released");
            } else {
                tv.setText("wakelock not acquired before release; ignoring this button push");
            }
        } else {
            Toast.makeText(getApplicationContext(), "wakelock is null on release", Toast.LENGTH_SHORT).show();
        }
        */
    }

    private void registerTest() {
        /*
        try {
            tv.setText(tv.getText() + "\nbefore unregister");
            //hmm, registering a null receiver throws no error
            registerReceiver(receiver, new IntentFilter(""));
            //but will throw an error when it's unregistered
            unregisterReceiver(receiver);
            tv.setText(tv.getText() + "\nafter unregister");
        } catch (Exception e) {
            tv.setText(tv.getText() + "\nunregister threw exception: " + e.toString());
        }
        */
    }

    private void fileSizeStuff() {/*
        try {
            //txt = 73 bytes
            //docx = 4MB / 4,007,039
            //mp4 = 102.3 MB / 102,306,146
            //blah.docx from 20140904_Diana_Proto_NFF_Quick_Start_Guide.docx
            //blah.mp4 from Clark_Demo_FINAL.mp4
            InputStream iS = getResources().getAssets().open("blah.txt");
            BufferedReader reader = new BufferedReader(new InputStreamReader(iS));
            tv.setText(tv.getText() + "\ninput stream available() / size : " + iS.available());
            //byte[] bytes = inputStreamToByteArray(iS);
            //tv.setText(tv.getText() + "\nbytes length: "+bytes.length);
//100+MB file dies on inputStreamToByteArray; not on iS.available


            //File f = new File(
//            tv.setText(tv.getText() + "\nassets: " + getResources().getAssets().toString());
//            for (String path : getResources().getAssets().list("")){
//                tv.setText(tv.getText() + "\nfile in assets dir: " + path);
//            }

//            AssetManager mgr = getResources().getAssets();
//            String fileName = "blah.txt";
//            AssetFileDescriptor fd = getApplicationContext().getAssets().openFd(fileName);
            //file is compressed, can't get descriptor :(
            // getResources().getAssets().openFd(fileName);
            //workaround:
//                    openAssetFile(getResources().getAssets().openNonAssetFd(fileName))
//            tv.setText(tv.getText() + "\n"+fileName+" file descriptor length: "+fd.getDeclaredLength());


//            File cacheDir = new File(getCacheDir().getPath());
//            tv.setText(tv.getText() + "\ncache dir: "+getCacheDir().getPath());
//            if (cacheDir.listFiles().length > 0) {
//                for (File f : cacheDir.listFiles()) {
////                    tv.setText(tv.getText() + "\nfile in cache dir: " + f.getName());
//                }
//            }else{
//                tv.setText(tv.getText() + "\nCache dir is empty");
//            }

//            File filesDir = new File(getFilesDir().getPath());
//            tv.setText(tv.getText() + "\nfiles dir: "+getFilesDir().getPath());
//            if (filesDir.listFiles().length > 0) {
//                for (File f : filesDir.listFiles()){
//                    tv.setText(tv.getText() + "\nfile in files dir: "+f.getName());
//                }
//            }else{
////                tv.setText(tv.getText() + "\nFiles dir is empty");
//            }

            //tv.setText(tv.getText() + "\nfile contents: "+ reader.readLine());
        } catch (IOException e) {
            tv.setText(tv.getText() + "\nexception: " + e.toString());
        } finally {
        }
        */
    }

    private static byte[] inputStreamToByteArray(InputStream in) throws IOException {
        //from
        // http://www.java2s.com/Code/Android/File/InputStreamtobytearraycopyReaderandWriter.htm
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        int read = 0;
        byte[] buffer = new byte[1024];
        while (read != -1) {
            read = in.read(buffer);
            if (read != -1)
                out.write(buffer, 0, read);
        }
        out.close();
        return out.toByteArray();
    }

    private AssetFileDescriptor openAssetFile(final Uri uri, final String mode) throws FileNotFoundException {
        //was going to go down this path, from here:
        //http://stackoverflow.com/questions/6186866/java-io-filenotfoundexception-this-file-can-not-be-opened-as-a-file-descriptor
        //but it requires the path of the file, doesn't say how to get that for assets :(
        return null;
    }

    /**
     * Compare to strings
     *
     * @param xVersion x version
     * @param yVersion y version
     * @return true is x version is greater than y; else false
     */
    private boolean isXVersionGreaterThanY(String xVersion, String yVersion) {
        //assuming version format like 1.0.0
        //major.minor.revision- requires, at most, 3 checks

        //to reactivate, put this back in onCreate:
//        String devVersion = "3.1.2";
//        String updateVersion = "2.1.2";
//        try {
//            boolean isDeviceVersionGreater = isXVersionGreaterThanY(devVersion, updateVersion);
//            tv.setText(tv.getText() + "\nisDeviceVersionGreater = " + isDeviceVersionGreater);
//        }catch (Exception e){
//            tv.setText(tv.getText() + "\nexception: "+e.toString());
//
//        }

        if (xVersion == null || xVersion.length() < 5 || !xVersion.contains(".") ||
                xVersion.lastIndexOf(".") == xVersion.indexOf(".")) {
            throw new IllegalArgumentException("Invalid version x.");
        }
        if (yVersion == null || yVersion.length() < 5 || !yVersion.contains(".") ||
                yVersion.lastIndexOf(".") == yVersion.indexOf(".")) {
            throw new IllegalArgumentException("Invalid version y.");
        }

        int xMajor = Integer.parseInt(xVersion.substring(0, xVersion.indexOf(".")));
        int yMajor = Integer.parseInt(yVersion.substring(0, yVersion.indexOf(".")));
        if (xMajor > yMajor) {
            return true;
        } else if (xMajor < yMajor) {
            return false;
        }//else, they're equal. moving on to minor...

        int xMinor = Integer.parseInt(xVersion.substring(
                xVersion.indexOf(".") + 1, xVersion.lastIndexOf(".")));
        int yMinor = Integer.parseInt(yVersion.substring(
                yVersion.indexOf(".") + 1, yVersion.lastIndexOf(".")));
        if (xMinor > yMinor) {
            return true;
        } else if (xMinor < yMinor) {
            return false;
        }

        int xRevision = Integer.parseInt(xVersion.substring(xVersion.lastIndexOf(".") + 1));
        int yRevision = Integer.parseInt(yVersion.substring(yVersion.lastIndexOf(".") + 1));
        if (xRevision > yRevision) {
            return true;
        } else if (xRevision < yRevision) {
            //this last check is redundant, but useful for debugging
            return false;
        }
        return false;
    }



    /**
     * Some basic firmware update stuff
     */
    private void firmwareUpdateManagerStuff() {
//        tv.setText(tv.getText() + "\nshort max = " + Short.MAX_VALUE); //32K
//        tv.setText(tv.getText() + "\nint max = " + Integer.MAX_VALUE); //2.1B
//        tv.setText(tv.getText() + "\nByte max = " + Byte.MAX_VALUE); //127

        //        String sData = "123";
//        char[] cData = {'1'};//,'2','3'};
        //sData.toCharArray();
//byte[] data = sData.getBytes();
//        byte[] data = (byte[])cData;
//        byte[] data = new byte[cData.length];
//        for (int i=0; i< cData.length; i++){
//            data[i] = (byte)cData[i];
//        }
/*
        final int totalByteSize = 3;//40k-1
        //also tested with 40k, 40k+1
        final int byteSize = 2;//4k

        String sData = "2";
        byte[] data = sData.getBytes();//new byte[1];
//        data[0] = 1;
        tv.setText("data = " + data[0]);
        int crc = myCRC(data, data.length); //35234
//        int crc = myCRC(sData,sData.length()); //35234
        tv.setText(tv.getText() + "\ncrc = " + crc);


        byte[] bytes = new byte[totalByteSize];
        long crcResult = 0;
        byte[] chunk = null;
        Random r = new Random();
//        String fifteenInHex = Integer.toHexString(15);
//        tv.setText(tv.getText() + "\nfifteenInHex = "+fifteenInHex);
//        String x = "FD";
//        int xInDec = Integer.parseInt(x,16);//f=15 in base 16
//        tv.setText(tv.getText() + "\n"+x+" in decimal = "+xInDec);

        r.nextBytes(bytes);
        tv.setText(tv.getText() + "\nentire contents of bytes: " + stringifyByteArray(bytes));
//        byte[] newBytes = new byte[totalByteSize+1];
//        newBytes[0]=7;
//        for (int i=1; i< newBytes.length; i++){
//            newBytes[i]=bytes[i-1];
//        }
//        printByteArray(newBytes);
//        crcResult = createCRC(bytes);
//        crcResult = myCRC(bytes,bytes.length);
        tv.setText(tv.getText() + "\ntotal crcResult = " + crcResult);

        int iterationsNum = 0;
        if (byteSize <= 0) {
            tv.setText("byteSize must be greater than 0");
            return;
        }
        if (totalByteSize % byteSize == 0) {
            iterationsNum = totalByteSize / byteSize;
        } else {
            iterationsNum = (totalByteSize / byteSize) + 1;
        }*/
//        for (int i=0; i<iterationsNum; i++) {
//            chunk = createDataChunk(bytes, i);
//            crcResult = createCRC(chunk);
//            tv.setText(tv.getText() + "\nsize of chunk at iteration #"+i+": "+chunk.length+"; CRC = "+crcResult);
//            printByteArray(chunk);
//
//        }
//
//        crcResult = createCRC(bytes);
        //0=0; 1=352-340-7757 (tiffany, somewhere in gainesville FL); 2=110-474-5215; 4000=982-225-854
//        tv.setText(tv.getText() + "\ntotal crcResult = "+ crcResult);

//        tv.setText(tv.getText() + "\n");
//        tv.setText(tv.getText() + "\nbyte max = "+Byte.MAX_VALUE);
//        tv.setText(tv.getText() + "\nbyte max in hex= "+Integer.toHexString(Byte.MAX_VALUE));

        ArrayList<String> hexes = new ArrayList<String>();
        int count = 0;
        //in the loop below, we can't say i<=Byte.MAX_VALUE
        //because when the for loop gets to i==Byte.MAX_VALUE, it increments then goes to shit
        //i goes back to -128
        for (byte i = Byte.MIN_VALUE; i < Byte.MAX_VALUE; i++) {
            if (count < 5 || (count > 124 && count < 132) || (count > 250)) {
//                tv.setText(tv.getText() + "\nbyte " + i + " unsigned = " + unsignedToBytes(i)
//                + " in hex = "+Integer.toHexString(unsignedToBytes(i)));
                hexes.add(Integer.toHexString(unsignedByte(i)));
            }
            count++;
        }
//        tv.setText(tv.getText() + "\nbyte "+Byte.MAX_VALUE+" = " + unsignedToBytes(Byte.MAX_VALUE)
//                + " in hex = "+Integer.toHexString(unsignedToBytes(Byte.MAX_VALUE)));
        hexes.add(Integer.toHexString(unsignedByte(Byte.MAX_VALUE)));

        for (String s : hexes) {
//            tv.setText(tv.getText() + "\nhex " + s + " in byte = " + (byte) Integer.parseInt(s,16));
            //can't parse directly from hex to byte?
//                    Byte.parseByte(s,16));
        }
    }

    /**
     * Give a byte, get it unsigned
     *
     * @param b byte
     * @return unsigned byte (in form of int)
     */
    private int unsignedByte(byte b) {
        //changes range of byte from -128 to 127 => 0 (0) to 127 (127) to 128 (-128) to 255 (-1)
        return b & 0xFF;
    }

    /**
     * Demo of Android's CRC function
     *
     * @param bytes bytes
     * @return long CRC
     */
    private long createCRC(byte[] bytes) {
        if (null == bytes) {
//            tv.setText("bytes must be not null");
            return 0;
        }
        CRC32 crc = new CRC32();
        crc.update(bytes);
        return crc.getValue();
    }

    /**
     * Given a byte array of given length, get a cyclical redundancy check
     *
     * @param data data
     * @param len  length
     * @return crc
     */
    private int myCRC(byte[] data, int len) {
        //no unsigned short in java, only signed short (16 bit) and signed int (32 bit)
        int crc, tmp;//, i;//, j;


        crc = 0xffff;
//        tv.setText(tv.getText() + "\ncrc = " + crc);

        for (int i = 0; i < len; i++) { //for "1", len=1
            for (short j = 0; j < 8; j++) {
                tmp = ((data[i] << j) & 0x80) ^ ((crc & 0x8000) >> 8);
                //tv.setText(tv.getText() + "\ntmp = " + tmp);
                //this is how we make a signed int behave like a signed short
                // before getting its bits shifted 1 to the left
                if (crc >= 0x8000) {
                    crc -= 0x8000;
                }
                crc = crc << 1;

                if (tmp != 0) {
                    crc ^= 0x1021;
                    //tv.setText(tv.getText() + "\ntmp != 0; crc = " + crc);
                } else {
                    Log.i(TAG, "tmp == 0");
                    //tv.setText(tv.getText() + "\ntmp == 0; crc = " + crc);

                }
            }
        }

        return crc;
    }

    private BroadcastReceiver receiver = null;//new BroadcastReceiver() {

//        @Override
//        public void onReceive(Context context, Intent intent) {
//        }
//    };

    /**
     * This is a class for testing local db stuff
     */
    private class DBController extends SQLiteOpenHelper {
        private static final String TABLE_NAME = "deviceKey";
        public static final int NUMBER_OF_COLUMNS = 3;
        public ArrayList<String> columnNames;
        private ArrayList<String> columnTypes;

        /**
         * Constructor
         *
         * @param context context
         */
        public DBController(Context context) {
            super(context, "deviceKey.db", null, 1);

            Log.i(TAG, "Create DBController");

            columnNames = new ArrayList<String>(NUMBER_OF_COLUMNS);
            columnTypes = new ArrayList<String>(NUMBER_OF_COLUMNS);

            columnNames.add("deviceKeyId");
            columnNames.add("deviceAddress");
            columnNames.add("dateEntered");

            columnTypes.add("INTEGER PRIMARY KEY");
            columnTypes.add("TEXT");
            columnTypes.add("TEXT");

        }

        /**
         * Create the database
         */
        @Override
        public void onCreate(SQLiteDatabase db) {

            Log.i(TAG, "Create database");

            StringBuilder queryBuilder = new StringBuilder();
            queryBuilder.append("CREATE TABLE " + TABLE_NAME + " ( ");
            for (int i = 0; i < columnNames.size(); i++) {
                queryBuilder.append(columnNames.get(i) + " " + columnTypes.get(i));
                if (i < columnNames.size() - 1) {
                    queryBuilder.append(",");
                } else {
                    queryBuilder.append(")");
                }
            }
            db.execSQL(queryBuilder.toString());
        }

        /**
         * Upgrade the database
         */
        @Override
        public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
            Log.i(TAG, "Upgrade database");
            String query;
            query = "DROP TABLE IF EXISTS " + TABLE_NAME;
            db.execSQL(query);
            onCreate(db);
        }

        /**
         * Insert row
         *
         * @param queryValues hash table of query values
         */
        public void insertRow(Hashtable<String, String> queryValues) {
            SQLiteDatabase database = this.getWritableDatabase();
            ContentValues values = new ContentValues();

            for (String column : columnNames) {
                values.put(column, queryValues.get(column));
            }

            long insertRowId = database.insert(TABLE_NAME, null, values);

            if (insertRowId != -1) {
                Log.i(TAG, "Successfully inserted row into " + TABLE_NAME);
            } else {
                Log.e(TAG, "Problem inserting row into " + TABLE_NAME);
            }

            database.close();
        }

        /**
         * Update row
         *
         * @param queryValues
         * @return the number of rows affected
         */
//        public int updateRow(Hashtable<String, String> queryValues) {
//            Log.i(TAG, "Updating row");
//            SQLiteDatabase database = this.getWritableDatabase();
//            try {
//                ContentValues values = new ContentValues();
//
//                for (int i = 1; i < columnNames.size(); i++) {
//                    values.put(columnNames.get(i), queryValues.get(columnNames.get(i)));
//                }
//                return database.update(TABLE_NAME, values, columnNames.get(0) + " = ?",
//                        new String[]{queryValues.get(columnNames.get(0))});
//            } finally {
//                Log.i(TAG, "Updated row");
//                database.close();
//            }
//        }

        /**
         * Delete row
         *
         * @param id
         */
//        public void deleteRow(String id) {
//            Log.i(TAG, "Delete row");
//
//            SQLiteDatabase database = this.getWritableDatabase();
//            String deleteQuery = "DELETE FROM " + TABLE_NAME + " where " + columnNames.get(0) + " = " + id;
//            database.execSQL(deleteQuery);
//            database.close();
//            Log.i(TAG, "Deleted row");
//            //TO DO use database.delete(...) ?
//        }

        /**
         * Select * from table
         *
         * @return array list of all
         */
        public ArrayList<Hashtable<String, String>> getAll() {
            Log.i(TAG, "Get all rows");

            ArrayList<Hashtable<String, String>> wordList = new ArrayList<Hashtable<String, String>>();
            String selectQuery = "SELECT  * FROM " + TABLE_NAME;
            SQLiteDatabase database = this.getWritableDatabase();
            Cursor cursor = database.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                do {
                    Hashtable<String, String> map = new Hashtable<String, String>();

                    for (int i = 0; i < columnNames.size(); i++) {
                        map.put(columnNames.get(i), cursor.getString(i));
                    }

                    wordList.add(map);
                } while (cursor.moveToNext());
            }
            database.close();
            return wordList;
        }

        /**
         * Select * from table where id=id
         *
         * @param id id
         * @return hashtable of all by id
         */
        public Hashtable<String, String> getAllById(String id) {
            Log.i(TAG, "Get all rows by id " + id);

            Hashtable<String, String> wordList = new Hashtable<String, String>();
            SQLiteDatabase database = this.getReadableDatabase();
            String selectQuery = "SELECT * FROM " + TABLE_NAME + " where " + columnNames.get(0) + " = " + id;
            Cursor cursor = database.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                do {
                    for (int i = 1; i < columnNames.size(); i++) {
                        wordList.put(columnNames.get(i), cursor.getString(i));
                    }
                } while (cursor.moveToNext());
            }
            database.close();
            return wordList;
        }

        /**
         * Select * from table where fieldName = fieldValue
         *
         * @param fieldName  field name
         * @param fieldValue field value
         * @return hashtable of all by field
         */
        public Hashtable<String, String> getAllByField(String fieldName, String fieldValue) {
            Log.i(TAG, "Get all rows where " + fieldName + " = " + fieldValue);

            Hashtable<String, String> wordList = new Hashtable<String, String>();
            SQLiteDatabase database = this.getReadableDatabase();
            String selectQuery = "SELECT * FROM " + TABLE_NAME + " where " + fieldName + " = '"
                    + fieldValue + "'";
            Cursor cursor = database.rawQuery(selectQuery, null);
            if (cursor.moveToFirst()) {
                do {
                    for (int i = 0; i < columnNames.size(); i++) {
                        wordList.put(columnNames.get(i), cursor.getString(i));
                    }
                } while (cursor.moveToNext());
            }
            database.close();
            return wordList;
        }
    }

}
