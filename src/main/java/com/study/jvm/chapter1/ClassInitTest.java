package com.study.jvm.chapter1;

public class ClassInitTest {
    private static int i = 9;

    static {
        i=2;
        System.out.println(i);
//        System.out.printf("", j);Illegal forward reference
    }
    private static int j = 5;
    public static void main(String[] args) {
        System.out.printf("i = ", i);
    }
}
