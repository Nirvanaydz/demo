package algorithms;

import java.util.Arrays;

public class Selection_sort {
    public static void main(String[] args) {
        int[] res = new Selection_sort().get_new_arr(new int[]{12,18,19});
        for (int s:res
             ) {
            System.out.println(s);
        }
    }
    //选择排序,找到最小的元素
    public int selection_sort(int[] old){
        int key = old[0];
        int key_index = 0;
        for (int i = 1; i < old.length; i++) {
            if(old[i]<key){
                key = old[i];
                key_index = i;
            }
        }
        return key_index;
    }
    public int[] get_new_arr(int[] old){
        int[] resArr = new int[old.length];
        for (int i = 0; i < old.length; i++) {
            int index = selection_sort(old);
            resArr[i] = old[index];
            old[index] = old[old.length-1];
            old= Arrays.copyOf(old,old.length-1);
        }
        return resArr;
    }
}
