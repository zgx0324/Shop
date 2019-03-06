package com.aishang.mapper;

import com.aishang.po.Region;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/27 16:34
 * @Description:
 *              全国省市数据表的Mapper
 */

public interface RegionMapper {

    //获得全国所有省份集合
    List<Region> getAllProvince();

    // 根据省份ID获取该省下属城市
    List<Region> getCityByProvinceID(Integer id);
}
