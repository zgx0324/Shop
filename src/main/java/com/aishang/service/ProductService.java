package com.aishang.service;

import java.util.List;

import com.aishang.po.Product;

public interface ProductService {

    //根据用户id查询用户信息
    Product getProductByID(Integer id);
}
