# 补充：其他函数
select version(),database(),user();
# 五、流程控制函数
# if函数可类比Java中的三目运算符
select if(10>5,'a','b');
select last_name,commission_pct,if(commission_pct is null ,'没奖金！呵呵','有奖金，嘻嘻') as 备注
from employees;

# case 函数
# 1、switch case 函数【多使用于等值判断】
/*
    case 要判断的字段或者表达式
    when 常量1 then 要显示的值1或者语句1
    when 常量2 then 要显示的值2或者语句3
    when 常量3 then 要显示的值3或者语句3
    ···
    else 要显示的默认值n
    end
*/
#案例：查询员工工资，要求，
# 部门号=30，显示工资的1.1倍
# 部门号=40，显示工资的1.2倍
# 部门号=50，显示工资的1.1倍
select salary 原始工资,department_id,
case department_id
when 30 then salary*1.1
when 40 then salary*1.2
when 50 then salary*1.3
else salary
end as 最终工资
from employees
order by department_id;
# 2、多重if
/*
    case
    when 常量1 then 要显示的值1或者语句1
    when 常量2 then 要显示的值2或者语句3
    when 常量3 then 要显示的值3或者语句3
    ···
    else 要显示的默认值n
    end
*/
# 案例二：查询工资的情况
# 如果工资大于20000，显示A级别
# 如果工资大于15000，显示B级别
# 如果工资大于10000，显示C级别
# 否则，显示D级别
select salary as 原始工资,
case
    when salary>20000 then 'A'
    when salary>15000 and salary <=20000 then 'B'
    when salary>10000 and salary <=15000 then 'C'
    else 'D'
end as 工资级别
from employees;