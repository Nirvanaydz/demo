package com.study.jvm.databases.redis;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class JedisPoolUtil {

    private static volatile JedisPool jedisPool = null;

    private JedisPoolUtil(){}

    public static JedisPool getJedisPoolInstance(){
        if (null == jedisPool){
            synchronized (JedisPoolUtil.class){
                if (null == jedisPool){
                    JedisPoolConfig poolConfig = new JedisPoolConfig();

                    poolConfig.setMaxIdle(32);
                    poolConfig.setMaxWaitMillis(100*1000);
                    poolConfig.setTestOnBorrow(true);
                    jedisPool = new JedisPool(poolConfig,"122.51.78.20",6379);
                }
            }
        }
        return jedisPool;
    }

    // release，释放连接
//    public static void release(JedisPool jedisPool, Jedis jedis){
//        if (null != jedis){
//            jedisPool.returnResource()
//        }
//    }

}
