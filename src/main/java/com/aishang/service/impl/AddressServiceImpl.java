package com.aishang.service.impl;

import com.aishang.mapper.AddressMapper;
import com.aishang.po.Address;
import com.aishang.service.AddressService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @Author: ZGX
 * @Date: 2019/2/28 13:43
 * @Description:
 */
@Service
public class AddressServiceImpl implements AddressService {
    @Resource
    private AddressMapper addressMapper;

    // 添加地址
    @Override
    public void addAddress(Address address) {
        addressMapper.addAddress(address);
    }
    // 查询刚刚添加的地址
    @Override
    public Address getAddressByUntil(Address address) {
        return addressMapper.getAddressByUntil(address);
    }

    // 根据地址ID查询地址信息
    @Override
    public Address getAddressByID(Integer aid) {
        return addressMapper.getAddressByAid(aid);
    }

    // 修改地址信息
    @Override
    public void updateAddress(Address address) {
        addressMapper.updateAddress(address);
    }

    // 删除地址
    @Override
    public void delAddress(Integer aid) {
        addressMapper.delAddress(aid);
    }
}
