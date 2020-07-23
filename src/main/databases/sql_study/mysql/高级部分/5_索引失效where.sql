/**
  where条件的说明
      1、全职匹配我最爱
      2、最佳左前原则
      3、不要在索引列上做操作（计算，函数，自动或者手动类型转换），会导致索引失效而转向全表扫描
      4、尽量使用覆盖索引，少使用select * 查询
      5、不要使用 != 或者 <>
      6、is null 和 is not null 也会导致索引失效
      7、like通配符开头会导致索引失效而转向全表扫描 %abc
      8、字符串不加单引号会造成MySQL自动转型，造成索引失效
      9、使用or时会使or后面的语句索引失效
  */
use db0629;
create table `tbl_user`(
    id int(11) not null auto_increment,
    name varchar(20) default null,
    age int(11) default null,
    email varchar(20) default null,
    primary key (id)
)engine = INNODB AUTO_INCREMENT=1 DEFAULT CHARSET = utf8;
insert into tbl_user(name, age, email) VALUES ('1aa1',21,'b@163.com');
insert into tbl_user(name, age, email) VALUES ('2aa2',222,'a@163.com');
insert into tbl_user(name, age, email) VALUES ('3aa3',265,'c@163.com');
insert into tbl_user(name, age, email) VALUES ('4aa4',24,'d@163.com');