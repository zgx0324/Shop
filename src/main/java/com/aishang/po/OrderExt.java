package com.aishang.po;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/27 13:49
 * @Description: 订单扩展类，一个订单可以用多个订单项
 */

public class OrderExt extends Order {
    private List<OrderItemExt> orderItemExtsList;

    public List<OrderItemExt> getOrderItemExtsList() {
        return orderItemExtsList;
    }

    public void setOrderItemExtsList(List<OrderItemExt> orderItemExtsList) {
        this.orderItemExtsList = orderItemExtsList;
    }
}
