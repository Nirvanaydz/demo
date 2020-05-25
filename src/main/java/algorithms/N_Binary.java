package algorithms;

public class N_Binary {
    public static void main(String[] args) {
        int[] a = {1,1,1,1,1,1,0};
        int[] b = {1,1,1,1,1,0,1};
        int[] res = new N_Binary().add_two_binaryArray(a,b);
        System.out.print(0+", ");
        for (int s:a) {
            System.out.print(s + ", ");
        }
        System.out.println();
        System.out.print(0+", ");
        for (int s:b) {
            System.out.print(s + ", ");
        }
        System.out.println();
        for (int s:res) {
            System.out.print(s + ", ");
        }
    }
    public int[] add_two_binaryArray(int[] a,int[] b){
        int len = a.length;
        int[] res = new int[len+1];
        int key = 0;
        for (int i = len-1; i >= 0; i--) {
            key = a[i]+b[i]+key;
            if (key>=2){
                res[i+1] = key%2;
                key = 1;
            } else {
                res[i+1] = key;
                key = 0;
            }
        }
        res[0]=1;
        return res;
    }
}
