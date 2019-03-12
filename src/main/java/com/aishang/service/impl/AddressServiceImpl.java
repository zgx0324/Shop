package com.aishang.service.impl;

import com.aishang.mapper.AddressMapper;
import com.aishang.po.Address;
import com.aishang.po.Category;
import com.aishang.po.CategorySecondExt;
import com.aishang.service.AddressService;
import com.aishang.service.CategorySecondService;
import com.aishang.service.CategoryService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: ZGX
 * @Date: 2019/2/28 13:43
 * @Description:
 */
@Service
public class AddressServiceImpl implements AddressService {
    @Resource
    private AddressMapper addressMapper;
    @Resource
    private CategoryService categoryService;
    @Resource
    private CategorySecondService categorySecondService;

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

    // 根据用户id的查询地址集合列表
    @Override
    public List<Address> getAddressAll(Integer uid) {
        return addressMapper.getAddressAll(uid);
    }

    //TODO 类目查询操作
    // 返回一级类目列表
    @Override
    public List<Category> findCategoryAll() {
        return categoryService.findAll();
    }

    // 返回二级类目CategorySecondExt列表其中包括该类目下的三级类目
    @Override
    public List<CategorySecondExt> findCategorySecondExtAllByCid(Integer cid) {
        return categorySecondService.findAllByCid(cid);
    }

    // 获取二级类目map<cid,categorySecondList>集合
    @Override
    public Map<Integer, List<CategorySecondExt>> categorySecondMap(List<Category> categoryList) {
        Map<Integer, List<CategorySecondExt>> categorySecondMap = new HashMap<Integer, List<CategorySecondExt>>();
        for (Category category : categoryList) {
            List<CategorySecondExt> categorySecondList = findCategorySecondExtAllByCid(category.getCid());
            System.out.println(category);
            categorySecondMap.put(category.getCid(), categorySecondList);
        }
        return categorySecondMap;
    }
    //设置默认地址
    @Override
    public void updateAddressState(Address address) {
        List<Address> addressAll = addressMapper.getAddressAll(address.getUid());
        for (Address addr:addressAll) {
            if(address.getAid()==addr.getAid()){
                addr.setState(1);
            }else{
                addr.setState(0);

            }
            addressMapper.updateAddressState(addr);
        }
    }
}
