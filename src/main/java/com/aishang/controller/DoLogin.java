package com.aishang.controller;

import com.aishang.po.User;
import com.aishang.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.regex.Pattern;

/**
 * DoLogin控制器主要功能- 1，跳转到登录页
 *                      - 2，登录验证
 *                      - 3，退出登录
 *                      - 4，注册页面
 *                      - 5，注册提交页面
 */
@Controller
@RequestMapping
public class DoLogin {
    //TODO 注入参数
    @Resource
    private UserService userService;
    @Resource
    private HttpSession session;


    // TODO 1，跳转登录页面
    @RequestMapping("/login")
    public String login(String msg,Model model) {
        if (msg != null) {
            model.addAttribute("msg","账号或密码错误请重试");
        }
        return "login";
    }
    // TODO 2, 登录校验以及跳转主页

    @RequestMapping("/doLogin")
    public String doLogin(User user,String remember,HttpServletResponse response) {
        // 调用userService方法验证用户登录信息返回值为User对象
        User user1= userService.doLogin(user.getUserName(), user.getPassWord());
        // 若User对象不为空意为登陆成功跳转index页，否则为登陆失败返回登录页
        if(user1!=null){ //----------------------------登录成功
            // 创建session
            session.setAttribute("user",user1);
            // 创建cookie
            Cookie cookie1 = null;
            Cookie cookie2 = null;
            if (remember != null) {
                cookie1 = new Cookie("userName",user1.getUserName());
                cookie2 = new Cookie("passWord",user1.getPassWord());
                cookie1.setMaxAge(60*60*24*7);
                cookie2.setMaxAge(60*60*24*7);
                cookie1.setPath("/");
                cookie2.setPath("/");
                response.addCookie(cookie1);
                response.addCookie(cookie2);
            }else{
                cookie1 = new Cookie("userName",user1.getUserName());
                cookie2 = new Cookie("passWord",user1.getPassWord());
                cookie1.setMaxAge(0);
                cookie2.setMaxAge(0);
                cookie1.setPath("/");
                cookie2.setPath("/");
                response.addCookie(cookie1);
                response.addCookie(cookie2);
            }
            return "redirect:/aishang/index.do";
        }else { //----------------------------登录失败,返回login页
            return "redirect:login.do?msg=error";
        }

    }

    @RequestMapping("/ajaxDoLogin")
    @ResponseBody
    public String ajaxDoLogin(User user,String remember,HttpServletResponse response) {
        // 调用userService方法验证用户登录信息返回值为User对象
        User user1= userService.doLogin(user.getUserName(), user.getPassWord());
        // 若User对象不为空意为登陆成功跳转index页，否则为登陆失败返回登录页
        if(user1!=null){ //----------------------------登录成功
            // 创建session
            session.setAttribute("user",user1);
            // 创建cookie
            Cookie cookie1 = null;
            Cookie cookie2 = null;
            if (remember != null) {
                cookie1 = new Cookie("userName",user1.getUserName());
                cookie2 = new Cookie("passWord",user1.getPassWord());
                cookie1.setMaxAge(60*60*24*7);
                cookie2.setMaxAge(60*60*24*7);
                cookie1.setPath("/");
                cookie2.setPath("/");
                response.addCookie(cookie1);
                response.addCookie(cookie2);
            }else{
                cookie1 = new Cookie("userName",user1.getUserName());
                cookie2 = new Cookie("passWord",user1.getPassWord());
                cookie1.setMaxAge(0);
                cookie2.setMaxAge(0);
                cookie1.setPath("/");
                cookie2.setPath("/");
                response.addCookie(cookie1);
                response.addCookie(cookie2);
            }
           return "ok";
        }else { //----------------------------登录失败,返回login页
             return "fail";
        }

    }

    // TODO 3, 注册页面
    @RequestMapping("/register")
    public String register() {
        return "register";
    }

    // TODO 4, 注册提交页面
    @RequestMapping("/registerSubmit")
    public String registerSubmit(User user,Model model){
        String userName = user.getUserName();
        String passWord = user.getPassWord();
        String tel = user.getTel();
        //后台表单验证
        boolean flag = true;
        if(userName.trim().equals("")||userName.trim().equals(null)||userService.findUserName(userName)!=null){
            model.addAttribute("nameError","nameError");
            flag=false;
        }
        if(!Pattern.compile("^1[3-9]\\d{9}$").matcher(tel).matches()){
            model.addAttribute("telError","telError");
            flag=false;
        }
        if(passWord.trim().equals("")||passWord.trim()==null||passWord.length()<6||passWord.length()>16){
            model.addAttribute("passError","passError");
            flag=false;

        }
        if (!flag){//若验证各项有不符合标准的flag==false返回原页面，若全部正确则添加数据到数据库并跳转到注册成功页面
            return "forward:register.do";
        }else{
            user.setDate(new Date());
            userService.addUser(user);
            return "registerSuccess";
        }

    }

}
