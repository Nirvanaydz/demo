# 6、多表查询、连接查询
/*
    按功能分类：
        内连接
            等值连接
            非等值连接
            自连接
        外连接
            左外连接
            右外连接
            全外连接
        交叉连接
*/
# 非等值连接：建立在等值连接的基础上
# 创表 job_grades
# 获取有奖金的员工名和其工资等级
select e.last_name,e.salary,j.grade_level
from job_grades j,employees e
where e.salary between j.lowest_sal and j.highest_sal
and e.commission_pct is not null ;

# 自连接：查询员工名称和其对应的领导名称
select e.last_name,e.employee_id,m.employee_id,m.last_name
from employees e,employees m
where e.manager_id=m.employee_id;

# practices
# 显示工资表的最大工资和工资平均值
select max(salary),avg(salary) from employees;
# 查询员工表的员工编号，工种，名称，按部门降序，工资升序
select employee_id,job_id,last_name
from employees
order by department_id desc ,salary asc;
# 查询员工表中job_id包含a和e的，并且a在e前面
select job_id from employees
where job_id like '%a%e%';
# 查询90号部门的员工的job_id和90号部门的location_id
select e.last_name,e.job_id,e.department_id,d.location_id
from employees e,departments d
where e.department_id=d.department_id
and e.department_id=90;
# 查询所有有奖金的员工的姓名，部门名称，位置id和城市名称
select e.last_name,d.department_name,l.location_id,l.city
from employees e,departments d,locations l
where e.department_id=d.department_id
and d.location_id=l.location_id
and e.commission_pct is not null ;
# 查询在Toronto工作的员工的名称，工种，部门id和部门名称
select e.last_name,e.job_id,d.department_id,d.department_name
from employees e,departments d,locations l
where e.department_id=d.department_id
and d.location_id=l.location_id
and l.city = 'Toronto';
# 查询每个工种、每个部门的部门名称、工种名称和最低工资
select e.job_id,d.department_name,j.job_title,min(e.salary)
from employees e,departments d,jobs j
where e.department_id=d.department_id
and e.job_id=j.job_id
group by e.job_id, d.department_name;
# 查询每个国家下的部门个数大于2的国家编号
select count(*) as 部门个数,l.country_id
from departments d,locations l
where d.location_id=l.location_id
group by country_id
having 部门个数>2;
# 指定查询员工kochhar的姓名，员工号，以及他的管理者的姓名和员工号
select e.employee_id,e.last_name,m.last_name,m.employee_id
from employees e,employees m
where e.manager_id=m.employee_id
and e.last_name = 'kochhar';
