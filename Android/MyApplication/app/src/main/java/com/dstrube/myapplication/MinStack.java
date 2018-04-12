package com.dstrube.myapplication;

import java.util.Stack;

/**
 *
 */
public class MinStack extends Stack {

    private Stack<Integer> mMin;
    public static final Integer NO_MIN = Integer.MAX_VALUE;

    public MinStack(){
        super();
        mMin = new Stack<>();
    }

    public Integer peek(){
        return Integer.valueOf(super.peek().toString());
    }

    public Integer push(Integer i){
        if (size() == 0 || mMin.peek() <= i){
            mMin.push(i);
        }
        return Integer.valueOf(super.push(i).toString());
    }

    public Integer pop(){
        if (mMin.peek() != null && mMin.peek() == peek()){
            mMin.pop();
        }
        return Integer.valueOf(super.pop().toString());
    }

    public Integer min(){
        if (mMin.size() == 0){
            return NO_MIN;
        }
        return mMin.peek();
    }
}
