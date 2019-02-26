package com.aishang.po;

import org.apache.ibatis.type.Alias;

/**
 * @Author: ZGX
 * @Date: 2019/2/24 13:35
 * @Description:
 *          商品复合查询扩展类
 */

public class ProductBean extends Pagebean {
    Integer selectCid;
    Integer selectCsid;
    Integer selectCtid;
    String selectpName;
    Integer selectpDesc;
    Double selectMinPrice;
    Double selectMaxPrice;

    public Double getSelectMinPrice() {
        return selectMinPrice;
    }

    public void setSelectMinPrice(Double selectMinPrice) {
        this.selectMinPrice = selectMinPrice;
    }

    public Double getSelectMaxPrice() {
        return selectMaxPrice;
    }

    public void setSelectMaxPrice(Double selectMaxPrice) {
        this.selectMaxPrice = selectMaxPrice;
    }

    public Integer getSelectpDesc() {
        return selectpDesc;
    }

    public void setSelectpDesc(Integer selectpDesc) {
        this.selectpDesc = selectpDesc;
    }

    public String getSelectpName() {
        return selectpName;
    }

    public void setSelectpName(String selectpName) {
        this.selectpName = selectpName;
    }

    public Integer getSelectCsid() {
        return selectCsid;
    }

    public void setSelectCsid(Integer selectCsid) {
        this.selectCsid = selectCsid;
    }

    public Integer getSelectCid() {
        return selectCid;
    }

    public void setSelectCid(Integer selectCid) {
        this.selectCid = selectCid;
    }

    public Integer getSelectCtid() {
        return selectCtid;
    }

    public void setSelectCtid(Integer selectCtid) {
        this.selectCtid = selectCtid;
    }
}
