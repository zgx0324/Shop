package com.aishang.controller;

import com.aishang.po.*;
import com.aishang.service.AishangService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.*;

/**
 * @Author: ZGX
 * @Date: 2019/2/15 14:18
 * @Description: 主页控制器
 */
@Controller
@RequestMapping("/aishang")
public class AishangController {
    // 注入参数
    @Resource
    private AishangService aishangService;

    // TODO 请求转发到index页
    @RequestMapping("index")
    public String index(Model model) {
        // 获取热门商品列表
        List<Product> hotProductList = new ArrayList<Product>();
        Set<String> hotSet = aishangService.getHotSet("hot", 0, 4);
        for (String id : hotSet) {
            Double score = aishangService.getScoreByMember("hot", id);
            Product product = aishangService.getProductByID(Integer.parseInt(id));
            product.setScore(score);
            hotProductList.add(product);
        }

        // 获取最新商品列表
        Map<Integer, List<Product>> newProductMap = new HashMap<Integer, List<Product>>();
        for (Category category : categoryList()) {
            List<Product> newProductList = aishangService.getNewProduct(category.getCid(), 0, 8);
            newProductMap.put(category.getCid(), newProductList);
        }

        model.addAttribute("categoryList", categoryList());//一级类目集合
        model.addAttribute("categorySecondMap", categorySecondMap());//二级类目Map<Integer,List<CategorySecondExt>>集合
        model.addAttribute("newProductMap", newProductMap);//最新商品集合
        model.addAttribute("hotProductList", hotProductList);//最热商品集合
        return "index";
    }

    //TODO 请求转发到搜索商品页面
    @RequestMapping("searchProduct")
    public String searchProduct(Model model, ProductBean productBean) {
        // 为复合查询中商品名去空格
        if (productBean!=null){
           if( productBean.getSelectpName()!=null &&!productBean.getSelectpName().trim().equals("")){
               productBean.setSelectpName(productBean.getSelectpName().trim());
           }

        }
        //获取该类目下推荐商品集合
        List<Product> isHotProductList = aishangService.getIsHotList(productBean);
        //获取该类目下商品集合
        List<Product> searchProductList = aishangService.categoryProductList(productBean);
        model.addAttribute("productBean",productBean);
        model.addAttribute("categoryThirdProductList", searchProductList);//该类目下商品集合
        model.addAttribute("isHotList", isHotProductList);//该类目下推荐商品集合
        model.addAttribute("categoryList", categoryList());//一级类目集合
        model.addAttribute("categorySecondMap", categorySecondMap());//二级类目Map<Integer,List<CategorySecondExt>>集合
        return "searchProduct";
    }


// TODO 本类通用函数

    // 获得一级类目列表
    public List<Category> categoryList() {
        return aishangService.findCategoryAll();
    }

    // 获取二级类目map<cid,categorySecondList>集合
    public Map<Integer, List<CategorySecondExt>> categorySecondMap() {
        Map<Integer, List<CategorySecondExt>> categorySecondMap = new HashMap<Integer, List<CategorySecondExt>>();
        for (Category category : categoryList()) {
            List<CategorySecondExt> categorySecondList = aishangService.findCategorySecondExtAllByCid(category.getCid());
            categorySecondMap.put(category.getCid(), categorySecondList);
        }
        return categorySecondMap;
    }

}
