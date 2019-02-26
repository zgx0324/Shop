package com.aishang.mapper;

import java.util.List;

import com.aishang.po.Product;
import com.aishang.po.ProductBean;

public interface ProductMapper {


    //根据用户id查询用户信息
    Product getProductByID(Integer pid);

    // 根据一级类目查询最新上架的商品
    List<Product> getNewProduct(Integer cid, int start, int end);

    //获取该类目下推荐商品集合
    List<Product> getIsHotList(ProductBean productBean);

    //获取该类目下商品集合
    List<Product> categoryProductList(ProductBean productBean);

    Integer getToTalCount(ProductBean productBean);
}
