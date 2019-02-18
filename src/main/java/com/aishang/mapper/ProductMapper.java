package com.aishang.mapper;

import java.util.List;

import com.aishang.po.Product;

public interface ProductMapper {

    // 查询商品列表
    public List<Product> findAll();
}
