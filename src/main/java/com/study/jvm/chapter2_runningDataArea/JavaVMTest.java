package com.study.jvm.chapter2_runningDataArea;

public class JavaVMTest {
    private static int count = 1;
    public static void main(String[] args) {
        // Exception in thread "main" java.lang.StackOverflowError
        System.out.println(count);
        //6297，使用run/debug.configuration设置jvm参数 栈 -Xss256k将栈的大小改了后，栈溢出报错在4942处报错
        count++;
        main(args);
    }
    public void method01(){
        int p=90;
        int m=40;
        method02();
    }
    public void method02(){
        int i=0;
        int k=9;
    }
}
