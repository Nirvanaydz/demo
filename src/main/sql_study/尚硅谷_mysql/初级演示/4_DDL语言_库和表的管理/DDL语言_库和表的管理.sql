# DDL语言_库和表的管理
/*
    1、库的管理：创建、修改、删除
    2、表结构的管理：创建、修改、删除
    create
    alter
    drop
*/
# 1.1、库的创建 create database database_name;
create database if not exists books;
# 1.2、库名的修改 不使用了！！！
# 1.2、库的修改：更改字符集
alter database books character set utf8;
# 1.3、库名的删除
drop database if exists books;
# 2.1、表的创建
# create table table_name（列名 列的类型 【长度 约束】）;
use books;
create table book(
    id int,
    bname varchar(20),#最大字符长度为20
    price double,
    authorid int,
    publicDate datetime
);
create table author(
    id int,
    au_name varchar(20),
    nation varchar(10)
);

# 2.2、表的修改
# alter table table_name column column_name [类型 约束]
/*
    修改列名
    修改列的类型或者约束
    添加新列
    删除列
    修改表名
*/
# 修改列名
alter table book change column publicDate pubDate datetime;
desc book;
# 修改列的类型或者约束
alter table book modify column pubDate timestamp;
desc book;
# 添加新列
alter table author add column annual double;
desc author;
# 删除列
alter table author drop column annual;
desc author;
# 修改表名
alter table author rename to book_author;
desc book_author;
# 3、表的删除
drop table if exists book_author;
desc author;
show full columns from copy;
#alter table index_product
# change name name varchar(100) character
# set utf8 collate utf8_unicode_ci;
# 4、表的复制
alter table author
modify nation varchar(10) character
set utf8 collate utf8_unicode_ci;
insert into author values
(1,'莫言','中国'),
(2,'冯唐','中国'),
(3,'金庸','中国'),
(4,'春上春树','日本');
# 仅复制表结构
create table copy like author;
create table copy3
select id,nation from author
where 1=2;
# 复制表数据
create table copy2
select * from author
where nation='中国';