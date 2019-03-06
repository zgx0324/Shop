package com.aishang.service;

import com.aishang.po.Region;

import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/28 9:14
 * @Description: 省市联动地名service
 */

public interface RegionService {
    //根据省份ID获取该省下属城市
    List<Region> getCityByProvinceID(Integer id);

}
