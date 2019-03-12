package com.aishang.po;

/**
 * @Author: ZGX
 * @Date: 2019/2/24 14:40
 * @Description:
 *              分页实体类
 */

public class Pagebean {
    private Integer pageNow=1;
    private Integer pageSize=12;
    private Integer pageCount;
    private Integer totalCount;

    public Integer getPageNow() {
        if(pageNow<=0){
            pageNow=1;
        }
        return pageNow;
    }

    public void setPageNow(Integer pageNow) {
        this.pageNow = pageNow;
    }

    public Integer getPageSize() {
        return pageSize;
    }
    public void setPageSize(Integer pageSize){ this.pageSize=pageSize;}

    public Integer getPageCount() {
        return pageCount;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
        // 计算pageCount
        if(totalCount%pageSize==0){
            pageCount = totalCount/pageSize;
        }else {
            pageCount = totalCount/pageSize+1;
        }
        // 检查pageNow
        if(pageNow<=0){
            pageNow=1;
        }
        if (pageCount<pageNow){
            pageNow=pageCount;
        }
    }

    public Integer getStartIndex(){
        return (getPageNow()-1)*pageSize;
    }
}
