package com.aishang.service;

import com.aishang.po.Category;
import com.aishang.po.CategorySecond;
import com.aishang.po.CategorySecondExt;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/18 17:15
 * @Description:
 *          一级类目Service接口
 */

public interface CategorySecondService {

    // 返回一级类目列表的函数
    List<CategorySecondExt> findAllByCid(Integer cid);
}
