package com.example.demo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 开发环境跨域配置。
 *
 * 本地开发时前端跑在 http://localhost:5173，后端在 http://localhost:8080，
 * 浏览器直接请求后端属于跨域，需要放开。
 *
 * 部署后由 Nginx 把 /api 反向代理到后端，前后端同源，这段配置就用不上了
 * （学习时留着无妨）。
 */
@Configuration
public class CorsConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
                .allowedOriginPatterns("*")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .maxAge(3600);
    }
}
