package com.study.jvm.chapter1;

import java.util.ArrayList;
import java.util.List;

/**
 * 中国联通线上笔试题：去除集合中包含指定字符的字符串后并返回
 */
public class RemoveSameKeyTest {
    private static int x=100;

    public static void main(String[] args) {
        List<String> old = new ArrayList<>();
        old.add("abcaba");
        old.add("ebcaba");
        old.add("fbcaba");
        old.add("gbdcaba");
        old.add("hccaba");
        List<String> newList = new RemoveSameKeyTest().remove(old,"bc");
        for (String a:newList) {
            System.out.println(a);
        }
    }
    public List<String> remove(List<String> old,String key){
        List<String> newList = new ArrayList<>();
        int length = old.size();
        for (int i = 0; i < length; i++) {
            if(!old.get(i).contains(key)){
                newList.add(old.get(i));
            }
        }
        return newList;
    }
}
