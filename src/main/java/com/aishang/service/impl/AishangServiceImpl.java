package com.aishang.service.impl;

import com.aishang.dao.RedisDao;
import com.aishang.mapper.ProductMapper;
import com.aishang.po.Category;
import com.aishang.po.CategorySecondExt;
import com.aishang.po.Product;
import com.aishang.po.ProductBean;
import com.aishang.service.CategorySecondService;
import com.aishang.service.CategoryService;
import com.aishang.service.AishangService;
import com.aishang.service.ProductService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

/**
 * @Author: ZGX
 * @Date: 2019/2/20 16:35
 * @Description:
 */
@Service("aishangService")
public class AishangServiceImpl implements AishangService {

    // 注入参数
    @Resource
    private CategoryService categoryService;
    @Resource
    private CategorySecondService categorySecondService;
    @Resource
    private RedisDao redisDao;
    @Resource
    private ProductService productService;
    @Resource
    private ProductMapper productMapper;

   //TODO 类目查询操作
    // 返回一级类目列表
    @Override
    public List<Category> findCategoryAll() {
        return categoryService.findAll();
    }

    // 返回二级类目CategorySecondExt列表其中包括该类目下的三级类目
    @Override
    public List<CategorySecondExt> findCategorySecondExtAllByCid(Integer cid) {
        return categorySecondService.findAllByCid(cid);
    }


    //TODO Redis增删改查

    // 向redis库中存放热门商品
    @Override
    public void setHotSet(String key, Double score, String member) {
        redisDao.set(key, score, member);
    }

    // 从dedis库中取出热门商品set集合
    @Override
    public Set<String> getHotSet(String key, long start, long stop) {
        return redisDao.get(key, start, stop);
    }

    // 根据商品id获取销量
    @Override
    public Double getScoreByMember(String key, String member) {
        return redisDao.getScoreByMember(key,member);
    }

    // TODO Product商品查询

    //根据用户id查询用户信息
    @Override
    public Product getProductByID(Integer id) {
        return productService.getProductByID(id);
    }

    // 根据一级类目查询最新上架的商品
    @Override
    public List<Product> getNewProduct(Integer cid, int start, int end) {
        return productMapper.getNewProduct(cid,start,end);
    }

    //获取该类目下推荐商品集合
    @Override
    public List<Product> getIsHotList(ProductBean productBean) {
        return productMapper.getIsHotList(productBean);
    }

    //获取该类目下商品集合
    @Override
    public List<Product> categoryProductList(ProductBean productBean) {
        // 得到该类目下商品总数
        productBean.setTotalCount(productMapper.getToTalCount(productBean));
        // 返回分页集合
        return productMapper.categoryProductList(productBean);
    }
}
