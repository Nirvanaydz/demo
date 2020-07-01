/*
    分页查询 ☆
    应用场景：10000行数据先显示某一页的结果
    语法：
        select .....
        limit offset,size;
            offset：要显示条目的起始索引（若是省略，默认从0开始）
            size：要显示的条目个数

*/
# 查询前五条的员工信息
select * from employees limit 0,5;
# 查询第11条到第25条的数据
select * from employees limit 10,15;
# 查询有奖金的工资较高的前10名
select * from employees
where commission_pct is not null
order by salary desc
limit 0,10;