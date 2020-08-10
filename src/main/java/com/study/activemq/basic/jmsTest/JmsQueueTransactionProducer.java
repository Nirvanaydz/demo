package com.study.activemq.basic.jmsTest;

import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;

/**
 * 队列默认是持久化的PERSISTENT
 * */
public class JmsQueueTransactionProducer {
    public static final String ACTIVEMQ_URL = "tcp://122.51.78.20:61616";
    public static final String QUEUE_NAME = "jms-Transaction-test";
    public static void main(String[] args) throws JMSException {
        ActiveMQConnectionFactory activeMQConnectionFactory = new ActiveMQConnectionFactory(ACTIVEMQ_URL);

        Connection connection = activeMQConnectionFactory.createConnection();
        connection.start();// important

        Session session = connection.createSession(true, Session.AUTO_ACKNOWLEDGE);

        Queue queue = session.createQueue(QUEUE_NAME);// 5.create JMS producer

        MessageProducer producer = session.createProducer(queue);


        for (int i = 1; i <= 6; i++) {// 6.create messages send to the queue
            TextMessage textMessage = session.createTextMessage("msg---" + i);// 7.create message
            producer.send(textMessage);// 8.send message by Producer
        }
        // 9.close
        producer.close();
        session.commit();//开启事务的话需要在事务关闭前，消息发送后进行commit提交操作，否则队列中将没有消息
        session.close();
        /**
         * 事务的好处，失败可以回滚
        * try {
            session.commit();//ok
        } catch (JMSException e) {
            e.printStackTrace();
            session.rollback();//error可以回滚
        } finally {
            if ( null != session ) {
                try {
                    session.close();//最后关闭
                } catch (JMSException e) {
                    e.printStackTrace();
                }
            }
        }
        * */

        connection.close();

        System.out.println("***message send success!!!***");
    }
}
