# DML语言
# 1、插入语句
/*
    database modify language
    insert
        1、insert into table_name(column_names...)
            values(一行数据,与columns_names对应即可);
        2、insert into table_name
            set column_name1=value1...;
        3、多行插入
            insert into table_name(column_names...)
            values(一行数据,与columns_names对应即可),
                    (一行数据,与columns_names对应即可),
                    (一行数据,与columns_names对应即可),
                    ...;
        4、插入中接入查询等结果
            insert into table_name(column_names...)
            select results。。。
*/
# 2、修改语句
/*
    update 修改语句
    1、单表修改
    update table_name ①
    set column_name=value_new1,... ③
    where 筛选语句 ②
    2、多表查询后修改
    update table1 ①
    inner join table2 on 连接条件
    set column_name=value_new1,... ③
    where 筛选语句 ②
*/
# 3、删除
/*
    delete 删除语句，自增长列从断点处开始，有返回值，可以回滚
    1、单表删除
    delete from table_name ①
    where 筛选语句 ②
    2、多表查询后删除
    delete 别名1，别名2 ①
    from table1 别名1
    inner join table2 别名2 on 连接条件
    where 筛选语句 ②

    4、truncate清空表数据，再插入数据后自增长列的数据从1开始，没有返回值，不可以回滚
*/


