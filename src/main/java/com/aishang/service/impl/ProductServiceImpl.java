package com.aishang.service.impl;

import com.aishang.mapper.AddressMapper;
import com.aishang.mapper.ProductMapper;
import com.aishang.dao.RedisDao;
import com.aishang.po.Address;
import com.aishang.po.Category;
import com.aishang.po.CategorySecondExt;
import com.aishang.po.Product;
import com.aishang.service.CategorySecondService;
import com.aishang.service.CategoryService;
import com.aishang.service.ProductService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("productService")
public class ProductServiceImpl  implements ProductService {
    //TODO 注入参数
    @Resource
    private ProductMapper productMapper;
    @Resource
    private CategoryService categoryService;
    @Resource
    private CategorySecondService categorySecondService;
    @Resource
    private AddressMapper addressMapper;

    //根据用户id查询用户信息
    @Override
    public Product getProductByID(Integer id) {
        return productMapper.getProductByID(id);
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

    //TODO 地址查询

    // 根据用户id的查询地址集合列表
    @Override
    public List<Address> getAddressAll(Integer uid) {
        return addressMapper.getAddressAll(uid);
    }
}
