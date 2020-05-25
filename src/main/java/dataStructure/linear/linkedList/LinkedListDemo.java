package dataStructure.linear.linkedList;

/**
 * 链表：以节点的方式来存储，每个节点包含data域和next域：指向下一个节点
 * 【内存中的存储区别和逻辑存储结构】
 * 分类：带头节点的链表和没哟头节点的链表
 */
public class LinkedListDemo {
    public static void main(String[] args) {
        // create new node
        HeroNode hero1 = new HeroNode(1,"宋江","及时雨");
        HeroNode hero2 = new HeroNode(2,"卢俊义","玉麒麟");
        HeroNode hero3 = new HeroNode(3,"吴用","智多星");
        HeroNode hero4 = new HeroNode(4,"林冲","豹子头");
        SingleLinkedList s = new SingleLinkedList();
        try {
            s.list();
            s.addHeroNode2(hero1);
            s.list();
            s.addHeroNode2(hero4);
            s.list();
            s.addHeroNode2(hero2);
            s.list();
            s.modifyHero(2,"yudazhi","");
            s.list();
            s.deleteHero(5);
            s.list();
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
    }
}
//带head的单向链表实现-水浒英雄排行榜
//链表管理对象
class SingleLinkedList{
    // 初始化一个头节点,不存储具体数据
    private HeroNode head = new HeroNode(0,"","");
    /**
     * 思路是从最后一个节点往前添加，首先找到最后一个节点，然后让新添加的节点的next域指向最后一个节点
     * 需要一个辅助节点来接受循环中的next域，当
     */
    public void addHeroNode(HeroNode heroNode){
        //创建辅助对象来实现查询最后一个节点的方法，从head开始遍历，一直找到next域为null
        HeroNode temp = head;
        while (true){
            if (temp.next == null){
                break;
            }
            temp = temp.next;
        }
        // 获取的temp指向了链表的最后
        temp.next = heroNode;
    }
    // 按照要求，英雄按照排名进行添加，如果排名已经有了，添加失败并给出提示
    public void addHeroNode2(HeroNode heroNode){
        /*
         * 依旧使用辅助节点，在添加时遍历当前节点信息，
         * 1、如果当前节点的no号==要添加的节点信息，则将返回失败
         * 2、如果找到需要添加节点的位置
         * 3、找到后让新节点的next域指向temp的next，再让新节点成为temp的next节点对象
         *      实现链式拼接
         *
         */
        HeroNode temp = head;
        boolean isExist = false;
        while (true){
            if (null == temp.next){//说明temp已经在链表的最后
                break;
            }
            if (temp.next.no > heroNode.no){//说明位置找到了
                break;
            } else if (temp.next.no == heroNode.no){//说明要添加的节点已经存在
                isExist = true;
                break;
            }
            temp = temp.next;//后移标记位置，遍历当前链表
        }
        if (isExist){
            throw new RuntimeException("节点信息已经存在！节点信息为：" + heroNode);
        } else {
            heroNode.next = temp.next;
            temp.next=heroNode;
        }
    }
    // 依据编号修改昵称或者名字
    public void modifyHero(int no,String name,String nickName){
        HeroNode temp = head;
        boolean isExist = false;// 标记存在此元素
        while (true){
            if (temp.next == null){
                break;
            }
            if (temp.no == no){
                isExist = true;
                break;
            }
            temp = temp.next;
        }
        if (isExist){
            if (!name.isEmpty()){
                temp.name = name;
            }
            if (!nickName.isEmpty()){
                temp.nickName = nickName;
            }
        } else {
            throw new RuntimeException("节点信息不存在");
        }
    }
    // 删除节点，依据给定的no，被删除的节点将不会有引用指向，会被垃圾回收机制回收
    public void deleteHero(int no){
        HeroNode temp = head;
        if (temp.next == null){
            System.out.println("linkedList is empty!");
            return;
        }
        boolean isExist = false;
        while (true){
            if (temp.next == null){
                break;
            }
            if (no == temp.next.no){
                isExist = true;
                break;
            }
            temp = temp.next;
        }
        if (isExist){
            temp.next = temp.next.next;
        } else {
            throw new RuntimeException("节点信息不存在");
        }
    }
    // list
    public void list(){
        if (head.next == null){
            System.out.println("empty!");
            return;
        }
        HeroNode temp = head.next;
        while (true){
            if (temp == null){
                break;
            }
            System.out.println(temp.toString());
            temp = temp.next;
        }
    }
}
/**
 * 单链表创建的示例和单向链表的分析
 * 1、先创建head节点，表示单链表的头，后面每添加一个节点就直接加入到链表的最后
 * 2、遍历
 */
class HeroNode{
    public int no;
    public String name;
    public String nickName;
    public HeroNode next;

    public HeroNode(int no,String name,String nickName){
        this.name = name;
        this.nickName = nickName;
        this.no = no;
    }

    @Override
    public String toString() {
        return "HeroNode{" +
                "no=" + no +
                ", name='" + name + '\'' +
                ", nickName='" + nickName + '\'' +
                '}';
    }
}
