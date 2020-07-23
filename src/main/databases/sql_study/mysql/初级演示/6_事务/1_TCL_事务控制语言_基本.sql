/**
  TCL_事务控制语言
  transaction control language

  事务：一个或者一组sql语句组成一个执行单元，这个执行单元要么执行，要么全部不执行

  案例：转账
  张三丰 1000
  郭襄 1000
  执行两次将张三丰的钱转给郭襄
  但是两次update过程中出现了执行失败，就会出现数据的差异的问题
  执行成功。
  执行失败：产生错误后将整个单元回滚，回到最初的状态

  ACID
  特点：Atomicity Consistence Isolation Durability
  1、原子性 是一个不可分割的部分，要么都发生，要么都不发生
  2、一致性 事务必须使数据库从一个一致性状态转为另一个一致性状态
  3、隔离性（取决于隔离级别） 并发执行，不被其他事务干扰
  4、持久性 一个事务提交后对于数据库的改变是永久的，不会被其他操作所影响
  */
# 查看存储引擎
show engines;
# 自动提交默认是开启的
show variables like '%autocommit%';
# 隐式事务：事务没有明显的开启和结束标记，比如简单的增删改查等
use students;
# 1、关闭自动提交，开启事务
set autocommit = 0;
# 2、可选指令，开启事务
start transaction ;
# 3、编写事务中的sql语句（select insert update delete）
# 4、结束事务：提交或者回滚
commit ;#提交
rollback ;#回滚

drop table if exists account;
create table account (
    id int primary key auto_increment,
    username varchar(10),
    balance double
);
insert into account(username,balance) values
('zwj',1000),
('zm',1000);

# 转账事务
show variables like '%autocommit%';
set autocommit = 0;
start transaction ;
update account set balance = 500 where username = 'zwj';
update account set balance = 1500 where username = 'zm';
commit ;
show variables like '%autocommit%';
set autocommit = 0;
start transaction ;
update account set balance = 1000 where username = 'zwj';
update account set balance = 1000 where username = 'zm';
rollback ;# 只存在内存中，回滚，执行的事情不该数据库