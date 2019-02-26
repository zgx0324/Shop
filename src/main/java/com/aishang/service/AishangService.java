package com.aishang.service;

import com.aishang.po.Category;
import com.aishang.po.CategorySecondExt;
import com.aishang.po.Product;
import com.aishang.po.ProductBean;

import java.util.List;
import java.util.Set;

/**
 * @Author: ZGX
 * @Date: 2019/2/20 16:32
 * @Description:
 */
public interface AishangService {



    // TODO 类目查询
    // 返回一级类目列表的函数
    List<Category> findCategoryAll();

    // 返回一级类目列表的函数
    List<CategorySecondExt> findCategorySecondExtAllByCid(Integer cid);





    // TODO redis数据查询
    // 通过Redis存放热门商品
    void setHotSet(String key,Double score,String member);

    // 取出Redis库中存放的热门商品
    Set<String> getHotSet(String key , long start, long stop);

    // 根据商品id获取销量
    Double getScoreByMember(String key ,String member);





    //TODO 商品查询

    // 根据商品id查询商品

    Product getProductByID(Integer id);

    // 根据一级类目查询最新上架的商品
    List<Product> getNewProduct(Integer cid, int start, int end);

    //获取该类目下推荐商品集合
    List<Product> getIsHotList(ProductBean productBean);

    //获取该类目下商品集合
    List<Product> categoryProductList(ProductBean productBean);
}
