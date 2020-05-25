package com.example.demo;

public class TwoSumTest {

    public int[] twoSum(int[] nums, int target){
        //首先判断数组长度是否大于等于2，才可以继续进行
        //获取数组长度确认需要遍历的次数
        int numsLength = nums.length;
        //创建获取结果的数组
        int[] result = new int[2];
        int testNums ;
        for (int i = 0; i < numsLength * (numsLength-1) / 2 ; i++) {
            testNums = nums[i] + nums[i+1];
            if (testNums == target){
                result[0] = nums[i];
                result[1] = nums[i+1];
            }
        }
        return result;
    }
}
