package com.study.activemq.basic.jmsTest;

import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;

/**
 *
 * */
public class JmsQueueTransactionConsumer {
    public static final String ACTIVEMQ_URL = "tcp://122.51.78.20:61616";
    public static final String QUEUE_NAME = "jms-Transaction-test";
    public static void main(String[] args) throws JMSException {
        ActiveMQConnectionFactory activeMQConnectionFactory = new ActiveMQConnectionFactory(ACTIVEMQ_URL);

        Connection connection = activeMQConnectionFactory.createConnection();
        connection.start();// important


//        static final int AUTO_ACKNOWLEDGE = 1; 默认
//        Session session = connection.createSession(true, Session.AUTO_ACKNOWLEDGE);
//        static final int CLIENT_ACKNOWLEDGE = 2; 手动签收，需要在消息消费后调用acknowledge方法，避免重复消费
        Session session = connection.createSession(false, Session.CLIENT_ACKNOWLEDGE);
//        static final int DUPS_OK_ACKNOWLEDGE = 3; 允许重复签收
//        static final int SESSION_TRANSACTED = 0;
        Queue queue = session.createQueue(QUEUE_NAME);

        MessageConsumer consumer = session.createConsumer(queue);// 5.create consumer by queue
        while (true) {
            TextMessage receive = (TextMessage) consumer.receive(4000);// 6.receive message
            if (null != receive) {
                System.out.println("***consumer get the message is : ***" + receive.getText());
                receive.acknowledge();
            } else {
                break;
            }
        }
        // 7.close
        consumer.close();
//        session.commit();//若开启了事务，没有提交，则会出现很严重的重复消费！！！！
        session.close();
        connection.close();

        System.out.println("***message receive success!!!***");
    }
}
