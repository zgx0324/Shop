package com.aishang.util;





import org.junit.Test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Author: ZGX
 * @Date: 2019/2/15 9:53
 * @Description:
 */

public class demo {

    @Test
    public void fun1(){
        // 要验证的字符串
        String str = "13734555123";
        boolean rs = Pattern.compile("^1[3-9]\\d{9}$").matcher(str).matches();
        System.out.println(rs);

    }
}
