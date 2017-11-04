package com.dstrube.testfragmentactivity.Utils;

import java.lang.reflect.Method;

/**
 * Utilities
 */

public class Utils {
    public static String methodLogString(final Method method){
        final StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(method.getName());
        stringBuilder.append("(");
        boolean first = true;
        for (Class c : method.getParameterTypes()){
            if (!first) stringBuilder.append(", ");
            first = false;
            stringBuilder.append(c.getName());
        }
        stringBuilder.append(")");
        return stringBuilder.toString();
    }
}
