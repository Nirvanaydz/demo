/*
    BASIC SEARCH
        SELECT REFERENCE
            distinct 去重
            column-name as alias-name
            concat(str1,',',str3,...)
            IFNULL(column-name,replace-value)
        FROM
            TABLE_NAME
        WHERE
        分类
            1、按条件表达式筛选
                > ; < ; = ; <> ; >= ; <=
            2、逻辑表达式筛选
                && || ！
                and 两个都为true
                or  一个为true
                not true-->false

            3、模糊查询
                like
                between and
                in
                is null
        ORDER BY column_name ASC升序默认|DESC降序需写
                可以支持多个字段，执行顺序一般放在查询语句的最后，limit除外
                支持别名，函数等
*/
select * from myemployees.employees
where salary > 12000;
# 查询部门编号不等于90的员工名称和部门编号
select
       concat(em.first_name,em.last_name),em.department_id
from
     myemployees.employees em
where
      department_id <> 90;
# 逻辑表达式：查询工资在10000至12000之间的员工名称、工资以及奖金
select
    em.first_name,em.salary,em.commission_pct
from
    myemployees.employees em
where
    salary>=10000
    and
    salary<=12000;
# todo !!!查询部门不在90到110之间，或者工资高于15000的员工信息
select
       *
from
     employees
where
    not(department_id>=90 and department_id<=110)
    or salary > 15000;
# 模糊查询
/*
like
1、一般和通配符搭配使用，
    % 代表多个字符或者零个
    _ 任意单个字符
between and
    提高区间查询的简洁性
    包含临界值
in
    提高语句简介度 = or
is null|is not null
    仅用于null的判断
*/
# ==============LIKE==================
# 查询员工姓名包含A的字符的员工信息
select *
from employees
where first_name like '%a%';#%代表通配符所有的意思
# 查询员工名称中第三个字符为e，第五个为a的员工名称和工资
select first_name,salary
from employees
where first_name like '__e_a%';
# 查询员工名中第二个字符为_的员工名 转义字符
select last_name
from employees
where last_name like '_\_%';
# 查询员工名中第二个字符为$的员工名 转义字符
select last_name
from employees
where last_name like '_$_%' escape '$';
# ==============BETWEEN AND==================
# 查询员工编号在100至120之间的员工信息
select *
from employees
where employee_id between 100 and 120;
# ==============IN==================
# 查询员工的工种编号是  IT_PROG,AD_VP,AD_PRES中的一个的员工工种和姓名
select last_name,job_id
from employees
where job_id in('IT_PROG','AD_VP','AD_PRES');
# ==============IS NULL==================
# 查询没有奖金的员工名称和奖金率
select
    last_name,commission_pct
from employees
where commission_pct is null;
# 查询有奖金的员工名称和奖金率
select
    last_name,commission_pct
from employees
where commission_pct is not null;
# 查询员工编号为176的员工的姓名和部门编号和年薪
# 住：使用IFNULL(COLUMN,PARAMS)函数
select
    last_name,
    department_id,
    salary*12*(1+ifnull(commission_pct,0)) 年薪
from
    employees
where
    employee_id=176;
# 工资小于18000且没奖金的姓名和工资
select
    last_name,salary
from employees
where
      commission_pct is null
      and salary < 18000;
# 查询员工表中job_id不为IT或者工资为12000的员工姓名
select
    last_name,job_id,salary
from employees
where
    job_id <> 'IT'
    or
    salary = 12000;
# 查看departments表结构
desc departments;
select distinct location_id
from departments;
# 查询部门编号大于等于90，按入职时间的先后排序
select *
from employees
where department_id >= 90
order by hiredate;
# 查询员工姓名和年薪并按年薪降序排序【自定义字段】,再按名字的长度排序
select
    salary*12*(1+ifnull(commission_pct,0)) as total,
    last_name
from employees
order by total desc ,length(last_name) desc;#降序
# 查询姓名，部门编号，按年薪降序。按名称升序
select
    salary*12*(1+ifnull(commission_pct,0)) as total,
    last_name,
    department_id
from employees
order by total desc ,last_name asc ;
# 选择工资不在8000到17000的员工的姓名和工资，按工资降序
select salary,last_name
from employees
where
      salary not between 8000 and 17000
        # not(salary between 8000 and 17000)
order by salary desc ;
# 查询邮箱中包含e的员工信息，并先按邮箱的字节数降序，再按部门号升序
select *
from employees
where email like '%e%'
order by length(email) desc ,department_id asc ;