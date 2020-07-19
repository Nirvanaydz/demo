/**
  存储过程和函数 类比于java中的方法
  create function 函数名称（参数列表） returns 返回类型
    begin
        函数体
    end
  函数：只能返回一个值
  1、参数列表：
  参数模式                          参数名称            参数类型

  2、函数体：一定要包含return语句
  3、使用delimiter语句设置结束标记
  4、调用 select function_name(params)
  */
use myemployees;
delimiter $
# 1、无参数返回 返回公司的员工个数
create function myf1() returns int
begin
    declare c int default 0;
    select count(*) into c
    from employees;
    return c;
end $
select myf1()$
# 2、根据员工名称返回工资
use myemployees;
delimiter $
create function myf2(empName varchar(20)) returns double
begin
    set @sal=0;
    select salary into @sal
    from employees
    where employees.last_name = empName;
    return @sal;
end $
select myf2('kochhar')$
use myemployees;
delimiter ;
show create function myf1;
drop function myf1;

# 创建一个函数，返回传入两个参数的和