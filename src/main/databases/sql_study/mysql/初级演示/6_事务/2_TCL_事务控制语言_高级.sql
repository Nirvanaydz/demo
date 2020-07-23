/**
  TCL_事务控制语言
  transaction control language

  并发的产生：多个事务一起运行时，访问相同的数据会出现一些问题
    主要是读取和更新的操作未同步，导致两个事务操作的数据不一致

  采用事务隔离完成并发问题的处理：
    事务隔离的级别：
        READ UNCOMMITTED    允许事务读取未被其他事务提交的变更
        READ COMMITTED      只允许读取已被其他事务提交了的数据
        REPEATABLE READ     确保一个事务可以从一个字段中读取相同的值，读取阶段不允许其他事务对这个字段进行更新 mysql默认
        SERIALIZABLE        加入了锁，性能比较低。确保一个事务可以从一个表中读取相同的值，禁止其他事务对该表进行执行插入
  */
# 查看存储引擎
show engines;
# 自动提交默认是开启的
show variables like '%autocommit%';
# 隐式事务：事务没有明显的开启和结束标记，比如简单的增删改查等
use students;
# 1、关闭自动提交，开启事务
set autocommit = 0;
savepoint a;
commit ;
rollback to a;# 搭配savepoint 使用

select @@tx_isolation;
# 设置事务的隔离级别
set session transaction isolation level read uncommitted;
set session transaction isolation level read committed;
set session transaction isolation level repeatable read;
set session transaction isolation level serializable;
# delete回滚是有效的，数据不会被删除
set autocommit = 0;
start transaction ;
delete from students.account;
rollback ;
# truncate回滚无效，数据已经被删除
set autocommit = 0;
start transaction ;
truncate table students.account;
rollback ;