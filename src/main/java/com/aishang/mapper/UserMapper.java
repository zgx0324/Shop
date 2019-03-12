package com.aishang.mapper;

import com.aishang.po.User;

public interface UserMapper {
    //验证登录
    User doLogin(String userName,String passWord);
    //查找用户名为XX的用户信息
    User findUserName(String userName);
    //添加用户
    void addUser(User user);
    //修改用户
    void updateUser(User user);
}
