package com.dstrube.myapplication;

import android.content.Context;
import android.content.SharedPreferences;

import java.util.concurrent.atomic.AtomicIntegerArray;

/**
 * Created by dstrubex on 6/29/15.
 */
public class AtomicByteArray extends AtomicIntegerArray {
    //Yes, it's an int array at the bottom; but we are careful to only allow bytes in
//    private final int[] array;
    //On second thought, a local array is redundant

    public AtomicByteArray(int length) {
        super(length);
//        array = new int[length];
    }

    public AtomicByteArray(int[] array) {
        //TODO byte[] array?
        super(array);
//        for (int i = 0; i < array.length; i++) {
//            array[i] = (byte) array[i];
//        }
//        this.array = array.clone();
    }


    //Only sets are necessary to implement.
    //As long as all data goes in right, it'll all come out right

    public final void set(int i, byte newValue) {
        super.set(i, newValue);
    }

    public final void lazySet(int i, byte newValue) {
        super.lazySet(i, newValue);
    }

    public final byte getAndSet(int i, byte newValue) {
        return (byte) super.getAndSet(i, newValue);
    }

    public final boolean compareAndSet(int i, byte expect, byte update) {
        return super.compareAndSet(i, expect, update);
    }

    public final boolean weakCompareAndSet(int i, byte expect, byte update) {
        return super.weakCompareAndSet(i, expect, update);
    }

    //gets are an afterthought. Not required to ensure proper functioning.
    // We only implement them to save the future dev time from having to cast output as byte

    //Had to call most of these getByte* and not get* due to bizarre name conflict.
    // (In my opinion, public final DataType1 name() and public final DataType2 name() should be legal)
    public final byte getByte(int i) {
        return (byte) super.get(i);
    }

    public final byte getByteAndIncrement(int i) {
        return (byte) super.getAndIncrement(i);
    }

    public final byte getByteAndDecrement(int i) {
        return (byte) super.getAndDecrement(i);
    }

    public final byte getAndAdd(int i, byte delta) {
        return (byte) super.getAndAdd(i, delta);
    }

    public final byte incrementAndGetByte(int i) {
        return (byte) super.incrementAndGet(i);
    }

    public final byte decrementAndGetByte(int i) {
        return (byte) super.decrementAndGet(i);
    }

    public final byte addAndGet(int i, byte delta) {
        return (byte) super.addAndGet(i, delta);
    }

    private Context mContext;
    public void setContext(Context context){
        mContext = context;
    }
    public String prefTest(){
        if (null == mContext){
            return "";
        }
        SharedPreferences prefs = mContext.getSharedPreferences(MainActivity.class.getSimpleName(),
                Context.MODE_WORLD_WRITEABLE); //other options: MODE_WORLD_READABLE, MODE_PRIVATE
        if (prefs.getAll().size() == 0) {
            return "";
        }
        String result;
        boolean isUpdateNeeded = prefs.getBoolean("updateNeeded",true);
        SharedPreferences.Editor editor0 = prefs.edit();
        if (isUpdateNeeded){
            result = "false";
            editor0.putBoolean("updateNeeded",false);
        }
        else{
            result = "true";
            editor0.putBoolean("updateNeeded",true);
        }
        editor0.apply();
        return result;
    }
}
