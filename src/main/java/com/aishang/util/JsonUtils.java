package com.aishang.util;


import com.aishang.po.OrderItemExt;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/3/4 14:22
 * @Description:
 */

public class JsonUtils {
    //PO类转化JSON字符串
    public static String poToJson(OrderItemExt orderItem){
        JSONObject json = JSONObject.fromObject(orderItem);
        return json.toString();
    }
    //JSON字符串转化PO类
    public static OrderItemExt jsonToPo(String jsonStr){
        //1、使用JSONObject
        JSONObject jsonObject=JSONObject.fromObject(jsonStr);
        OrderItemExt orderItem=(OrderItemExt)JSONObject.toBean(jsonObject, OrderItemExt.class);
        return orderItem;
    }
    //JSON转化List<OrderItem>集合
    public static List<OrderItemExt> jsonToList(String string){
        List<OrderItemExt> orderItems=(List<OrderItemExt>) JSONArray.toCollection(JSONArray.fromObject(string), OrderItemExt.class);
        return orderItems;
    }
    // List转化JSON
    public  static String listToJson(List<OrderItemExt> orderItemList){
        JSONArray jsonArray = JSONArray.fromObject(orderItemList);
        return jsonArray.toString();
    }

}
