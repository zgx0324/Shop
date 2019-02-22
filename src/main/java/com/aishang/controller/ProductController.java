package com.aishang.controller;

import java.util.List;

import javax.annotation.Resource;

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



}