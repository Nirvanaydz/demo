/**
  为排序使用索引：
  可以为查询和排序使用相同的索引
      key idx_a_b_c(a,b,c)
          order by
          -order by a
          -order by a,b
          -order by a,b,c
          -order by a desc,b desc,c desc
      where使用的索引列为常量时，则order by能使用索引
          -where a = const order by b,c
          -where a = const and b = const order by c
          -where a = const order by b,c
          -where a = const and b > const order by b,c
  提高order by 的速度
      1、使用order by 时切忌使用select *
      1.1、当查询字段总和大小小于max_length_for_sort_data而且排序字段不是text|blob类型，会用改进后的算法单路排序，否则用多路排序
      1.2、两种算法的数据超出sort_buffer的容量，会创建tmp文件进行合并排序，导致多次IO，但是使用单路排序算法的风险更大一下，
            所以要提高sort_buffer_size
      2、尝试提高sort_buffer_size
      3、尝试提高 max_length_for_sort_data
  */
# 开启慢日志查询的方式
# 显示参数，是否开启和慢日志查询的文件位置
show variables like '%slow_query_log%';
# 设置开启慢日志查询
set global slow_query_log = 1;
# 系统如何判断是慢查询，通过参数 long_query_time 来控制，大于设定的值的都是慢查询
show variables like '%long_query_time%';
# 通过 mysqldumpslow 指令来查询指定的慢查询日志
# 返回记录最多的是10个SQL mysqldumpslow -s r -t 10 .log
# 返回访问最多的是10个SQL mysqldumpslow -s c -t 10 .log
# 得到按照时间排序的、包含左连接的、前10条 数据 mysqldumpslow -s t -t 10 -g "left join" .log
select sleep(4);# 模拟慢查询