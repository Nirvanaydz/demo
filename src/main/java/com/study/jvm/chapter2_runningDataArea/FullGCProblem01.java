package com.study.jvm.chapter2_runningDataArea;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class FullGCProblem01 {

    public static void main(String[] args) throws Exception{
        executor.setMaximumPoolSize(50);

        for (;;){
            modelFit();
            Thread.sleep(100);
        }
    }

    private static class CardInfo{
        BigDecimal price = new BigDecimal(0.0);
        String name = "Dzyu";
        int age = 27;
        Date birth = new Date();

        public void m(){}
    }

    private static ScheduledThreadPoolExecutor executor = new ScheduledThreadPoolExecutor(50,
            new ThreadPoolExecutor.DiscardOldestPolicy());

    private static void modelFit(){
        List<CardInfo> taskList = getAllCardInfo();

        taskList.forEach(info -> {
            // do something
            executor.scheduleWithFixedDelay(() -> {
                // do sth with info
                info.m();
            },2,3, TimeUnit.SECONDS);
        });

    }

    /**
     * create a list contains 100 CardInfos object
     * */
    private static List<CardInfo> getAllCardInfo(){
        List<CardInfo> taskList = new ArrayList<>();
        for (int i = 0; i < 100; i++) {
            CardInfo c1 = new CardInfo();
            taskList.add(c1);
        }
        return taskList;
    }


}
