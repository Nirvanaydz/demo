package com.study.activemq.basic.topic;

import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;
import java.io.IOException;

/**
 * 同步收发，存在receive中等待参数的设置
 * */
public class JmsConsumer02_topic {
    // ?wireFormat.maxInactivityDuration=0
    public static final String ACTIVEMQ_URL = "tcp://122.51.78.20:61616";
    public static final String TOPIC_NAME = "topic-demo";
    public static void main(String[] args) throws JMSException, IOException {
//        Logger logger = LoggerFactory.getLogger(JmsConsumer.class);
        // 1.create connectionFactory,注意源码中的创建工厂的参数定义，现阶段使用默认值
        ActiveMQConnectionFactory activeMQConnectionFactory = new ActiveMQConnectionFactory(ACTIVEMQ_URL);
        // 2.get connection by connectionFactory and start the connection
        Connection connection = activeMQConnectionFactory.createConnection();
        connection.start();// important
        // 3.create session(事务，签收),default value(false,Session.AUTO_ACKNOWLEDGE)
        //          key params [boolean transacted,int acknowledgeMode]
        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
        // 4.create destination by session object : session.createQueue(queue_name);
        //        session.createTopic(topic_name);
        //        Destination queue = session.createQueue(QUEUE_NAME);
        Topic topic = session.createTopic(TOPIC_NAME);
        // 5.create consumer by queue
        MessageConsumer consumer = session.createConsumer(topic);
        System.out.println("我是jms消费者2号");
        // 接口只有一个方法时使用 lambdas 表达式，若入参只有一个可以省略参数类型
//        consumer.setMessageListener((message) -> {
        consumer.setMessageListener((Message message) -> {
            if ( null != message & message instanceof TextMessage ) {
                TextMessage textMessage = (TextMessage) message;
                try {
                    System.out.println("***consumer get the message is : ***" + textMessage.getText());
                } catch (JMSException e) {
                    e.printStackTrace();
                }
            }
        });
        System.in.read();
        // 7.close
        consumer.close();
        session.close();
        connection.close();

        System.out.println("***message receive success!!!***");
    }
}
