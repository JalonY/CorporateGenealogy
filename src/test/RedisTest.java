import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * @author: zsl
 * @date: 2018/6/26
 */
public class RedisTest {
    public static final String HELLO = "Hello";
    static final String redisHost = "39.108.71.221";
    static final String redisPassword = "123456";
    static final int redisPort = 6379;

    @Before
    public void before() {

    }

    @After
    public void after() {

    }

    // ping连接测试
    @Test
    public void pingTest() {
        Jedis jedis = new Jedis(redisHost);
        jedis.auth(redisPassword);
        System.out.println("服务正在运行：" + jedis.ping());
        jedis.close();
    }

    // 添加String数据
    @Test
    public void setString() {
        Jedis jedis = new Jedis(redisHost);
        jedis.auth(redisPassword);
        String key = "Hello";
        String value = "World";
        String result = jedis.set(key, value);
        System.out.println("存储结果：" + result + "，存储的字符串为：" + jedis.get(key));
        jedis.close();
    }

    // 删除String数据
    @Test
    public void delString() {
        Jedis jedis = new Jedis(redisHost);
        jedis.auth(redisPassword);
        String key = "Hello";
        Long result = jedis.del(key);
        System.out.println("删除结果：" + result);
        jedis.close();
    }


    // 增加Hash
    @Test
    public void setHash() {
        Jedis jedis = new Jedis(redisHost);
        jedis.auth(redisPassword);
        String hash = "HASH_NAME";
        String key = "key_";
        String value = "value_";
        for (int i = 0; i < 10; i++) {
            Long result = jedis.hset(hash, key + i, value + i);
            System.out.println("执行结果：" + result);
        }
        jedis.close();
    }

    // 删除Hash
    @Test
    public void delHash() {
        Jedis jedis = new Jedis(redisHost);
        jedis.auth(redisPassword);
        String hash = "HASH_NAME";
        String key = "key_";
        for (int i = 0; i < 10; i++) {
            Long result = jedis.hdel(hash, key + i);
            System.out.println("执行结果：" + result);
        }
        jedis.close();
    }

    // 增加List
    // 无序，允许重复
    @Test
    public void setList() {
        Jedis jedis = new Jedis(redisHost);
        jedis.auth(redisPassword);
        String key = "Company";
        jedis.lpush(key, "Google");
        jedis.lpush(key, "Google"); // List可重复
        jedis.lpush(key, "Apple");
        jedis.lpush(key, "Twitter");
        // 获取存储的数据并输出
        List<String> list = jedis.lrange(key, 0, 3);
        for (int i = 0; i < list.size(); i++) {
            System.out.println("列表项为：" + list.get(i));
        }
        jedis.close();
    }

    // 删除List
    @Test
    public void delList() {
        Jedis jedis = new Jedis(redisHost);
        jedis.auth(redisPassword);
        String key = "Company";
        // 第二个参数为删除的个数（有重复时），后add进去的值先被删，类似于出栈
        Long aLong = jedis.lrem(key, 2, "Google");
        System.out.println("执行结果：" + aLong);
        jedis.close();
    }

    // 增加Set
    // 无序，不允许重复
    @Test
    public void addSet() {
        Jedis jedis = new Jedis(redisHost);
        jedis.auth(redisPassword);
        String key = "setKeyName";
        jedis.sadd(key, "member1");
        jedis.sadd(key, "member1"); // Set不允许重复
        jedis.sadd(key, "member2");
        System.out.println("列表项为：" + jedis.smembers(key));
        jedis.close();
    }

    // 删除Set
    @Test
    public void remSet() {
        Jedis jedis = new Jedis(redisHost);
        jedis.auth(redisPassword);
        String key = "setKeyName";
        Long aLong = jedis.srem(key, "member1"); //删除元素memeber1
        System.out.println("执行结果：" + aLong);
        jedis.close();
    }

    // 增加Sorted Set
    // 有序，不允许重复
    @Test
    public void addSortedSet() {
        Jedis jedis = new Jedis(redisHost);
        jedis.auth(redisPassword);
        String key = "sortedSetKeyName";
        // 第三项member不允许重复，但是第二项score允许重复
        // 第二项score为排序的依据，第三项member重复时，以最后添加score的为准
        jedis.zadd(key, 1, "C++");
        jedis.zadd(key, 3, "Java");
        jedis.zadd(key, 1, "Java");
        jedis.zadd(key, 4, "Java");
        jedis.zadd(key, 2, "Python");
        jedis.zadd(key, 2, "Go");
        Set<String> set = jedis.zrange(key, 0, 5);
        for (String x : set) {
            System.out.println(x);
        }
        jedis.close();
    }

    // 删除Sorted Set
    @Test
    public void remSortedSet() {
        Jedis jedis = new Jedis(redisHost);
        jedis.auth(redisPassword);
        String key = "sortedSetKeyName";
        Long aLong = jedis.zrem(key, "C++");
        System.out.println("执行结果：" + aLong);
        jedis.close();
    }

    // 获取所有的key
    @Test
    public void redisGetKey() {
        Jedis jedis = new Jedis(redisHost);
        jedis.auth(redisPassword);
        // 获取数据并输出
        Set<String> keys = jedis.keys("*");
        Iterator<String> it = keys.iterator();
        while (it.hasNext()) {
            String key = it.next();
            System.out.println(key);
        }
        jedis.close();
    }

    @Test
    public void testJedisPool() {
        JedisPool pool = new JedisPool(redisHost, redisPort);
        Jedis jedis = pool.getResource();
        jedis.auth(redisPassword);
        String string = jedis.get("runoobkey");
        System.out.println(string);
        jedis.close();
    }

    @Test
    public void testSpringJedis() {
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("classpath:spring/spring-jedis.xml");
        JedisPool pool = (JedisPool) applicationContext.getBean("redisClient");
        Jedis jedis = pool.getResource();
        jedis.auth(redisPassword);
        String string = jedis.get("runoobkey");
        System.out.println(string);
        jedis.close();
        pool.close();
    }

    private static String pageHkey = "PAGEINFO_JSON_REDIS_LIST";// 这个名字随意
    private static String pageKey = "";// 以pageNum为区分

    @Test
    public void testJedisPoolDel() {
        JedisPool pool = new JedisPool(redisHost, redisPort);
        Jedis jedis = pool.getResource();
        jedis.auth(redisPassword);
//        Long aLong = jedis.del("runoobkey");
        Long aLong = jedis.hdel(pageHkey, "pageNum_2");
        System.out.println(aLong);
        jedis.close();
    }
}
