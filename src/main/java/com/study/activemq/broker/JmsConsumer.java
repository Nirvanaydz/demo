package com.study.activemq.broker;

import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;

/**
 * 同步收发，存在receive中等待参数的设置
 * */
public class JmsConsumer {
    // ?wireFormat.maxInactivityDuration=0
    public static final String ACTIVEMQ_URL = "tcp://localhost:61616";
//    public static final String ACTIVEMQ_URL = "tcp://122.51.78.20:61616?wireFormat.maxInactivityDuration=0";
    public static final String QUEUE_NAME = "QUEUE02";
    public static void main(String[] args) throws JMSException {
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
        Queue queue = session.createQueue(QUEUE_NAME);
        // 5.create consumer by queue
        MessageConsumer consumer = session.createConsumer(queue);
        while (true) {
            // 6.receive message
//            TextMessage receive = (TextMessage) consumer.receive();
            // 4秒之後沒收到消息就會自動關閉消費者
            TextMessage receive = (TextMessage) consumer.receive(4000);
            //            consumer.receive(3000);
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
