#include <jni.h>
#include <string>

extern "C"
JNIEXPORT jstring

JNICALL
Java_com_dstrube_myapplication_MainActivity_stringFromJNI(
        JNIEnv *env,
        jobject /* this */) {
    std::string hello = "Hello from C++";

    //BEGIN time stuff

    time_t now = time(0);
//    cout << "now : " << now << endl;

    std::string nows = ctime(&now);
  //  cout << "now string : " << nows << endl;
    hello = nows;

    tm *gmtm = gmtime(&now);
    nows = asctime(gmtm);
    //cout << "now string GMT : " << nows << endl;

    const time_t * t0 = & now;
    tm * local_time = localtime(t0); //"Segmentation fault" if t0 isn't assigned
    //or assigned to NULL

    //END time stuff

    return env->NewStringUTF(hello.c_str());
}
