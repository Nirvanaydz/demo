/**
  sql中的数据类型---数值类型
  一、整型（掌握一种int即可）
  分类：所占字节数：1byte、2byte、3byte、4byte、8byte
    tinyint-->smallint-->mediumint-->int/integer-->bigint
  特点：
    1、默认有正负值，默认长度就是类型的所占字节数，
        而int(num)中的num代表其显示的值的长度，必须搭配zerofill使用，进行零填充，也变成了无符号
    2、使用unsigned标记，说明整型字段无符号

  二、小数（主要使用float区间小，decimal精度高）
  分类：
    浮点型：float(m,d)、double(m,d)
    定点型：dec(m,d)、decimal(m,d)
    d：小数点后的位数，不符合准则，四舍五入
    m：整数位和小数位的总长度，超出准则，插入临界值
    省略后：
        decimal代表decimal(10,0)
        float,double则是与插入的值对应即可
  */

# 1、如何设置无符号和有符号
use books;
drop table if exists tab_int;
create table tab_int(
                        t1 int,         # 默认是有符号，有正负值
                        t2 int unsigned # unsigned 表示标记无符号，从0开始
);
desc tab_int;
insert into tab_int values (-12345);
# Out of range value for column 't2' at row 1
insert into tab_int values (-12345,-123);
# 2、小数型实验
drop table if exists tab_float;
create table tab_float(
                          f1 float,
                          d1 double,
                          d2 decimal
);
desc tab_float;
