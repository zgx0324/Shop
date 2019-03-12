package com.aishang.mapper;

import com.aishang.po.Address;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/26 16:40
 * @Description:
 *              地址mapper类
 */

public interface AddressMapper {

    // 根据用户id的查询地址集合列表
    List<Address> getAddressAll(Integer uid);

    // 根据地址ID获取地址信息
    Address getAddressByAid(Integer aid);

    // 添加地址
    void addAddress(Address address);
    // 查询刚刚添加的地址
    Address getAddressByUntil(Address address);

    // 修改地址信息
    void updateAddress(Address address);
    // 删除地址
    void delAddress(Integer aid);
    //设置默认地址
    void updateAddressState(Address address);
}
