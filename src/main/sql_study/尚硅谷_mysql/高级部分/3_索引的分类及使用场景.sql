/**
  BTREE索引index：排好序的快速查找的数据结构，排序和快速查找，会影响到where 和 order by语句
  一、索引的分类
        单值索引：只包含单个列，银行系统的银行卡号，或者身份证号码
        唯一索引：索引列必须唯一，但允许有空值
        符合索引：一个索引包含多个列
  二、如何创建：
        create [unique] index index_name on table_name(columnName(length));
        alter table_name add [unique] index [index_name] on (columnName(length));
  三、如何删除：
        drop index [index_name] on table_name;
  四、查看索引：
        show index from table_name\G;
  五、简单介绍BTREE数结构算法 https://www.bilibili.com/video/BV12b411K7Zu?p=195
  什么时候可以建索引：
        主键自动创建
        频繁查询的字段
        查询中关联其他表的外键建立索引
        查询中排序的字段
        倾向于建立符合索引
  不适合创建索引的条件
        频繁更新|where条件用不到的字段|不适合创建
        数据量不大|单列差异性不大列的值固定|不适合使用索引
  */
explain select * from tbl_emp;
explain select * from tbl_emp a left join tbl_dept b on a.deptId = b.id;
show index from tbl_emp;