package net.biancheng.schoolbbs.config;


import cn.hutool.extra.spring.SpringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.cache.Cache;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;

import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

@Slf4j
public class MybatisRedisCache implements Cache {

    private final ReadWriteLock readWriteLock = new ReentrantReadWriteLock();
    private final String id;
    private RedisTemplate<String, Object> redisTemplate;

    // 缓存过期时间（分钟），可根据业务调整
    private static final long EXPIRE_TIME_IN_MINUTES = 30;

    public MybatisRedisCache(String id) {
        if (id == null) {
            throw new IllegalArgumentException("Cache instances require an ID");
        }
        this.id = id;
    }

    @Override
    public String getId() {
        return this.id;
    }

    @Override
    public void putObject(Object key, Object value) {
        getRedisTemplate().opsForHash().put(getId(), key.toString(), value);
        log.debug("Put query result to redis: key={}", key);
    }

    @Override
    public Object getObject(Object key) {
        log.debug("Get cached query result from redis: key={}", key);
        return getRedisTemplate().opsForHash().get(getId(), key.toString());
    }

    @Override
    public Object removeObject(Object key) {
        log.debug("Remove cached query result from redis: key={}", key);
        return getRedisTemplate().opsForHash().delete(getId(), key.toString());
    }

    @Override
    public void clear() {
        log.debug("Clear all cached query results from redis for namespace: {}", getId());
        getRedisTemplate().delete(getId());
    }

    @Override
    public int getSize() {
        Long size = getRedisTemplate().opsForHash().size(getId());
        return size == null ? 0 : size.intValue();
    }

    @Override
    public ReadWriteLock getReadWriteLock() {
        return readWriteLock;
    }

    private RedisTemplate<String, Object> getRedisTemplate() {
        if (redisTemplate == null) {
            // 从 Spring 容器中获取 RedisTemplate
            redisTemplate = SpringUtil.getBean("redisTemplate");
        }
        return redisTemplate;
    }
}