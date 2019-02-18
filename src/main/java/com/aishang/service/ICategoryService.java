package com.aishang.service;

import com.aishang.po.Category;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/18 17:15
 * @Description:
 *          一级类目Service接口
 */

public interface ICategoryService  {

    // 返回一级类目列表的函数
    public List<Category> findAll();
}
