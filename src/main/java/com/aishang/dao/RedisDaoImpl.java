package com.aishang.dao;

import org.springframework.stereotype.Repository;
import redis.clients.jedis.JedisPool;

import javax.annotation.Resource;
import java.util.Set;

/**
 * @Author: ZGX
 * @Date: 2019/2/21 13:50
 * @Description:
 *          RedisDao实现类
 */
@Repository("redisDao")
public class RedisDaoImpl implements RedisDao {

    // 注入Redis连接池
    @Resource
    private JedisPool jedisPool;

    // 得到下表从start到stop的Set列表数据
    @Override
    public Set<String> get(String key , long start, long stop) {
        Set<String> zrange = jedisPool.getResource().zrange(key, start, stop);
        jedisPool.getResource().close();
        return zrange;
    }

    // 向数据中添加销量
    @Override
    public void set(String key, Double score, String member) {
        jedisPool.getResource().zadd(key,score,member);
        jedisPool.getResource().close();
    }

    // 根据商品id获取销量
    @Override
    public Double getScoreByMember(String key ,String member){

        Double zscore = jedisPool.getResource().zscore(key, member);
        jedisPool.getResource().close();
        return zscore;
    }


}
