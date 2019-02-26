package com.aishang.util;

/**
 * @Author: ZGX
 * @Date: 2019/2/24 17:16
 * @Description:
 *          通用工具类
 */

public class PublicUtil {

    //判断是否为空
    public static boolean isEmpty(Object obj) {
        boolean flag = true;
        if(obj==null &&obj==""){
            flag=false;
        }
        return flag;
    }
}
