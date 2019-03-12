package com.aishang.service;

import com.aishang.po.Category;
import com.aishang.po.CategorySecondExt;
import com.aishang.po.User;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface UserService {
    User doLogin(String userName,String passWord);

    User findUserName(String userName);

    void addUser(User user);

    // TODO 类目查询
    // 返回一级类目列表的函数
    List<Category> findCategoryAll();

    // 返回二级类目列表扩展类的函数
    List<CategorySecondExt> findCategorySecondExtAllByCid(Integer cid);

    // 获取二级类目map<cid,categorySecondList>集合
    Map<Integer, List<CategorySecondExt>> categorySecondMap(List<Category> categoryList);
    //修改个人信息
    User updateUser(User user, MultipartFile file, String contextPath);
}
