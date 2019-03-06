package com.aishang.dao;

import com.aishang.po.OrderItem;
import com.aishang.util.JsonUtils;
import org.springframework.stereotype.Repository;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import javax.annotation.Resource;
import java.util.List;
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
        Jedis jedis = jedisPool.getResource();
        Set<String> zrange = jedis.zrange(key, start, stop);
        jedis.close();
        return zrange;
    }

    // 向数据中添加销量
    @Override
    public void set(String key, Double score, String member) {
        Jedis jedis = jedisPool.getResource();
        jedis.zadd(key,score,member);
        jedis.close();
    }

    // 根据商品id获取销量
    @Override
    public Double getScoreByMember(String key ,String member){
        Jedis jedis = jedisPool.getResource();
        Double zscore = jedis.zscore(key, member);
        jedis.close();
        return zscore;
    }
    //删除指定key的数据
    @Override
    public void del(String string) {
        Jedis jedis = jedisPool.getResource();
        jedis.del(string);
        jedis.close();
    }

    //TODO 购物车操作
    //添加订单项至购物车
    @Override
    public void addBasket(String key, String value) {
        Jedis jedis = jedisPool.getResource();
        jedis.set(key, value);
        jedis.close();
    }

    //得到某用户的购物车
    @Override
    public String getBasket(String key) {
        Jedis jedis = jedisPool.getResource();
        String s = jedis.get(key);
        jedis.close();
        return s;
    }
    //判断是否存在key
    @Override
    public boolean existsKeys(String string) {
        Jedis jedis = jedisPool.getResource();
        Boolean exists = jedis.exists(string);
        jedis.close();
        return exists;
    }


}
