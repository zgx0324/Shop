package com.aishang.po;

/**
 * @Author: ZGX
 * @Date: 2019/2/18 15:07
 * @Description:
 *              二级类目实体类
 */

public class CategorySecond {

    Integer csid;
    String csname;
    Integer cid;
    Integer state;

    public Integer getCsid() {
        return csid;
    }

    public void setCsid(Integer csid) {
        this.csid = csid;
    }

    public String getCsname() {
        return csname;
    }

    public void setCsname(String csname) {
        this.csname = csname;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "CategorySecond{" +
                "csid=" + csid +
                ", csname='" + csname + '\'' +
                ", cid=" + cid +
                ", state=" + state +
                '}';
    }
}
