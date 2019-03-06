package com.aishang.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

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
    public static String getOrderIdByUUId() {
        Date date = new Date();
        DateFormat format = new SimpleDateFormat("yyyyMMdd");
        String time = format.format(date);
        int hashCodeV = UUID.randomUUID().toString().hashCode();
        if (hashCodeV < 0) {//有可能是负数
            hashCodeV = -hashCodeV;
        }
        // 0 代表前面补充0
        // 4 代表长度为4
        // d 代表参数为正数型
        return time + String.format("%011d", hashCodeV);

    }
}
