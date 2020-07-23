# 6、多表查询、连接查询
/*
    按功能分类：
        内连接
            等值连接
            分等值连接
            自连接
        外连接
            左外连接
            右外连接
            全外连接
        交叉连接
*/
# 等值连接：拿着其中一张表去查询另外一张表，笛卡尔重积的问题
# 等值连接：查询员工的部门名称和员工姓名
select e.last_name,d.department_name
from employees e,departments  d
where e.department_id = d.department_id;

select e.last_name,d.department_name
from employees e
left join departments  d
on e.department_id = d.department_id;

# 等值连接：查询员工名称，工种号，工种名称
select e.last_name,j.job_id,j.job_title
from employees e,jobs j
where e.job_id=j.job_id;

# 查询有奖金的员工名、部门名称
select e.last_name,d.department_name
from employees e,departments d
where e.department_id=d.department_id
and e.commission_pct is not null ;

# 查询城市名称中第二个字符为o的部门名和城市名
select d.department_name,l.city
from locations l,departments d
where l.location_id=d.location_id
and l.city like '_o%';

# 查询每个城市的部门个数
select count(*),l.city
from locations l,departments d
where l.location_id=d.location_id
group by l.city;

# 查询有奖金的每个部门的部门名称和部门领导编号和该部门的最低工资
select
min(e.salary),e.department_id,e.manager_id,d.department_name
from departments d,employees e
where d.department_id=e.department_id
and e.commission_pct is not null
group by e.department_id;

# 查询每个工种的工种名称和员工个数，并按员工个数排序
select j.job_title,count(*)
from employees e,jobs j
where e.job_id=j.job_id
group by j.job_title
order by count(*) desc;

# 三表连接
# 查询员工名称、部门名称、所在城市名称以S开头
select e.last_name,d.department_name,l.city
from employees e,departments d,locations l
where e.department_id=d.department_id
and d.location_id=l.location_id
and l.city like 's%';