package algorithms;

public class Insertion_sort {
    public static void main(String[] args) {
        int[] old = new int[]{5,6,3,1,9,10};
        int[] new_array = new Insertion_sort().insertion_sort(old);
        for (int s:new_array) {
            System.out.println(s);
        }
    }
    //降序排列
    public int[] insertion_sort(int[] basic_array){
        int len = basic_array.length;
        if (len<=1){
            return basic_array;
        }
        int key = basic_array[1];
        for (int i = 1; i < len; i++) {
            key = basic_array[i];
            int j = i-1;
            while (j>=0&&basic_array[j]<key){//若需要使用升序排列的话，将判断条件作修改即可basic_array[j]>key
                basic_array[j+1] = basic_array[j];
                j--;
            }
            basic_array[j+1]=key;
        }
        return basic_array;
    }
}
