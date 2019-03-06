package com.aishang.mapper;

import java.util.List;

import com.aishang.po.OrderItemExt;
import com.aishang.po.Product;
import com.aishang.po.ProductBean;

public interface ProductMapper {


    //根据商品id查询商品信息
    Product getProductByID(Integer pid);

    // 根据一级类目查询最新上架的商品
    List<Product> getNewProduct(Integer cid, int start, int end);

    //获取该类目下推荐商品集合
    List<Product> getIsHotList(ProductBean productBean);

    //获取该类目下商品集合
    List<Product> categoryProductList(ProductBean productBean);
    //得到商品总记录数
    Integer getToTalCount(ProductBean productBean);

    //更改库存
    void updateStock(OrderItemExt orderItemExt);
}
