package com.aishang.po;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/19 11:34
 * @Description:
 *              二级类目扩展类，包含三级类目集合
 */

public class CategorySecondExt extends CategorySecond {

    List<CategoryThird> categoryThirdList;

    public List<CategoryThird> getCategoryThirdList() {
        return categoryThirdList;
    }

    public void setCategoryThirdList(List<CategoryThird> categoryThirdList) {
        this.categoryThirdList = categoryThirdList;
    }
}
