package com.aishang.service;

import com.aishang.po.*;

import java.util.List;
import java.util.Map;

/**
 * @Author: ZGX
 * @Date: 2019/2/27 11:52
 * @Description:
 *              订单的service接口
 */

public interface OrderService {
    //TODO 用户操作

    //根据用户ID获得地址列表
    List<Address> getAddressAll(Integer uid);


    //TODO 商品操作

    // 根据商品ID获取商品信息
    Product getProductByID(Integer pid);

    //TODO 地址操作

    // 根据地址ID获取地址信息
    Address getAddressByAid(Integer aid);


    //TODO 省市联动操作
    //获得全国所有省份集合
    List<Region> getAllProvince();
    // 根据省份ID获取该省下属城市
    List<Region> getCityByProvinceID(Integer id);
    //返回回显的城市map
    Map<String,List<Region>> getRegionMap();
    //TODO 支付

    // 添加待支付订单 返回订单id
    Integer addOrderWithoutPay(OrderExt orderExt);

    // 根据银行卡账号查询Pay信息
    Integer checkAccount(String bankAccount);

    // 根据订单oid 查询并返回OrderExt对象
    OrderExt getOrderExtByOid(Integer withoutPayOid);
    // 检查是否支付成功
    boolean checkPay(Pay pay,Integer withoutPayOid,Integer uid);


    //TODO 购物车操作

    //添加至购物车
    void addBasket(OrderItemExt orderItem, Integer uid);
    //拿到购物车中商品集合
    List<OrderItemExt> getBasket(String s);
    //删除购物车商品集合列表
    void delBasket(List<String> pidList, String key);
}
