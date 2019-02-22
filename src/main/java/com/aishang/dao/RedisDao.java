package com.aishang.dao;

import java.util.Set;

/**
 * @Author: ZGX
 * @Date: 2019/2/21 13:47
 * @Description:
 *          redisDao接口
 *
 */

public interface RedisDao {

    // 取出Redis库中存放的热门商品
    Set<String> get(String key , long start, long stop);

    // 通过Redis存放热门商品
    void set(String key,Double score,String member);

    // 根据商品id获取销量
    Double getScoreByMember(String key ,String member);

}
