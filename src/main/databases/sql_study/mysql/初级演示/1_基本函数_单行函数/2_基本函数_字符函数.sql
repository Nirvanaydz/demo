/*

length(),concat(),upper(),lower(),substring(),instr(),LPAD(),RPAD(),REPLACE()
长度，拼接，大小写，截取，索引，左右填充，替换
*/
# 常见函数（单行行数，分组函数|统计函数|聚合函数|组函数）
# 一、字符函数
# 获取参数值的字节个数
select length('yudazhi');
# 拼接函数concat
select concat(first_name,'_',last_name)
from employees;
# 大小写 upper lower
select concat(upper(first_name),lower(last_name))
from employees;
# 截取字符串 substr,substring
/*
mysql> SELECT SUBSTRING('Quadratically',5);
        -> 'ratically'
mysql> SELECT SUBSTRING('foobarbar' FROM 4);
        -> 'barbar'
mysql> SELECT SUBSTRING('Quadratically',5,6);
        -> 'ratica'
mysql> SELECT SUBSTRING('Sakila', -3);
        -> 'ila'
mysql> SELECT SUBSTRING('Sakila', -5, 3);
        -> 'aki'
mysql> SELECT SUBSTRING('Sakila' FROM -4 FOR 2);
        -> 'ki'
*/
# 截取字符指定索引处后面的所有字符substr(old,index)
select substr('abcdefg',4);
# 截取字符指定索引位置处的指定字符长度的字符substr(old,index,length)
select substr('abcdefghijk',4,3);
select
       concat(upper(substr(last_name,1,1)),lower(substr(last_name,2)))
from employees;
# 获取子串在大的字符串中索引位置
# Returns the position of the first occurrence of substring substr in string str
select instr('于达之学java','java');
# trim[去除首尾]  Returns the string str with all remstr prefixes or suffixes removed.
select trim('    aasasa     aaaaaa aaaaaaaaaa');
# 填充 lpad 用指定的字符实现左填充 至 指定长度
# Returns the string str:str, left-padded with the string padstr to a length of len characters.
# If str is longer than len:N, the return value is shortened to len characters.
SELECT LPAD('hi',1,'??');
SELECT LPAD('hi',5,'??sada');
# 填充 rpad 用指定的字符实现右填充 至 指定长度
# Returns the string str:str, right-padded with the string padstr to a length of len characters.
# If str is longer than len:N, the return value is shortened to len characters.
SELECT RPAD('hi',5,'?');
SELECT RPAD('hi',1,'?');
# replace Returns the string str with all occurrences of the string from_str replaced by the string to_str.
# REPLACE() performs a case-sensitive match when searching for from_str.
SELECT REPLACE('www.mysql.com', 'w', 'Ww') 'www.mysql.com';