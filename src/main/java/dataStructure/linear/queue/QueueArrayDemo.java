package dataStructure.linear.queue;

import java.util.Scanner;

/**
 * 队列：实现方式为数组和链表
 * 示例一、以数组队列的方式实现
 * 1、遵循先入先出的原则，加数据是在队列尾部加，取数据是在队列的队首加
 * 2、缺陷：数组没有达到复用的效果，使用算法将将这个数组转换成环形队列
 */
public class QueueArrayDemo {
    //数组模拟队列的输入输出
    //field1 数组成员【rear尾指针，front首指针】
    //field2 队列最大容量的设置 maxSize
    public static void main(String[] args) {
        ArrayQueue arrayQueue = new ArrayQueue(3);
        char key = ' ';
        Scanner scanner = new Scanner(System.in);

        boolean loop = true;
        while (loop){
            System.out.println("列出数据：s");
            System.out.println("增加数据：a");
            System.out.println("取出数据：g");
            System.out.println("获取头数据：h");
            System.out.println("退出：e");
            System.out.println("请输入一个数字");
            key = scanner.next().charAt(0);
            switch (key) {
                case 's':
                    arrayQueue.listArr();
                    break;
                case 'a':
                    int value = scanner.nextInt();
                    arrayQueue.addQueue(value);
                    break;
                case 'g':
                    try {
                        int res = arrayQueue.getQueue();
                        System.out.printf("取出的数据是%d\n",res);
                    }catch (Exception e){
                        System.out.println(e.getMessage());
                    }
                    break;
                case 'h':
                    try {
                        int res = arrayQueue.headQueue();
                        System.out.printf("队列头数据是%d\n",res);
                    }catch (Exception e){
                        System.out.println(e.getMessage());
                    }
                    break;
                case 'e':
                    scanner.close();
                    loop = false;
                default:
                    break;
            }

        }
        System.out.println("退出！");
    }




}
class ArrayQueue{
    private int maxSize;//maxSize of array
    private int front;//队列尾部
    private int rear;//队列头
    private int[] arr;
    /**
     * structure
     */
    public ArrayQueue(int maxSize){
        this.maxSize = maxSize;
        arr = new int[maxSize];
        front = -1;//初始化时指向队列头的前一个位置
        rear = -1;//指向队列尾的数据（就是队列最后一个数据）
    }
    //判断队列是否已满
    public boolean isFull(){
        return rear == maxSize;
    }
    //当头尾相等时，数组为空
    public boolean isEmpty(){
        return rear == front;
    }
    //add
    public void addQueue(int item){
        if (isFull()){
            //打印数组已满
            return;
        }
        rear++;
        arr[rear]=item;
    }
    //get
    public int getQueue(){
        if (isEmpty()){
            throw new RuntimeException("队列为空！");
        }
        front++;//front 后移
        return arr[front];
    }
    public void listArr(){
        if (isEmpty()){
            System.out.println("无数据，队列空。");
            return;
        }
        for (int i = 0; i < arr.length; i++) {
            System.out.printf("arr[%d]=%d\n",i,arr[i]);
        }
    }
    public int headQueue(){
        if (isEmpty()){
            throw new RuntimeException("数组为空");
        }
        return arr[front+1];
    }
}
