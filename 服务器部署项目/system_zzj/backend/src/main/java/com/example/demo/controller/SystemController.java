package com.example.demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * 系统状态接口，顺便验证 Redis 是否可用
 */
@RestController
@RequestMapping("/api")
public class SystemController {

    private static final Logger log = LoggerFactory.getLogger(SystemController.class);

    private final StringRedisTemplate stringRedisTemplate;

    public SystemController(StringRedisTemplate stringRedisTemplate) {
        this.stringRedisTemplate = stringRedisTemplate;
    }

    @GetMapping("/ping")
    public Map<String, Object> ping() {
        Map<String, Object> result = new HashMap<>();
        result.put("status", "UP");
        result.put("serverTime", LocalDateTime.now().toString());

        // 每次访问都把 Redis 里的计数 +1，同时验证 Redis 连接
        boolean redisOk = true;
        Long visits = null;
        try {
            visits = stringRedisTemplate.opsForValue().increment("site:visits");
        } catch (Exception e) {
            redisOk = false;
            log.warn("Redis 连接失败（{}），应用继续运行，但访问计数不可用", e.getMessage());
        }
        result.put("redisOk", redisOk);
        result.put("visits", visits);
        return result;
    }
}
