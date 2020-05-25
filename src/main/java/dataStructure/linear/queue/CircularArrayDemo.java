package dataStructure.linear.queue;

import java.util.Scanner;

/**
 * 使用算法模拟环形队列的思路分析：
 * 变化：初始值：front=0，rear=0
 *  1、arr[front]将front指向第一个元素
 *  2、arr[rear-1]希望空出一个空间，指针rear指向对后一个元素的后一个位置
 *  3、条件分析
 *      a、队列什么时候满 : (rear+1)%maxSize == front
 *      b、队列怎么增加元素 : rear++;arr[rear-1]=addNum;
 *      b、队列中有效元素 : (rear+maxSize-front) % maxSize
 *      c、队列怎么取元素 :
 *      d、队列获取头元素
 *      e、遍历环形数组
 *      f、队列什么时候为空 : front == rear
 */
public class CircularArrayDemo {
    public static void main(String[] args) {
        CircularArray c = new CircularArray(5);
        char key = ' ';
        Scanner in = new Scanner(System.in);
        boolean loop = true;
        while (loop){
            System.out.println("列出数据：s");
            System.out.println("增加数据：a");
            System.out.println("取出数据：g");
            System.out.println("获取头数据：h");
            System.out.println("退出：e");
            System.out.println("请输入一个数字");
            key = in.next().charAt(0);
            switch (key){
                case 's':
                    try {
                        c.showQueue();
                    }catch (Exception e){
                        System.out.println(e.getMessage());
                    }
                    break;
                case 'a':
                    try {
                        int add = in.nextInt();
                        c.addItem(add);
                    }catch (Exception e){
                        System.out.println(e.getMessage());
                    }
                    break;
                case 'g':
                    try {
                        System.out.println(c.getItem());
                    }catch (Exception e){
                        System.out.println(e.getMessage());
                    }
                    break;
                case 'h':
                    try {
                        System.out.println(c.getHead());
                    }catch (Exception e){
                        System.out.println(e.getMessage());
                    }
                    break;
                case 'e':
                    in.close();
                    loop = false;
                    break;
                default:
                    break;
            }
        }
        System.out.println("退出！");
    }
}
class CircularArray{
    private int front;
    private int rear;
    private int maxSize;
    private int[] arr;
    public CircularArray(int maxSize){
        this.maxSize = maxSize;
        front = 0;
        rear = 0;
        arr = new int[maxSize];
    }
    public boolean isFull(){
        return (rear+1) % maxSize == front;
    }
    public boolean isEmpty(){
        return rear == front;
    }
    public int getRealItemNum(){
        return (rear + maxSize - front) % maxSize;
    }
    public void addItem(int item){
        //isFull?
        if (isFull()){
            throw new RuntimeException("数组已满，无法添加数据");
        }
        arr[rear] = item;
        rear = ( rear + 1 ) % maxSize;
    }
    public int getItem(){
        // isEmpty -> N
        if (isEmpty()){
            throw new RuntimeException("数组为空，无法获取数据");
        }
        int res = arr[front];
        front = ( front+1 ) % maxSize;
        return res;
    }
    public int getHead(){
        return arr[front];
    }
    public void showQueue(){
        // isEmpty -> N
        if (isEmpty()){
            throw new RuntimeException("数组为空，无法获取数据");
        }
        // 获取要遍历的有效元素的个数
        int nums = getRealItemNum();
        for (int i = 0; i < nums; i++) {
            System.out.printf("arr[%d]=[%d]\n",(front+i)%maxSize,arr[(front+i)%maxSize]);
        }
    }
}
