package com.study.jvm.chapter1;

public class ClassInitTest1 {
    static class Father{
        public static int A = 1;
        static {
            A = 2 ;
        }
    }
    static class Son extends Father{
        public static int B = A;
    }

    public static void main(String[] args) {
//        System.out.println(Son.B);
//        System.out.println(1+2+"java"+3+4);
        int i=10;
        if(i++ == 10){
            ++i;
        }else {
            --i;
        }
        System.out.println(i);
    }
}
