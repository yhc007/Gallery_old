package com.gallerytalk.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.context.annotation.Configuration;

/**
 * 레거시 서비스들이 {@link SqlSessionDaoSupport} 를 상속하지만 sqlSessionFactory 가
 * 주입되지 않아(checkDaoConfig 실패) 부팅이 막히는 문제를 해결한다.
 *
 * SqlSessionFactory 를 생성자에서 주입받으면 이 BeanPostProcessor 가 다른 빈보다 너무
 * 일찍 생성되어 순환참조 빈이 raw 상태로 주입되는 부작용이 있다. 따라서 BeanFactoryAware
 * 로 받아 최초 사용 시점에 지연 조회한다.
 */
@Configuration
public class MyBatisDaoSupportConfig implements BeanPostProcessor, BeanFactoryAware {

    private BeanFactory beanFactory;
    private SqlSessionFactory sqlSessionFactory;

    @Override
    public void setBeanFactory(BeanFactory beanFactory) throws BeansException {
        this.beanFactory = beanFactory;
    }

    @Override
    public Object postProcessBeforeInitialization(Object bean, String beanName) {
        if (bean instanceof SqlSessionDaoSupport) {
            if (sqlSessionFactory == null) {
                sqlSessionFactory = beanFactory.getBean(SqlSessionFactory.class);
            }
            ((SqlSessionDaoSupport) bean).setSqlSessionFactory(sqlSessionFactory);
        }
        return bean;
    }
}
