# set global log_bin_trust_function_creators=1
create database if not exists bigData;
use bigData;
create table dept(
    id int unsigned primary key auto_increment,
    deptNo mediumint unsigned not null default 0,
    dName varchar(20) not null default '',
    loc varchar(13) not null default ''
)engine = INNODB DEFAULT CHARSET = GBK;

create table emp(
    id int unsigned primary key auto_increment,
    empNo mediumint unsigned not null default 0,
    eName varchar(20) not null default '',/*名字*/
    job varchar(9) not null default '',#工作
    mgr mediumint unsigned not null default 0,#上级编号
    hireDate date not null ,#入职时间
    sal decimal(7,2) not null ,#薪水
    comm decimal(7,2) not null ,#红利
    deptNo mediumint unsigned not null default 0 #部门编号
)engine = innodb default charset = GBK;
delimiter $$
create function rand_string(n int) returns varchar(255)
begin
    declare chars_str varchar(100) default 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    declare return_str varchar(255) default '';
    declare i int default 0;
    while i < n do
        set return_str = concat(return_str,substr(chars_str,floor(1+rand()*52),1));
        set i = i + 1;
    end while;
    return return_str;
end $$
create function rand_num() returns int(5)
begin
    declare i int default 0;
    set i = floor(100+rand()*10);
    return i;
end $$

delimiter $$
create procedure insert_emp(in start int(10),in max_num int(10))
begin
    declare i int default 0;
    set autocommit = 0;
    repeat
        set i = i + 1;
        insert into emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES
                        ((start+i),rand_string(6),'SALESMAN',0001,curdate(),2000,400,rand_num());
    until i = max_num
    end repeat;
    commit ;
end $$

create procedure insert_dept(in start int(10),in max_num int(10))
begin
    declare i int default 0;
    set autocommit = 0;
    repeat
        set i = i + 1;
        insert into dept(deptNo, dName, loc) VALUES ((start+i),rand_string(10),rand_string(8));
    until i = max_num
    end repeat;
    commit ;
end $$

call insert_dept(100,10);
call insert_emp(100001,500000);
# 是否开启慢日志查询
show variables like 'profiling';
set profiling=on;

select * from emp e inner join dept d on e.deptNo = d.id;

select * from emp group by id%10 limit 150000;

select * from emp group by id%20 order by 5;

show profiles;
show profile cpu ,block io for query 6;
/**
  converting heap to myISAM 查询结果太大，内存都不够用了，往磁盘上搬
  creating tmp table 创建临时表，在copy数据至临时表以及删除临时表都需要耗费大量的资源
  copying to tmp table on disk 把内存中的临时表复制到磁盘，很危险！
  locked 被锁住了
  */

set global general_log = 1;
set global log_output = 'TABLE';
select * from mysql.general_log;