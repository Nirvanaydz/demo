package com.study.activemq.basic.jmsTest;

import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;

/**
 * 异步收发
 * */
public class JmsQueueConsumer {
    public static final String ACTIVEMQ_URL = "tcp://122.51.78.20:61616";
    public static final String QUEUE_NAME = "jms-test";
    public static void main(String[] args) throws JMSException {
        ActiveMQConnectionFactory activeMQConnectionFactory = new ActiveMQConnectionFactory(ACTIVEMQ_URL);

        Connection connection = activeMQConnectionFactory.createConnection();
        connection.start();// important

        Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);// 3.create session(事务，签收),
        Queue queue = session.createQueue(QUEUE_NAME);

        MessageConsumer consumer = session.createConsumer(queue);// 5.create consumer by queue
        while (true) {
            TextMessage receive = (TextMessage) consumer.receive();// 6.receive message
            if (null != receive) {
                System.out.println("***consumer get the message is : ***" + receive.getText());
            } else {
                break;
            }
        }
        // 7.close
        consumer.close();
        session.close();
        connection.close();

        System.out.println("***message receive success!!!***");
    }
}
