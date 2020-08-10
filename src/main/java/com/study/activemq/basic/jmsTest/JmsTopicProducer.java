package com.study.activemq.basic.jmsTest;

import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;

/**
 * 发布订阅TOPIC默认是非持久化的NON_PERSISTENT
 * */
public class JmsTopicProducer {
    public static final String ACTIVEMQ_URL = "tcp://122.51.78.20:61616";
    public static final String TOPIC_NAME = "jms-topic-test";
    public static void main(String[] args) throws JMSException {
        ActiveMQConnectionFactory activeMQConnectionFactory = new ActiveMQConnectionFactory(ACTIVEMQ_URL);

        Connection connection = activeMQConnectionFactory.createConnection();

        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        Topic topic = session.createTopic(TOPIC_NAME);

        MessageProducer producer = session.createProducer(topic);// 5.create JMS producer
        // 服务器宕机是否保存未被消费的消息
        producer.setDeliveryMode(DeliveryMode.PERSISTENT);

        connection.start();// important启动一个持久化的主题，需要将connection的开启方法置后

        for (int i = 1; i <= 6; i++) {// 6.create messages send to the queue
            TextMessage textMessage = session.createTextMessage("msg---" + i);// 7.create message
            producer.send(textMessage);// 8.send message by Producer
        }
        // 9.close
        producer.close();
        session.close();
        connection.close();

        System.out.println("***message send success!!!***");
    }
}
