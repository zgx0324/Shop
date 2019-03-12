package com.aishang.mapper;

import com.aishang.po.OrderItemExt;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/3/1 16:18
 * @Description: 订单项mapper
 */

public interface OrderItemMapper {

    //添加订单项
    void addOrderItem (OrderItemExt orderItemExt);
    // 根据订单ID查询订单项集合
    List<OrderItemExt> getOrderitemListByOid(Integer oid);
    //删除订单项
    void delOrderItem(int parseInt);
}
