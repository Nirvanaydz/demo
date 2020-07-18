/**
  sql中的数据类型---日期类型
  一、
    date 只显示日期
    time 只显示时间
    year 只显示年份
        时间+日期+年份都显示
    datetime    8字节     1000-9999       不受时区的影响
    timestamp   4字节     1970-2038       受时区的影响

  */
create table tab_date(
    t1 datetime,
    t2 timestamp
);
insert into tab_date values (now(),now());
select * from tab_date;
# 显示时区
show variables like 'time_zone';
# 设置时区
set time_zone = '+9:00';
set time_zone = 'system';
