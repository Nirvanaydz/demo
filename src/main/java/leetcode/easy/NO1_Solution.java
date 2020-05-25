package leetcode.easy;

import java.util.HashMap;

public class NO1_Solution {
    /**
     * 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
     * 你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素
     */
    public static void main(String[] args) {
        int[] nums = {2,7,11,15};
        int target = 13;
        int[] res = new NO1_Solution().twoSum(nums,target);
        System.out.println(res[0]);
        System.out.println(res[1]);
    }
    public int[] twoSum(int[] nums, int target){
        int[] result = new int[2];
        HashMap<Integer,Integer> newNums = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            newNums.put(nums[i], i);
        }
        for (int i = 0; i < nums.length; i++) {
            int sec = target - nums[i];
            if (newNums.containsKey(sec)){
                result[0]=i;
                result[1]=newNums.get(sec);
                return result;
            }
        }
        throw new IllegalArgumentException("no solution!");
    }
}
