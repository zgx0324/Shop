package com.aishang.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aishang.po.Product;
import com.aishang.service.IProductService;

@Controller
@RequestMapping("/product")
public class ProductController {

    //注入service对象,根据类型来注入
    @Resource
    private IProductService productService;

    //查询所有商品
    @RequestMapping("list")
    public String list(Model model){
        List<Product> list = productService.findAll();
        model.addAttribute("productlist", list);
        return "register";
    }

}