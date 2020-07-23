/**
  流程控制：
    顺序结构 由上至下执行
    分支结构 选择某一个或者多个分支执行
    循环结构 满足循环条件的基础上重复执行一段代码

  一、分支结构：
      1.1、if函数
            if(condition,result_true,result_false)
            满足condition返回true，不满足返回false，类似于三目运算符
      1.2、case结构【用于等值判断java中switch或者区间判断java中的多重判断】
            1.2.1
                case 变量|表达式|字段
                when 要判断的值1 then 返回的值1
                when 要判断的值2 then 返回的值2
                ...
                else 要判断的值3 then 返回的值3
                end
            1.2.2
                case 变量|表达式|字段
                when 要判断的条件1 then 返回的值1
                when 要判断的条件2 then 返回的值2
                ...
                else 要判断的条件3 then 返回的值3
                end
      1.3、if结构【只能用于begin end中】
            if 条件1 then 语句1
            elseif 条件2 then 语句2
            elseif 条件3 then 语句3
            elseif 条件n then 语句n
            【else  语句默认，不写返回null】
            end if;
  二、循环结构
  while|loop|repeat
  循环控制关键字：
        iterate 等价于java循环中的continue 结束本次循环，开始下一次
        leave   等价于java中的break 跳出此循环
    1、语法说明
        【标签:】while 循环条件 do
                    循环体;
                end while【标签】;
  */
# 根据传入的成绩，来显示等级，创建存储过程
delimiter $
create procedure test_case01(in score int)
begin
    case
    when score<=100 and score>=90 then select 'A';
    when score>=80 then select 'B';
    when score>=60 then select 'C';
    else select 'D';
    end case ;
end $
call test_case01(89)$

create function test_if(score int) returns char
begin
    if score<=100 and score>=90 then return 'A';
    elseif score>=80 then return 'B';
    elseif score>=60 then return 'C';
    else return 'D';
    end if;
end $
select test_if(95)$

# 循环插入
delimiter $
drop procedure pro_while1$
create procedure pro_while1(in counts int)
begin
    declare i int default 0;
    while i<counts do
        insert into admin(username, password) values (concat('Rose',i),666);
        set i = i+1;
        end while;
end $
call pro_while1(100)$
select * from admin$

delimiter $
create procedure pro_while2(in counts int)
begin
    declare i int default 0;
    a:while i<counts do
        insert into admin(username, password) values (concat('Xiaohua',i),666);
        if i>=20 then leave a;
        end if;
        set i = i+1;
    end while a;
end $
call pro_while2(100)$
select * from admin$

# 编写一个只插入偶数次的存储过程
# 向一个表中插入指定个数的随机字符串