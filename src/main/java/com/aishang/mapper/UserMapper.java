package com.aishang.mapper;

import com.aishang.po.User;

public interface UserMapper {

    User doLogin(String userName,String passWord);

    User findUserName(String userName);

    void addUser(User user);
}
