package com.study.jvm.chapter1;

/**
 * javap -v StackStruTest.class 编译class文件
 * jsp 监控进程
 */
public class StackStruTest {
    public static void main(String[] args) {
        int i = 2;
        int j = 3;
        int k = i + j ;

        try {
            Thread.sleep(6000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.printf("", "hello");

    }
}
