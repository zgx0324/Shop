package com.aishang.controller;

import com.aishang.po.Address;
import com.aishang.po.User;
import com.aishang.service.AddressService;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.json.JsonArray;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/28 11:55
 * @Description: 地址控制器
 */
@Controller
@RequestMapping("address")
public class AddressController {

    // TODO 注入参数
    @Resource
    private AddressService addressService;
    @Resource
    private HttpSession session;

    //ajax响应地址集合
    @RequestMapping("addAddress")
    public void addAddress(Address address, HttpServletResponse response) {
        Address addr = null;
        if (address.getAid() == null) {
            User user = (User) session.getAttribute("user");
            address.setDate(new Date());
            address.setUid(user.getUid());
            addressService.addAddress(address);
            addr = addressService.getAddressByUntil(address);
        } else {
            addressService.updateAddress(address);
            addr = addressService.getAddressByID(address.getAid());

        }


        JSONArray jsonArray = JSONArray.fromObject(addr);
        try {
            response.getWriter().print(jsonArray);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //ajax根据ID响应地址对象
    @RequestMapping("getAddressByID")
    public void getAddressByID(Integer aid, HttpServletResponse response) {
        Address address = addressService.getAddressByID(aid);
        JSONArray jsonArray = JSONArray.fromObject(address);
        try {
            response.getWriter().print(jsonArray);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //修改地址
    @RequestMapping("updateAddress")
    public void updateAddress(Address address, HttpServletResponse response) {
        addressService.updateAddress(address);
        Address addressByID = addressService.getAddressByID(address.getAid());

        JSONArray jsonArray = JSONArray.fromObject(addressByID);
        try {
            response.getWriter().print(jsonArray);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    // 删除地址
    @RequestMapping("delAddress")
    public void delAddress(Integer aid, HttpServletResponse response) {
        addressService.delAddress(aid);
    }

    //设置默认地址
    @RequestMapping("defaultAddress")
    @ResponseBody
    public String defaultAddress(Address address){
        User user = (User) session.getAttribute("user");
        address.setUid(user.getUid());
        addressService.updateAddressState(address);
        return address.getAid()+"";
    }

}
