package com.aishang.controller;

import com.aishang.po.Category;
import com.aishang.service.ICategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

/**
 * @Author: ZGX
 * @Date: 2019/2/15 14:18
 * @Description:
 *              主页控制器
 */
@Controller
@RequestMapping("/aishang")
public class aishangController {
    @Resource
    private ICategoryService categoryService;
    @RequestMapping("index")
    public String index(Model model){

        model.addAttribute("category","category");
        return "index";
    }
}
