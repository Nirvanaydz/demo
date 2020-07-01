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
        外连接 主表和从表，一般使用连接条件字段为空的来筛选数据
            ☆左外连接 left 【outer】 左边是主表
            ☆右外连接 right 【outer】右边是主表
            全外连接 full 【outer】 内连接查询+表1中没有且表2中有+表2中没有且表1中有的
        交叉连接 cross
*/
# 外连接：多使用与用于查询一个表中有，一个表中没有的
# 查询出的结果为主表中的所有记录，外加从表中没有的记录
select *
from employees e
         left join departments d on e.department_id = d.department_id
where e.department_id is null ;
# 查询哪个部门没有员工
select d.department_id,d.department_name
from departments d
         left join employees e on d.department_id = e.department_id
where e.employee_id is null;
# 查询哪个城市没有部门
select l.city,d.*
from locations l
         left join departments d on l.location_id = d.location_id
where d.department_id is null ;
# 查询部门名称为sal或者it的员工信息[有的部门可能没有员工]
select d.department_id,d.department_name,e.*
from departments d
         left join employees e on e.department_id = d.department_id
where d.department_name in ('SAL','IT');


