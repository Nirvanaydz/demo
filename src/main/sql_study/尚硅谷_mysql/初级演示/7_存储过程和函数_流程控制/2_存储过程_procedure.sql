use myemployees;
# create table job_grades
# (
#     grade_level varchar(3) null,
#     lowest_sal  int        null,
#     highest_sal int        null
# );
# insert into job_grades values
# ('A',1000,2999),('B',3000,5999),('A',6000,9999),('A',10000,14999),('A',15000,24999),('A',25000,40000);
/**
  存储过程和函数 类比于java中的方法
  存储过程：一组预先编译好的sql语句的集合，批处理语句
    简化、安全、效率高
  */
# 一、存储过程
# 1.1、创建
use myemployees;
# create procedure produce_name(参数列表)
# begin
#     存储过程体
# end
/**
  参数列表：
  参数模式                          参数名称            参数类型
  IN：需要调用方传入值
  OUT：可以作为返回值
  INOUT：既可以传入，又可以作为返回值

  存储体中只有一句时，begin end 可以省略，很少使用到
    存储体中的sql语句之间必须加;隔离
    delimiter 结束标记

  调用 call 存储过程值
  */
create database if not exists books;
create table books.admin(
    id int primary key auto_increment,
    username varchar(10),
    password varchar(20)
);
insert into books.admin values (1,'john',8888),(2,'ydz',6666);
use books;
# 无参数的插入
delimiter $
create procedure myp1()
begin
    insert into admin(username, `password`) VALUES
    ('john01',8888),('john02',8888),('lily',8888),('john04',8888),('john05',8888);
end $
call myp1() $;
# 有参数的查询
use myemployees;

delimiter $
create procedure myp2(IN id int(6))
begin
    select e.employee_id,e.last_name,d.*
    from employees e
    join departments d on e.department_id = d.department_id
    where e.employee_id = id;
end $
call myp2(100)$;

use books;
delimiter $
create procedure myp3(in username varchar(20),in password varchar(20))
begin
    declare result varchar(20) default '';# 声明并初始化
    select count(*) into result # 赋值
    from admin
    where admin.username = username
    and admin.password = password;
    select result;# 输出变量result
end $

create procedure myp4(in username varchar(20),in password varchar(20))
begin
    declare result int default 0;# 声明并初始化
    select count(*) into result # 赋值
    from admin
    where admin.username = username
    and admin.password = password;
    select if(result>0,'success','fail');# 输出变量result
end $

# 带out模式的存储过程
use myemployees;

delimiter $
create procedure myp5(IN id int,out department_result1 varchar(20),out department_result2 int)
begin
    select d.department_name,d.department_id into department_result1,department_result2
    from employees e
    join departments d on e.department_id = d.department_id
    where e.employee_id = id;
end $
set @department_result1$
set @department_result2$
call myp5(100,@department_result1,@department_result2)$;
select @department_result1,@department_result2;

delimiter $
create procedure myp7(inout a int,inout b int)
begin
    set a=a*2;
    set b=b*2;
end $
# 查看procedure
show create procedure myp4;