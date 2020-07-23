/**
  id：
    id相同的情况下，执行顺序由上至下执行
    id不同的情况下，id大的执行优先级越高

  simple：查询的类型，主要用于区别普通查询，联合查询，子查询等的复杂查询
    simple
    primary[查询最外层的最后执行的查询]
    subQuery[子查询]
    derived[临时查询]
    union
        [若第二个select出现在union之后，标记为union]
        [若union包含在from字句的子查询中，外层将被标记为derived]
    union_result[两种union表的合并的结果]

  table[顾名思义，就是查询了哪张表]

  type：显示查询使用了何种查询
    查询从最好到最差依次级别：
        system>>>const>>>eq_ref>>>ref>>>range>>>index>>>ALL
            system 一张表只有一行记录
            const  表示通过索引一次就找到了数据 select * from (select * from t_b where id = 1) d1;
            eq_ref 唯一性索引扫描，对于每个索引键，表中只有一条记录与之匹配，常见于主键或者唯一索引扫描
            ref    非唯一性索引扫描，返回匹配某个单独值的所有值
            range  将索引的条件限制在某个特定的范围
            index  全索引扫描，只遍历索引树，index是读取索引文件
            ALL    全表扫描，读取表中的全部数据

  possible_key：可能使用到的索引

  key：实际中使用到的索引，查询中使用了覆盖索引[查询的字段正好和建立索引的顺序和个数一致]则会出现在key中
            覆盖索引说明：查询的字段正好和建立索引的顺序和个数一致
                    https://www.bilibili.com/video/BV12b411K7Zu?p=203

  key_len：表示索引使用的字节数，同样查询结果下，精度越高，使用字节数越高，推荐使用长度低的索引长度

  ref：显示索引的哪些列被使用了，如果可能的话，是一个常数const，哪些列或者常量被用于查找列上的值

  raw：优化器查询每张表需要使用的行数，越小越好

  extra：额外信息
        using filesort 建立的索引被部分使用到，但是无法使用索引完成排序操作
        using temporary 使用sql查询时出现临时表进行
        using index 覆盖索引（查询顺序结果只使用了索引数据列）
        using where|join buffer|impossible where
  */
# const出现场景
explain select * from (select * from tbl_emp where id = 1) d1;
# range出现场景
explain select * from tbl_emp where id in (1,2,3);
explain select * from tbl_emp where id between 1 and 4;
# index出现场景
explain select id from tbl_emp;
# 建立复合索引，索引被部分使用到，但是无法使用索引完成排序操作
create index idx_name_deptId on tbl_emp(name,deptId);
explain select name,deptId from tbl_emp where name like '%a%' order by deptId;
# 按索引顺序进行排序，可以避免filesort
explain select name,deptId from tbl_emp where name like '%a%' order by name,deptId;