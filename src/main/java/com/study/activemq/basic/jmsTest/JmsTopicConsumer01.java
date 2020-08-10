package com.study.activemq.basic.jmsTest;

import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;

/**
 * 1、一定先运行一次设置了clientID的消费者，等于向MQ注册了，类似我订阅了这个主题
 * 2、然后再运行生产者发送消息，此时
 * 3、无论消费者是否在线，都会接收到，不在线的话，下次连接的时候，会把没有接受过的消息都接收下来
 * */
public class JmsTopicConsumer01 {
    public static final String ACTIVEMQ_URL = "tcp://122.51.78.20:61616";
    public static final String TOPIC_NAME = "jms-topic-test";
    public static void main(String[] args) throws JMSException {
        System.out.println("我是jms消费者1号");

        ActiveMQConnectionFactory activeMQConnectionFactory = new ActiveMQConnectionFactory(ACTIVEMQ_URL);

        Connection connection = activeMQConnectionFactory.createConnection();
        // You cannot create a durable subscriber without specifying a unique clientID on a Connection
        connection.setClientID("z3");//设置clientID

        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        Topic topic = session.createTopic(TOPIC_NAME);
        // 持久化
        TopicSubscriber topicSubscriber = session.createDurableSubscriber(topic,"remark...");
        connection.start();//启动connection

        Message message = topicSubscriber.receive();
        while (null != message) {
            TextMessage textMessage = (TextMessage) message;
            System.out.println("收到持久化的消息为---" + textMessage.getText());
            message = topicSubscriber.receive();
        }


        session.close();
        connection.close();

        System.out.println("***message receive success!!!***");
    }
}
