/**
  视图：临时虚拟表，和普通表一样使用
    只保存sql逻辑，不保存查询结果

  视图和表的比较
                占用的物理空间                           使用场景
  view      不保存数据，只保存逻辑         增删改查，但是一般只使用查的操作，设置为可读
  table     保存了数据                   增删改查

  # 创建视图
    create view v1
    as
    select stuName,majorName
    from stuInfo s
    inner join major m on s.majorID = m.id;
  # 视图的使用
    select *
    from v1
    where v1.stuName like 'j%';
  # 修改视图
    create or replace view avg_salary_by_department
    as
        select * from departments;
    或者
    alter view avg_salary_by_department
    as
        select * from departments;
  # 查看视图
    desc avg_salary_by_department;
  # 更新视图结果  较少使用，会对查询的原表的数据修改，不安全，
    1、包含分组函数，distinct，having，union或者union all关键字的不可以更新视图
    2、常量视图
    3、包含子查询
    4、join
  insert into view_name values()...
  update view_name set ...
  delete from view_name condition...
  */
use myemployees;
# 查询邮箱中包含a字符的员工名、邮箱、部门名和工种信息
select e.last_name,e.email,d.department_name,j.*
from employees e
inner join departments d on e.department_id = d.department_id
inner join jobs j on e.job_id = j.job_id
where e.email like '%a%';
# 创建视图
create view myv1
as
    select e.last_name,e.email,d.department_name,j.*
    from employees e
    inner join departments d on e.department_id = d.department_id
    inner join jobs j on e.job_id = j.job_id;
# 使用视图
select * from myv1 where email like '%a%';

# 查询各部门的平均工资级别
# 先创建查询每个部门的平均工资的视图
create view avg_salary_by_department
as
    select avg(salary) ag,department_id
    from employees
    group by department_id;
select ag.`avg(salary)` s,j.grade_level
from avg_salary_by_department ag
join job_grades j
on ag.`avg(salary)` between j.lowest_sal and j.highest_sal;
# 查询平均工资最低的部门信息
select *
from departments
where department_id=(
    select department_id from avg_salary_by_department ag order by ag.`avg(salary)` limit 1
);
create or replace view avg_salary_by_department
as
    select * from departments;

alter view avg_salary_by_department
as
    select * from departments;

drop view avg_salary_by_department;
desc avg_salary_by_department;
