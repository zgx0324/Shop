package com.aishang.controller;

import com.aishang.po.Region;
import com.aishang.service.RegionService;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/28 9:23
 * @Description: 省市联动控制器
 */
@Controller
@RequestMapping("region")
public class RegionController {
    // TODO 注入参数
    @Resource
    private RegionService regionService;

    // ajax响应某省份下城市集合
    @RequestMapping("getCity")
    public void getCity(Integer id, HttpServletResponse response){
        List<Region> cityList = regionService.getCityByProvinceID(id);
        JSONArray jsonArray = JSONArray.fromObject(cityList);
        try {
            response.getWriter().print(jsonArray);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
