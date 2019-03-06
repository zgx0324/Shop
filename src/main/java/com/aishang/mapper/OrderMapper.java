package com.aishang.mapper;

import com.aishang.po.Order;
import com.aishang.po.OrderExt;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/3/1 15:58
 * @Description:
 */

public interface OrderMapper {

    //添加订单
    void addOrder(OrderExt orderExt);
    //获取oid
    Integer getOid(OrderExt orderExt);

    //根据单号查询订单
    List<Order> getOrderByOrderNumber(String orderNumber);

    // 根据订单oid 查询并返回OrderExt对象
    OrderExt getOrderByoid(Integer oid);

    // 修改订单支付状态
    void updatePayIDByOid(Order order);
}
