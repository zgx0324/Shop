package com.aishang.controller;

import com.aishang.po.Category;
import com.aishang.po.CategorySecondExt;
import com.aishang.po.Product;
import com.aishang.service.AishangService;
import com.aishang.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.*;

/**
 * @Author: ZGX
 * @Date: 2019/2/15 14:18
 * @Description:
 *              主页控制器
 */
@Controller
@RequestMapping("/aishang")
public class AishangController {
    // 注入参数
    @Resource
    private AishangService aishangService;

    // 请求转发到index页
    @RequestMapping("index")
    public String index(Model model){
        // 获得一级类目列表
        List<Category> categoryList = aishangService.findCategoryAll();

        // 获取二级类目map<cid,categorySecondList>集合
        Map<Integer,List<CategorySecondExt>> categorySecondMap = new HashMap<Integer,List<CategorySecondExt>>();
        for (Category category:categoryList ) {
            List<CategorySecondExt> categorySecondList = aishangService.findCategorySecondExtAllByCid(category.getCid());
            categorySecondMap.put(category.getCid(),categorySecondList);
        }

        // 获取热门商品列表
        List<Product> hotProductList = new ArrayList<Product>();
        Set<String> hotSet = aishangService.getHotSet("hot", 0, 4);
        for (String id:hotSet) {
            Double score = aishangService.getScoreByMember("hot", id);
            Product product = aishangService.getProductByID(Integer.parseInt(id));
            product.setScore(score);
            hotProductList.add(product);
        }

        // 获取最新商品列表
        Map<Integer,List<Product>> newProductMap = new HashMap<Integer,List<Product>>();
        for (Category category:categoryList ) {
            List<Product> newProductList =  aishangService.getNewProduct(category.getCid(),0,8);
            newProductMap.put(category.getCid(),newProductList);
        }

        model.addAttribute("categoryList",categoryList);
        model.addAttribute("categorySecondMap",categorySecondMap);
        model.addAttribute("newProductMap",newProductMap);
        model.addAttribute("hotProductList",hotProductList);
        return "index";
    }

    @RequestMapping("searchProduct")
    public String searchProduct(){
        return "searchProduct";
    }



}
