package com.study.jvm.chapter1;

public class DeadThreadTest {
    public static void main(String[] args) {
        Runnable r = () -> {
            System.out.println(Thread.currentThread().getName()+"START");
            DeadThread dead = new DeadThread();
            System.out.println(Thread.currentThread().getName()+"EBD");
        };
        Thread t1 = new Thread(r,"THREAD1");
        Thread t2 = new Thread(r,"THREAD2");
        t1.start();
        t2.start();

    }
}
class DeadThread{
    static {
        if(true){
            System.out.println(Thread.currentThread().getName()+"初始化当前类");
            while (true){

            }
        }
    }
}
