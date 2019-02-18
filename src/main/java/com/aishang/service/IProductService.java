package com.aishang.service;

import java.util.List;

import com.aishang.po.Product;

public interface IProductService {

    // 查询商品列表
    public List<Product> findAll();
}
