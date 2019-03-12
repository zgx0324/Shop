package com.aishang.service;

import com.aishang.po.Address;
import com.aishang.po.Category;
import com.aishang.po.CategorySecondExt;

import java.util.List;
import java.util.Map;

/**
 * @Author: ZGX
 * @Date: 2019/2/28 11:56
 * @Description:
 *              地址service
 */

public interface AddressService {
    // 添加地址
    void addAddress(Address address);
    // 查询刚刚添加的地址
    Address getAddressByUntil(Address address);

    // 根据地址ID查询地址信息
    Address getAddressByID(Integer aid);

    // 修改地址信息
    void updateAddress(Address address);

    // 删除地址
    void delAddress(Integer aid);

    // 根据用户id的查询地址集合列表
    List<Address> getAddressAll(Integer uid);

    // TODO 类目查询
    // 返回一级类目列表的函数
    List<Category> findCategoryAll();

    // 返回二级类目列表扩展类的函数
    List<CategorySecondExt> findCategorySecondExtAllByCid(Integer cid);

    // 获取二级类目map<cid,categorySecondList>集合
    Map<Integer, List<CategorySecondExt>> categorySecondMap(List<Category> categoryList);
    //设置默认地址
    void updateAddressState(Address address);
}
