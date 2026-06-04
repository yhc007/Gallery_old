package com.gallerytalk;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * gallery-talk(모바일)은 Apache Tiles 레이아웃(layouts.xml)이 없으므로 TilesConfigurer 를
 * 두지 않는다. 뷰는 application.yml 의 spring.mvc.view.prefix/suffix(/WEB-INF/views/*.jsp)
 * 기본 InternalResourceViewResolver 로 해석된다.
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {
}
