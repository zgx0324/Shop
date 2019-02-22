package com.aishang.service.impl;

import com.aishang.mapper.CategoryMapper;
import com.aishang.po.Category;
import com.aishang.service.CategoryService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/18 17:22
 * @Description:
 *      一级类目Service层（ICategoryService接口）实现类
 */
@Service("categoryService")
public class CategoryServiceImpl implements CategoryService {

    @Resource
    private CategoryMapper categoryMapper;

    // 返回一级类目列表集合
    @Override
    public List<Category> findAll() {

        List<Category> categoryList = categoryMapper.findAll();

        return categoryList;
    }
}
