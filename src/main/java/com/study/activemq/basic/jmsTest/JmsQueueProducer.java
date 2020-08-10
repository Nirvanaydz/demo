package com.study.activemq.basic.jmsTest;

import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;
/**
 * 队列默认是持久化的PERSISTENT
 * */
public class JmsQueueProducer {
    public static final String ACTIVEMQ_URL = "tcp://122.51.78.20:61616";
    public static final String QUEUE_NAME = "jms-test";
    public static void main(String[] args) throws JMSException {
        ActiveMQConnectionFactory activeMQConnectionFactory = new ActiveMQConnectionFactory(ACTIVEMQ_URL);

        Connection connection = activeMQConnectionFactory.createConnection();
        connection.start();// important

        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        Queue queue = session.createQueue(QUEUE_NAME);// 5.create JMS producer

        MessageProducer producer = session.createProducer(queue);
        // 服务器宕机是否保存未被消费的消息
        producer.setDeliveryMode(DeliveryMode.PERSISTENT);//持久化
        // 宕机前      宕机后重启后     重启并消费后
        // 6-0-6-0-->   6-0-0-0-->     0-1-0-6
//        producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);//非持久化


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
