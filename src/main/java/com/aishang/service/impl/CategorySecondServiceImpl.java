package com.aishang.service.impl;

import com.aishang.mapper.CategorySecondMapper;
import com.aishang.po.CategorySecond;
import com.aishang.po.CategorySecondExt;
import com.aishang.service.ICategorySecondService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/18 17:22
 * @Description:
 *      二级类目Service层（ICategoryService接口）实现类
 */
@Service("categorySecondService")
public class CategorySecondServiceImpl implements ICategorySecondService {

    @Resource
    private CategorySecondMapper categorySecondMapper;

    // 返回二级类目列表集合
    @Override
    public List<CategorySecondExt> findAllByCid(Integer cid) {

        List<CategorySecondExt> categoryList = categorySecondMapper.findAllByCid(cid);

        return categoryList;
    }


}
