# 8、子查询
/*
    出现在其他语句中的select语句，分为子查询和内查询

    分类：
    1、按子查询出现的位置：
        select，仅支持一行一列的查询
        from，支持多行多列
        where或者having，除多行多列
        exists后面 多行多列
    2、按结果集的行列数不同
        一行一列 标量
        一列多行 列
        一行多列 行
        多列多行 表

*/
# 一、出现在where和having后面
# 标量子查询
# 放在小括号内，放在条件右侧
# 谁的工资比abel高
select *
from employees
where salary >(
    select salary from employees e
    where e.last_name = 'Abel'
);
# 查询job_id与141号员工相同，salary比143号员工多的员工的姓名，job_id和工资
select last_name,job_id,salary
from employees
where job_id=(
    select job_id
    from employees e
    where e.employee_id=141
)
and salary>(
    select e.salary
    from employees e
    where e.employee_id=143
);
# 返回公司工资最少的员工的名称，工种和工资
select last_name,job_id,salary
from employees
where salary=(
    select min(salary)
    from employees
);
#查询最低工资大于50号部门最低工资的部门id和其最低工资
select min(salary),department_id
from employees
where department_id is not null
group by department_id
having min(salary)>(
    select min(salary)
    from employees
    where department_id=50
);
# 单列多行子查询 IN/NOT IN,
# ANY|SOME,ALL
# 返回地址id为1400或者1700的部门中的所有员工的姓名
# 首先查询部门id
select distinct department_id
from departments
where location_id in (1400,1700);
# 再查询结果
select last_name
from employees
where department_id in(
    select distinct department_id
    from departments
    where location_id in (1400,1700)
);
# 返回其他部门中比job_id为’IT_PROG‘部门所有工资低的员工的工号，姓名。工种和工资
select employee_id,last_name,job_id,salary
from employees
where salary<(
    select min(salary)
    from employees
    where job_id='IT_PROG'
)
and department_id <>(
    select distinct department_id
    from employees
    where job_id='IT_PROG'
);

# 行子查询
# 查询员工编号最小并且工资最高的员工信息
select *
from employees
where salary=(select max(salary) from employees)
and employee_id=(select min(employee_id) from employees);
# 将多个条件类似的语句集合成一个【使用的较少】
select *
from employees
where (employee_id,salary)=(
    select min(employee_id),max(salary)
    from employees
);

# 二、放在select后面
# 查询每个部门的员工个数
select d.*,(
    select count(*)
    from employees e
    where e.department_id=d.department_id
)
from departments d;
# 三、from 后面，给临时表起别名
# 查询每个部门的平均工资水平
select avg(salary)
from employees
group by department_id;
select avg_per.department_id,avg_per.avg 每个部门的平均工资,j.grade_level 工资级别
from (
    select avg(salary) avg,department_id
    from employees
    group by department_id
) as avg_per
inner join job_grades j
on avg_per.avg between j.lowest_sal and j.highest_sal;

# 四、exists后面（相关子查询）只关心其中的子查询是否有值
# 查询有员工的部门名称
select department_name
from departments d
where exists(
    select *
    from employees e
    where d.department_id=e.department_id
);



