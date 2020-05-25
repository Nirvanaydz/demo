package dataStructure.linear;

/**
 * 线性结构中的稀疏数组的使用
 * 1、稀疏数组的使用场景，稀疏数组的结构（row|col|val）
 * 2、稀疏数组与二维数组的转换
 * 3、二维数组和稀疏数组的转化
 * todo 4、遗留：将稀疏数组存盘到文件中，磁盘io操作
 * todo 5、二维数组的使用规则详尽解释
 */
public class SparseArray {
    private static final int COL = 3;

    public static void main(String[] args) {

        int[][] result01 = new int[12][10];
        int result[][] = new int[3][3];
        result01[1][1] = 2;
        result01[3][5] = 1;
        result01[7][9] = 2;
        result01[9][7] = 1;
        System.out.println("原始：");
        for (int[] a:getNormalArray(getSparseArray(result01))) {
            for (int b:a) {
                System.out.print(b + "|");
            }
            System.out.println();
        }
        System.out.println("============");
        for (int[] a:result ) {
            for (int b:a) {
                System.out.print(b + "|");
            }
            System.out.println();
        }

    }
    //定义产生一个稀疏数组
    public static int[][] getNormalArray(int[][] sparseArrayTest){
        //将稀疏数组转换为普通的二维数组
        int[][] normalArrayTest = new int[sparseArrayTest[0][0]-1][sparseArrayTest[0][1]-1];
        for (int i = 1; i <= sparseArrayTest[0][2]; i++) {
            normalArrayTest[sparseArrayTest[i][0]][sparseArrayTest[i][1]]=sparseArrayTest[i][2];
        }
        return normalArrayTest;
    }

    public static int[][] getSparseArray(int[][] normalArrayTest){
        // 获取初始数组的维度，有效的数值
        int val = 0;
        int row = 0;
        int col = 0;
        for (int[] a:normalArrayTest) {
            row++;
            for (int b:a) {
                col=a.length;
                if (b != 0){
                    val++;
                }
            }
        }
        int[][] sparseArray = new int[val+1][3];
        sparseArray[0][0] = row+1;
        sparseArray[0][1] = col+1;
        sparseArray[0][2] = val;
        //设置记录有效值得数据
        int count = 0;
        for (int i = 0; i < row; i++) {
            for (int j = 0; j < col; j++) {
                if (normalArrayTest[i][j] != 0){
                    count++;
                    sparseArray[count][0] = i;
                    sparseArray[count][1] = j;
                    sparseArray[count][2] = normalArrayTest[i][j];
                }
            }
        }
        return sparseArray;
    }

}
