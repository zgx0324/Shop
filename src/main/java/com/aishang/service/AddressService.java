package com.aishang.service;

import com.aishang.po.Address;

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
}
