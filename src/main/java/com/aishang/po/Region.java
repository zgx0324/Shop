package com.aishang.po;

/**
 * @Author: ZGX
 * @Date: 2019/2/27 16:40
 * @Description:
 *              全国省市地名实体类
 */

public class Region {
    private Integer id;
    private Integer parentID;
    private String regionName;
    private Integer regionType;

    public Integer getRegionType() {
        return regionType;
    }

    public void setRegionType(Integer regionType) {
        this.regionType = regionType;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getParentID() {
        return parentID;
    }

    public void setParentID(Integer parentID) {
        this.parentID = parentID;
    }

    public String getRegionName() {
        return regionName;
    }

    public void setRegionName(String regionName) {
        this.regionName = regionName;
    }
}
