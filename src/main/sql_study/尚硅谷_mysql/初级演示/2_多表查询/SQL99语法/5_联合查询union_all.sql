# 联合查询：将多条查询语句的结果合并为一个结果
# 多使用在不同的表之间的联合查询，各个表查询结果的结构一致，可以联合显示
# 查询员工编号大于90或者邮箱包含a的员工信息
select * from employees
where department_id>90
or email like '%a%';

select * from employees where department_id>90
union
select * from employees where email like '%a%';

# 需要注意的事项：结果格式必须一致，联合查询会去重（使用关键字ALL可以不去重）