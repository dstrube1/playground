import android.util.Log;

//This makes logging a little easier.
//No need to declare and instantiate a TAG for each class where we want to do some logging
public class MyLogger {

    //enum to indicate log level
    public enum Level{INFO, WARN, ERROR}
    //not needed right now: debug, verbose, assert, wtf

    public static void Log(final Level level, final String message){
        //Build the TAG from info about the caller
        String className = Thread.currentThread().getStackTrace()[3].getClassName();
        if (className.lastIndexOf('.') != -1) {
            className = className.substring(className.lastIndexOf('.') + 1);
            //+1 so as to not include the '.' in the output
        }
        final String methodName = Thread.currentThread().getStackTrace()[3].getMethodName();

        final String TAG = className + " : " + methodName;

        //Log based on given level.
        if (level != null){
            switch (level){
                case INFO:
                    Log.i(TAG, message);
                    break;
                case WARN:
                    Log.w(TAG, message);
                    break;
                case ERROR:
                    Log.e(TAG, message);
                    break;
                default:
                    //If level is some unexpected value, that's not good
                    Log.wtf(TAG, message);
                    break;
            }
        }else {
            //If level is null, assume Info
            Log.i(TAG, message);
        }

    }
}
