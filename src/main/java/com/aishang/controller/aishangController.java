package com.aishang.controller;

import com.aishang.po.Category;
import com.aishang.po.CategorySecond;
import com.aishang.po.CategorySecondExt;
import com.aishang.po.CategoryThird;
import com.aishang.service.ICategorySecondService;
import com.aishang.service.ICategoryService;
import net.sf.json.JSONArray;
import org.junit.Test;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: ZGX
 * @Date: 2019/2/15 14:18
 * @Description:
 *              主页控制器
 */
@Controller
@RequestMapping("/aishang")
public class aishangController {
    // 注入参数
    @Resource
    private ICategoryService categoryService;
    @Resource
    private ICategorySecondService categorySecondService;

    // 请求转发到index页
    @RequestMapping("index")
    public String index(Model model){
        // 获得一级类目列表
        List<Category> categoryList = categoryService.findAll();
        // 获取二级类目map<cid,categorySecondList>集合
        Map<Integer,List<CategorySecondExt>> categorySecondMap = new HashMap<Integer,List<CategorySecondExt>>();
        for (Category category:categoryList ) {
            List<CategorySecondExt> categorySecondList = categorySecondService.findAllByCid(category.getCid());
            categorySecondMap.put(category.getCid(),categorySecondList);
        }
        model.addAttribute("categoryList",categoryList);
        model.addAttribute("categorySecondMap",categorySecondMap);
        return "index";
    }



}
