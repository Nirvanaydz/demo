/**
  sql中的数据类型---字符类型
  分类：
    较短文本：M代表最多字符数
        char(M)，    M最大字符数      固定长度的字符         较耗费空间   效率高
        varchar(M)， M最大字符数      代表可变长度的字符       节省空间    效率低
  使用：
    1、配合枚举enum使用
    2、配合set使用

  */

# 枚举enum和set集合的使用
use books;
drop table if exists tab_char;
create table tab_char(
    c1 enum('a','b','c')
);

create table tab_set(
    c1 set('a','b','c')
);
