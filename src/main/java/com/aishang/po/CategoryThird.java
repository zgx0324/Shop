package com.aishang.po;

/**
 * @Author: ZGX
 * @Date: 2019/2/18 17:05
 * @Description:
 *              三级类目
 */

public class CategoryThird {
    Integer ctid;
    String ctname;
    Integer csid;
    Integer state;

    @Override
    public String toString() {
        return "CategoryThird{" +
                "ctid=" + ctid +
                ", ctname='" + ctname + '\'' +
                ", csid=" + csid +
                ", state=" + state +
                '}';
    }

    public Integer getCtid() {
        return ctid;
    }

    public void setCtid(Integer ctid) {
        this.ctid = ctid;
    }

    public String getCtname() {
        return ctname;
    }

    public void setCtname(String ctname) {
        this.ctname = ctname;
    }

    public Integer getCsid() {
        return csid;
    }

    public void setCsid(Integer csid) {
        this.csid = csid;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }
}
