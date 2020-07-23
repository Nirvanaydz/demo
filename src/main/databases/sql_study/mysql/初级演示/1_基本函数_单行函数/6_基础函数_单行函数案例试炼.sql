# 单行函数案例总结
# 1、显示系统时间（日期+时间）
select now();
# 2、查询工号，姓名，工资，以及工资提高20%之后的结果
select employee_id,last_name,salary, salary*1.2 as 'new salary'
from employees;
# 3、将员工姓名按首字母排序，并写出姓名的长度
select last_name,length(last_name),substr(last_name,1,1) as head_word
from employees
order by head_word;
# 4、字符拼接
select concat(last_name,' ','earns ',salary,' monthly ',' but want ',salary*3) as dream_salary
from employees;
# 5、case
select job_id JOB,
case job_id
when 'AD_PRES' THEN 'A'
when 'ST_MAN' THEN 'B'
when 'IT_PROG' THEN 'C'
ELSE 'D'
END AS GRADE
FROM employees
ORDER BY GRADE;
