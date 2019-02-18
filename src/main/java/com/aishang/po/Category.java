package com.aishang.po;

/**
 * @Author: ZGX
 * @Date: 2019/2/18 14:46
 * @Description:
 *              一级类目实体类
 */

public class Category {
    Integer cid;
    String cname;
    Integer state;

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "Category{" +
                "cid=" + cid +
                ", cname='" + cname + '\'' +
                ", state=" + state +
                '}';
    }
}
