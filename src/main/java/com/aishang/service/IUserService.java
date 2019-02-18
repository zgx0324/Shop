package com.aishang.service;

import com.aishang.po.User;

public interface IUserService {
    User doLogin(String userName,String passWord);

    User findUserName(String userName);

    void addUser(User user);
}
