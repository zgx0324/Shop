package com.aishang.mapper;

import com.aishang.po.Category;
import com.aishang.po.CategorySecond;
import com.aishang.po.CategorySecondExt;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/19 8:49
 * @Description:
 *              一级类目mapper
 */

public interface CategorySecondMapper {

    //返回一级类目列表
     List<CategorySecondExt> findAllByCid(Integer cid);
}
