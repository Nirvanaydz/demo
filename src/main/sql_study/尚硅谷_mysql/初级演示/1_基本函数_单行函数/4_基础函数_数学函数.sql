# 二、数学函数
/*
    round,ceil,floor,truncate,mod
*/
# round 绝对值取整后再添符号
SELECT ROUND(-1.23);
SELECT ROUND(-1.58);
SELECT ROUND(1.58);
SELECT ROUND(1.298, 1);
SELECT ROUND(1.298, 0);
SELECT ROUND(23.298, -1);
# ceil 向上取整，返回 >=该参数的最小整数
# floor 向下取整，返回 <=该参数的最大整数
select ceil(-1.02);
select floor(-9.99);
# 截断 Returns the number X, truncated to D decimal places.
SELECT TRUNCATE(1.223,1);
# 取余 mod(a,b) == a-a/b*b;
SELECT MOD(234, 10);
SELECT 253 % 7;
SELECT 29 MOD 9;
