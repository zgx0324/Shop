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
}
