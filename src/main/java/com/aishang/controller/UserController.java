package com.aishang.controller;



import com.aishang.po.User;
import com.aishang.service.IUserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private IUserService userService;

    @RequestMapping("/checkUserName")
    public void checkUserName(String userName,HttpServletResponse response) throws IOException {
        User user = userService.findUserName(userName);
        PrintWriter out = response.getWriter();
        System.out.println(user);
        if(user!=null){
            out.print("false");
        }else{
            out.print("true");
        }
    }



}


