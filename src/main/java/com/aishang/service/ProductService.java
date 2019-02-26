package com.aishang.service;

import java.util.List;
import java.util.Map;

import com.aishang.po.Category;
import com.aishang.po.CategorySecondExt;
import com.aishang.po.Product;

public interface ProductService {

    //根据用户id查询用户信息
    Product getProductByID(Integer id);

    // TODO 类目查询
    // 返回一级类目列表的函数
    List<Category> findCategoryAll();

    // 返回二级类目列表扩展类的函数
    List<CategorySecondExt> findCategorySecondExtAllByCid(Integer cid);

    // 获取二级类目map<cid,categorySecondList>集合
    Map<Integer, List<CategorySecondExt>> categorySecondMap(List<Category> categoryList);

}
