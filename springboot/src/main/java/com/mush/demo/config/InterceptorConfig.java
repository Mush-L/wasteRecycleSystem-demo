package com.mush.demo.config;

import com.mush.demo.config.interceptor.JwtInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 拦截器
 */
@Configuration
public class InterceptorConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(jwtInterceptor())
                // 拦截所有请求，通过判断token是否合法来决定是否需要登录
                .addPathPatterns("/**")
                // 排除规则
                .excludePathPatterns("/**/login", "/**/register", "/**/export", "/**/import", "/file/**");
    }

    // 将对象注入，注册到容器中，否则直接 new 无法注入。
    @Bean
    public JwtInterceptor jwtInterceptor() {
        return new JwtInterceptor();
    }

}
