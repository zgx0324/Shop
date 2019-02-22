package com.aishang.service;

import com.aishang.po.Category;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/18 17:15
 * @Description:
 *          一级类目Service接口
 */

public interface CategoryService {

    // 返回一级类目列表的函数
    List<Category> findAll();
}
