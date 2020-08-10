package com.study.activemq.basic.queue;

import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;

public class JmsProducer {
    public static final String ACTIVEMQ_URL = "tcp://122.51.78.20:61616";
    public static final String QUEUE_NAME = "QUEUE02";
    public static void main(String[] args) throws JMSException {
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
        Queue queue = session.createQueue(QUEUE_NAME);
        // 5.create JMS producer
        MessageProducer producer = session.createProducer(queue);
        // 6.create three messages send to the queue
        for (int i = 1; i <= 6; i++) {
            // 7.create message
            TextMessage textMessage = session.createTextMessage("msg---" + i);
            // 8.send message by Producer
            producer.send(textMessage);
        }
        // 9.close
        producer.close();
        session.close();
        connection.close();

        System.out.println("***message send success!!!***");
    }
}
