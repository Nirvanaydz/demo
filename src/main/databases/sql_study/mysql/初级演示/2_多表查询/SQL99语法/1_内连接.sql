# 7、SQL99语法
/*
    select 查询列表
    from table1 alias_name 【连接类型】
    join table2 alias_name 【连接】
    on 连接条件
    where 筛选语句
    按功能分类：
        内连接 ☆ inner
            等值连接
            非等值连接
            自连接
        外连接
            ☆左外连接 left 【outer】
            ☆右外连接 right 【outer】
            全外连接 full 【outer】
        交叉连接 cross
*/
# 内连接 inner
# 等值连接：查询员工的部门名称和员工姓名
select e.last_name,d.department_name
from employees e
inner join departments d
on e.department_id=d.department_id;
# 查询名字中包含e的员工名称和工种mc
select e.last_name,j.job_title
from employees e
inner join jobs j
on e.job_id = j.job_id
where last_name like '%e%';
# 查询部门个数大于3的城市名称和个数
select count(*) as 部门个数,l.city
from departments d
inner join locations l
on d.location_id = l.location_id
group by l.city
having 部门个数>3;
# 查询哪个部门的员工个数大于3的部门名称和员工个数，并按个数降序
select count(*),d.department_name
from employees e
inner join departments d on e.department_id = d.department_id
group by d.department_id
having count(*)>3
order by count(*) desc ;
# 查询员工名称、部门名称、工种名称、并按部门名称降序
select e.last_name,d.department_name,j.job_title
from employees e
inner join departments d on e.department_id = d.department_id
inner join jobs j on e.job_id = j.job_id
order by d.department_name desc ;

# 非等值连接
# 查询员工的工资级别,查询每个工资级别的个数，并按个数降序
select j.grade_level,count(*) as nums
from employees e
inner join job_grades j
on e.salary between j.lowest_sal and j.highest_sal
group by j.grade_level
order by nums desc ;

# 自连接
# 查询每个员工的名称，编号以及他的领导的名称和编号
select e.employee_id,e.last_name,m.employee_id,m.last_name
from employees e
inner join employees m
on e.manager_id=m.employee_id;



