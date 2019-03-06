package com.aishang.service.impl;

import com.aishang.mapper.RegionMapper;
import com.aishang.po.Region;
import com.aishang.service.RegionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author: ZGX
 * @Date: 2019/2/28 9:17
 * @Description:
 */
@Service
public class RegionServiceImpl implements RegionService {
    //TODO 注入参数
    @Resource
    private RegionMapper regionMapper;

    // 根据省份ID获取该省下属城市
    @Override
    public List<Region> getCityByProvinceID(Integer id) {
        return regionMapper.getCityByProvinceID(id);
    }
}
