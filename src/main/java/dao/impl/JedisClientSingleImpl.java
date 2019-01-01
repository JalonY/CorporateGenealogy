package dao.impl;

import dao.JedisClient;
import org.springframework.beans.factory.annotation.Autowired;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * @author: zsl
 * @date: 2018/6/26
 */
public class JedisClientSingleImpl implements JedisClient {

    @Autowired
    private JedisPool jedisPool;

    private static String password = "123456";

    @Override
    public String get(String key) {
        Jedis jedis = jedisPool.getResource();
        jedis.auth(password);
        String string = jedis.get(key);
        jedis.close();
        return string;
    }

    @Override
    public String set(String key, String value) {
        Jedis jedis = jedisPool.getResource();
        jedis.auth(password);
        String string = jedis.set(key, value);
        jedis.close();
        return string;
    }

    @Override
    public String hget(String hkey, String key) {
        Jedis jedis = jedisPool.getResource();
        jedis.auth(password);
        String string = jedis.hget(hkey, key);
        jedis.close();
        return string;
    }

    @Override
    public long hset(String hkey, String key, String value) {
        Jedis jedis = jedisPool.getResource();
        jedis.auth(password);
        Long result = jedis.hset(hkey, key, value);
        jedis.close();
        return result;
    }

    @Override
    public long incr(String key) {
        Jedis jedis = jedisPool.getResource();
        jedis.auth(password);
        long result = jedis.incr(key);
        jedis.close();
        return result;
    }

    @Override
    public long expire(String key, int second) {
        Jedis jedis = jedisPool.getResource();
        jedis.auth(password);
        Long result = jedis.expire(key, second);
        jedis.close();
        return result;
    }

    @Override
    public long ttl(String key) {
        Jedis jedis = jedisPool.getResource();
        jedis.auth(password);
        Long result = jedis.ttl(key);
        jedis.close();
        return result;
    }

    @Override
    public long hdel(String hkey, String key) {
        Jedis jedis = jedisPool.getResource();
        jedis.auth(password);
        Long result = jedis.hdel(hkey, key);// 1为成功，0为失败
        return result;
    }

}
