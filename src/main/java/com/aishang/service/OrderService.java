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

    //返回以state字段为四种订单状态所定义的map集合
    Map<Long,List<OrderExt>> getOrderGroupMap();
    //TODO 购物车操作

    //添加至购物车
    void addBasket(OrderItemExt orderItem, Integer uid);
    //拿到购物车中商品集合
    List<OrderItemExt> getBasket(String s);
    //删除购物车商品集合列表
    void delBasket(List<String> pidList, String key);


    // TODO 类目查询
    // 返回一级类目列表的函数
    List<Category> findCategoryAll();

    // 返回二级类目列表扩展类的函数
    List<CategorySecondExt> findCategorySecondExtAllByCid(Integer cid);

    // 获取二级类目map<cid,categorySecondList>集合
    Map<Integer, List<CategorySecondExt>> categorySecondMap(List<Category> categoryList);

    // 删除订单
    void delOrder(List<String> oidList);

    //根据用户id和支付密码判断是否存在该账户
    boolean checkFirmProduct(OrderExt orderExt, String bankPass);
    //分页查询历史订单
    List<OrderExt> getOrderPageBeanList(OrderBean orderBean);
}
