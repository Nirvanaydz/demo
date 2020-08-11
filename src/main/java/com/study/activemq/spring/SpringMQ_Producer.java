package com.study.activemq.spring;

import org.apache.xbean.spring.context.ClassPathXmlApplicationContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.stereotype.Service;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;
import javax.jms.TextMessage;

@Service
public class SpringMQ_Producer {
    @Autowired
    private JmsTemplate jmsTemplate;

    public static void main(String[] args) {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring-activemq.xml");
        // 被spring扫描到的对象，可以通过此方法，传入类的名称[不区分大小写]，获取类对象
        SpringMQ_Producer producer = (SpringMQ_Producer) ctx.getBean("springMQ_Producer");

        // 传统写法
//        producer.jmsTemplate.send(new MessageCreator() {
//            @Override
//            public Message createMessage(Session session) throws JMSException {
//                TextMessage textMessage = session.createTextMessage("spring和activemq整合！");
//                return textMessage;
//            }
//        });
        // lambda表达式写法
        producer.jmsTemplate.send((session) -> {
            TextMessage textMessage = session.createTextMessage("spring和activemq整合topic--listen！");
            return textMessage;
        });
        System.out.println("send task over--------");
    }
}
