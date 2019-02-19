package com.aishang.mapper;

import com.aishang.po.Category;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/19 8:49
 * @Description:
 *              一级类目mapper
 */

public interface CategoryMapper {

    //返回一级类目列表
     List<Category> findAll();
}
