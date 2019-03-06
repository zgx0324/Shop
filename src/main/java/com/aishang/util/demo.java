package com.aishang.util;





import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Author: ZGX
 * @Date: 2019/2/15 9:53
 * @Description:
 */

public class demo {
    @Test
    public void fun3(){
        System.out.println(new Date().toString());
    }

    @Test
    public void fun1(){
        // 要验证的字符串
        String str = "13734555123";
        boolean rs = Pattern.compile("^1[3-9]\\d{9}$").matcher(str).matches();
        System.out.println(rs);

    }
    @Test
    public void fun2(){
        JedisPool jedisPool = new JedisPool("localhost", 6379);
        Jedis jedis = jedisPool.getResource();
        //存放数据
        jedis.set("hello", "你好啊");
        //获取数据
        String string = jedis.get("hello");
        //输出打印
        System.out.println(string);
        //回收资源
        jedis.close();
        jedisPool.close();
    }
    @Test
    public void testJedisPool() {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring-redis.xml");
        JedisPool pool = (JedisPool) ctx.getBean("jedisPool");
        Jedis jedis = null;
        try {
            jedis = pool.getResource();

            jedis.set("name", "lisi");
            String name = jedis.get("name");
            System.out.println(name);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (jedis != null) {
                // 关闭连接
                jedis.close();
            }
        }
    }
}
