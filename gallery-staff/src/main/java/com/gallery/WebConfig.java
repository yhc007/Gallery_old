package com.gallery;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Bean
    public TilesConfigurer tilesConfigurer() {
        final var configurer = new TilesConfigurer();
        configurer.setDefinitions("/WEB-INF/views/layout/layouts.xml");
        return configurer;
    }

    @Bean
    public TilesViewResolver tilesViewResolver() {
        final var resolver = new TilesViewResolver();
        resolver.setViewClass(TilesView.class);
        resolver.setOrder(Ordered.HIGHEST_PRECEDENCE);
        return resolver;
    }
}
