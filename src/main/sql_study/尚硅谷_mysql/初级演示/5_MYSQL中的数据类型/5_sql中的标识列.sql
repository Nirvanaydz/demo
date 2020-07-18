/**
  sql中的标识列
  自增长列
  特点：
    1、必须是一个key（主键，唯一，外键）
    2、一个表中只可以有一个自增长列
    3、标识列的类型只能是数值类型，一般是int型
    4、通过show方法显示设置
    5、符合修改列级约束的语法
  */
use students;
create table tab_identity(
    id int primary key auto_increment ,
    name varchar(20)
);
insert into tab_identity(name) values ('dzyu');
# 获取自增长变量，只可以设置步长auto_increment_increment，起始值auto_increment_offset不可更改
show variables like '%auto_increment%';
# 设置步长
set auto_increment_increment = 3;