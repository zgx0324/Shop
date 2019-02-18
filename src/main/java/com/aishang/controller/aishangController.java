package com.aishang.controller;

import org.springframework.stereotype.Controller;
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

    @RequestMapping("index")
    public String index(){
        return "index";
    }
}
