package com.aishang.service.impl;

import com.aishang.mapper.ProductMapper;
import com.aishang.po.Product;
import com.aishang.service.IProductService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service("productService")
public class ProductServiceImpl  implements IProductService {
    @Resource
    private ProductMapper productMapper;

    @Override
    public List<Product> findAll() {
        // TODO Auto-generated method stub
        return productMapper.findAll();
    }
}
