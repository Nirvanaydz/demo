package com.study.jvm.databases.redis;


import redis.clients.jedis.Jedis;
import redis.clients.jedis.Transaction;

import java.util.Set;

/**
 * redis测试连接类
 * */
public class RedisTest {
    public static void main(String[] args) {
        // https://www.cnblogs.com/bincoding/p/6164569.html
        new RedisTest().testTransaction();
    }
    // 获取jedis客户端对象
    private static Jedis getJedis(int port){
        Jedis jedis = null;
        try {
            jedis = new Jedis("122.51.78.20",port);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jedis;
    }
    // 基本数据操作 5+1 自行实验
    private void testTransaction(){
        Jedis jedis = getJedis(6379);
        jedis.auth("123");

        // 事务
        Transaction transaction = jedis.multi();
        transaction.set("k44","v44");
        transaction.set("k55","v55");

        transaction.discard();
//        transaction.exec();
        jedis.close();
    }

    // 模拟watch，unwatch
    // 模拟主从复制
    public void testSlaveOf(){
        Jedis jedis_M = getJedis(6379);
        Jedis jedis_S = getJedis(6380);
        jedis_S.slaveof("122.51.78.20",6379);
        jedis_M.set("k1","v1");
        String result  = jedis_S.get("k1");
        System.out.println(result);
    }

    // jedis连接池和单例模式
    public void testPools(){

    }
}
