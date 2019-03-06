package com.aishang.po;

import org.apache.ibatis.annotations.Lang;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/27 14:22
 * @Description: 订单项扩展类，一个订单中有多项商品
 */

public class OrderItemExt extends OrderItem {
    private Product product;
    private List<Product> productList;

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }
}
