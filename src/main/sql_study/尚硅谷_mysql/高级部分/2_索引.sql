/**
    查询语句
    索引失效
    join太多
    服务器参数设置，线程，内存大小等。。。
*/
# 创建sql表的某一个索引
create index idx_user_name on user(name);
-- 机器读取mysql时，
-- 先从from开始，on主表保留，
-- join where，
-- group by，having ，
-- select ,order by ,limit

select distinct
from
left_table join_type
join right_table on join_condition
where where_condition
group by group_by_list
having having_condition
order by order_by_condition
limit limit_number