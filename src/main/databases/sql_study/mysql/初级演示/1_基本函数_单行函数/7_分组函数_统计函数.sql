# 二、分组函数 ： 入参为多个，最后返回一个值或者结果
/*
    功能：统计使用
    分类：求和，平均值，最大|最小值，统计个数
    sum|avg|max|min|count
*/
# 1、简单使用：
select sum(salary) from employees;
select avg(salary) from employees;
select max(salary) from employees;
select min(salary) from employees;
select count(salary) from employees;
select sum(salary) 求和,avg(salary) 平均值,max(salary) 最大值,min(salary) 最小值,count(salary) 统计个数 from employees;
# 2、支持的哪些类型
# sum,avg 支持数值型，忽略null值
# max，min，count 支持所有类型，忽略null值
# 3、可以和去重关键字搭配
select sum(distinct salary),sum(salary) from employees;
# 4、count函数的详细介绍
# 4.1、使用count(*) 统计行数
select count(*) from employees;
# 4.2、使用count(distinct column_name) 统计行数
select count(distinct salary) from employees;

# 5、todo 详见 GROUP BY 关键字解析 和分组函数一同查询的字段有限制

# ============练习==============
# 查询公司员工工资的最大最小值，平均值和总和
select
       sum(salary) 求和,
       avg(salary) 平均值,
       max(salary) 最大值,
       min(salary) 最小值,
       count(salary) 统计个数
from employees;
# 查询员工表中的最大入职时间和最小入职时间的天数 DIFFERENCE
select datediff(max(hiredate),min(hiredate)) DIFFERENCE from employees;
# 查询部门编号为90的员工的个数
select count(*) from employees where department_id=90;
