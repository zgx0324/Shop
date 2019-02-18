package com.aishang.service.impl;

import com.aishang.mapper.UserMapper;
import com.aishang.po.User;
import com.aishang.service.IUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("userService")
public class UserServiceImpl implements IUserService {

    @Resource
    private UserMapper userDao;


    public User doLogin(String userName,String passWord) {
        return this.userDao.doLogin(userName,passWord);
    }

    @Override
    public User findUserName(String userName) {
        return this.userDao.findUserName(userName);
    }

    @Override
    public void addUser(User user) {
        userDao.addUser(user);
    }

}
