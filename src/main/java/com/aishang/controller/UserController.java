package com.aishang.controller;



import com.aishang.po.User;
import com.aishang.service.UserService;
import com.aishang.util.PublicUtil;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/user")
public class UserController {
    @Resource
    private ServletContext applicationContext;
    //TODO 注入参数
    @Resource
    private UserService userService;
    @Resource
    private HttpSession session;

    //验证用户名是否可以使用
    @RequestMapping("/checkUserName")
    public void checkUserName(String userName, HttpServletResponse response) throws IOException {
        User user = userService.findUserName(userName);
        PrintWriter out = response.getWriter();
        System.out.println(user);
        if (user != null) {
            out.print("false");
        } else {
            out.print("true");
        }
    }

    //个人中心 修改个人信息
    @RequestMapping("personal")
    public String personal(Model model) {

        model.addAttribute("categoryList", userService.findCategoryAll());//一级类目集合
        model.addAttribute("categorySecondMap", userService.categorySecondMap(userService.findCategoryAll()));//二级类目Map<Integer,List<CategorySecondExt>>集合
        return "personal";
    }

    @RequestMapping(value = "update.do", method = RequestMethod.POST, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @ResponseBody
    public String update(@RequestParam("file") MultipartFile file, User user, HttpServletRequest request) {
        User user2 = (User) session.getAttribute("user");
        //后台表单验证
        String msg =null;
        boolean flag = true;
        //账号校验
        if (user.getUserName().trim().equals("") || user.getUserName().trim().equals(null) ) {
            flag = false;
            msg="账号错误";
        }
        //电话号校验
        if (!Pattern.compile("^1[3-9]\\d{9}$").matcher(user.getTel()).matches()) {
            flag = false;
            msg="电话号错误";
        }
        //密码校验
        if (user.getPassWord().trim().equals("") || user.getPassWord() == null) {
            user.setPassWord(user2.getPassWord());
        } else {
            if (user.getPassWord().length() < 6 || user.getPassWord().length() > 16) {
                msg="密码修改错误";
                flag = false;
            }
        }
        if(user.getAge()==null){
            user.setAge(user2.getAge());
        }
        if(user.getEmail()==null){
            user.setEmail(user2.getEmail());
        }
        if(user.getName()==null){
            user.setName(user2.getName());
        }
        if(user.getSex()==null){
            user.setSex(user2.getSex());
        }
        //头像校验
        if (!PublicUtil.isEmpty(file.getOriginalFilename())) {
            // ----拦截单个文件大小限制
            if (request.getContentLength() > 1024 * 1024 * 3) {
                msg="文件过大";
                flag = false;
            }
            //------后台校验图片格式
            String contentType = file.getContentType();
            if (!contentType.split("/")[0].equals("image")) {
                msg="文件格式不正确";
                flag = false;
            }
        }

        if (!flag) {//若验证各项有不符合标准的flag==false返回原页面，若全部正确则添加数据到数据库并跳转到注册成功页面
            return msg;
        } else {
            User user1 = userService.updateUser(user, file, applicationContext.getRealPath(""));
            if (user1 != null) {
                session.setAttribute("user", user1);
            }
            return user1.getIconPath();
        }
    }
}
