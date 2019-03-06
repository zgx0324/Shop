package com.aishang.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.aishang.mapper.AddressMapper;
import com.aishang.po.Category;
import com.aishang.po.CategorySecondExt;
import com.aishang.po.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aishang.po.Product;
import com.aishang.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {

    //注入service对象,根据类型来注入
    @Resource
    private ProductService productService;
    @Resource
    private HttpSession session;

    // 去往商品详情页
    @RequestMapping("productDetail")
    public String productDetail(Model model,Product product){

        User user = (User) session.getAttribute("user");

        model.addAttribute("addressList",productService.getAddressAll(user.getUid()));//根据用户id向前台返回地址集合列表
        model.addAttribute("productDetail",productService.getProductByID(product.getPid()));//商品详情的product对象
        model.addAttribute("categoryList", productService.findCategoryAll());//一级类目集合
        model.addAttribute("categorySecondMap", productService.categorySecondMap(productService.findCategoryAll()));//二级类目Map<Integer,List<CategorySecondExt>>集合
        return "productDetail";
    }



}