/**
  变量
    系统变量
        全局变量 服务器每次启动后针对所有的session都有效，不可以跨服务器
        会话变量 仅针对于当前的session(连接)有效
    自定义变量 声明、赋值、使用
        用户变量 针对于当前session有效，与session变量的作用域一致
        局部变量 仅在定义其的begin end 中有效
            declare 变量名称 类型;
            declare 变量名称 类型 default 默认值;

  */
# 一、系统变量
# 查看
show variables ;# 也是查看session变量
show global variables ;
show global variables like 'a%';
show session variables like '%char%';
# 查看具体的某个变量名称
select @@global.tx_isolation;
select @@session.autocommit;
# 设置变量
set @@global.tx_isolation = 'read committed';

# 二、自定义变量 声明、赋值、使用
# 用户变量赋值，必须加@不需要声明，可以随意更改已定义的用户变量的类型和值
set @ydz='ydz';
set @mimi:='mimi';
select @fanTuan:='fanTuan';
# select department_id into @变量名称 from departments;
select department_id into @id_set_param from departments;
# 局部变量设置声明时需要指定类型，可以不加@
# begin
#     declare name int;
# end;

set @m = 1;
set @n = 2;
set @sum = @m + @n;
select @sum;

