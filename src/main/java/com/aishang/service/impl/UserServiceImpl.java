package com.aishang.service.impl;

import com.aishang.mapper.UserMapper;
import com.aishang.po.Category;
import com.aishang.po.CategorySecondExt;
import com.aishang.po.User;
import com.aishang.service.CategorySecondService;
import com.aishang.service.CategoryService;
import com.aishang.service.UserService;
import com.aishang.util.PublicUtil;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userDao;
    @Resource
    private CategoryService categoryService;
    @Resource
    private CategorySecondService categorySecondService;

    public User doLogin(String userName, String passWord) {
        return this.userDao.doLogin(userName, passWord);
    }

    @Override
    public User findUserName(String userName) {
        return this.userDao.findUserName(userName);
    }

    @Override
    public void addUser(User user) {
        userDao.addUser(user);
    }

    //TODO 类目查询操作
    // 返回一级类目列表
    @Override
    public List<Category> findCategoryAll() {
        return categoryService.findAll();
    }

    // 返回二级类目CategorySecondExt列表其中包括该类目下的三级类目
    @Override
    public List<CategorySecondExt> findCategorySecondExtAllByCid(Integer cid) {
        return categorySecondService.findAllByCid(cid);
    }

    // 获取二级类目map<cid,categorySecondList>集合
    @Override
    public Map<Integer, List<CategorySecondExt>> categorySecondMap(List<Category> categoryList) {
        Map<Integer, List<CategorySecondExt>> categorySecondMap = new HashMap<Integer, List<CategorySecondExt>>();
        for (Category category : categoryList) {
            List<CategorySecondExt> categorySecondList = findCategorySecondExtAllByCid(category.getCid());
            System.out.println(category);
            categorySecondMap.put(category.getCid(), categorySecondList);
        }
        return categorySecondMap;
    }

    @Override
    public User updateUser(User user, MultipartFile file, String contextPath) {
        System.out.println(file.getOriginalFilename());
        if(file.getOriginalFilename()!=null&&!"".equals(file.getOriginalFilename().trim())) {
            //如果头像不为空则先删除头像后添加头像
            if (user.getIconPath() != null) {
                System.out.println(contextPath + user.getIconPath());
                PublicUtil.delPic(contextPath + user.getIconPath());
                //上传头像
                String iconPath = PublicUtil.upload(file, contextPath);
                user.setIconPath(iconPath);
            }

        }
        userDao.updateUser(user);
        return user;

    }


}
