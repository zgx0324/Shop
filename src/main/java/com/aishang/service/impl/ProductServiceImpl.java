package com.aishang.service.impl;

import com.aishang.mapper.ProductMapper;
import com.aishang.dao.RedisDao;
import com.aishang.po.Product;
import com.aishang.service.ProductService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("productService")
public class ProductServiceImpl  implements ProductService {
    @Resource
    private ProductMapper productMapper;

    //根据用户id查询用户信息
    @Override
    public Product getProductByID(Integer id) {
        return productMapper.getProductByID(id);
    }
}
