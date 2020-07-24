package com.study.jvm.chapter2_runningDataArea;

import java.util.Date;

public class LocalVariablesTest {
    private int count = 0;

    public static void main(String[] args) {
        LocalVariablesTest test = new LocalVariablesTest();
        int num = 10;
        test.test1();
    }
    public void test1(){
        Date date = new Date();
        String name1 = "atguigu.com";
        System.out.println(date+name1);
    }
}
