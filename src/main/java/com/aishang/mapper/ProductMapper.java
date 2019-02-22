package com.aishang.mapper;

import java.util.List;

import com.aishang.po.Product;

public interface ProductMapper {


    //根据用户id查询用户信息
    Product getProductByID(Integer pid);

    // 根据一级类目查询最新上架的商品
    List<Product> getNewProduct(Integer cid, int start, int end);
}
