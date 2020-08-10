package com.study.activemq.basic.queue;

import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;
import java.io.IOException;

/**
 * 异步监听，多个消费者时存在负载均衡，6个消息，2号2,4,6号消息
 * */
public class JmsConsumer03 {
    // ?wireFormat.maxInactivityDuration=0
    public static final String ACTIVEMQ_URL = "tcp://122.51.78.20:61616";
    public static final String QUEUE_NAME = "QUEUE02";
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
        Queue queue = session.createQueue(QUEUE_NAME);
        // 5.create consumer by queue
        MessageConsumer consumer = session.createConsumer(queue);
        System.out.println("我是jms消费者2号");
        // 异步解耦的方式，通过消息监听的方式
        consumer.setMessageListener(new MessageListener() {
            @Override
            public void onMessage(Message message) {
                if ( null != message & message instanceof TextMessage ) {
                    TextMessage textMessage = (TextMessage) message;
                    try {
                        System.out.println("***consumer get the message is : ***" + textMessage.getText());
                    } catch (JMSException e) {
                        e.printStackTrace();
                    }
                }
            }
        });

        // press any key to exit 保证控制台不灭
        System.in.read();

        consumer.close();
        session.close();
        connection.close();

        System.out.println("***message receive success!!!***");
    }
}
