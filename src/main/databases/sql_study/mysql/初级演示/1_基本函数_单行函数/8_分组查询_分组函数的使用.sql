# 分组查询,支持别名，分为分组前和分组后筛选，可进行多个分组
# 分组前筛选，在group by 之前的where中
# 分组后筛选 以having开头，放在group by之后
# 引入查询每个工资部门的平均值
select avg(salary),ifnull(department_id,0)
from employees
group by department_id;
# 查询每个工种的最高工资
select max(salary),job_id
from employees
group by job_id;
# 查询每个位置上的部门个数
select count(department_id),location_id
from departments
group by location_id;
# 查询邮箱中包含a字符的每个部门的平均工资
select avg(salary),ifnull(department_id,0)
from employees
where email like '%a%'
group by department_id;
# 查询有奖金的每个领导手下员工的最高工资
select max(salary),manager_id
from employees
where commission_pct is not null
group by manager_id;
# 查询部门员工个数大于2的部门
# ①、先查询处每个部门的员工个数
# ②、再以查出的临时结果查询结果
select s.id,s.count
from
(select count(*) count,department_id id
from employees
group by department_id) s
where s.count > 2;

select count(*) count,department_id id
from employees
group by department_id
having count(*) > 2;

# 查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
select job_id,max(salary)
from employees
where commission_pct is not null
group by job_id
having max(salary)>12000;

# 查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个
select manager_id,min(salary)
from employees
where manager_id > 102
group by manager_id
having min(salary)>5000;

# 按员工姓名的长度分组，查询每一组的员工个数，筛选员工个数>5的有哪些
select length(last_name),count(*)
from employees
group by length(last_name)
having count(*)>5;

# 查询每个部门每个工种的员工的平均工资
select avg(salary),department_id,job_id
from employees
group by  department_id, job_id;

# 查询每个部门id不为空的每个工种的员工的平均工资，并按平均工资降序排序
select avg(salary),department_id,job_id
from employees
where department_id is not null
group by  department_id, job_id
order by avg(salary) desc ;