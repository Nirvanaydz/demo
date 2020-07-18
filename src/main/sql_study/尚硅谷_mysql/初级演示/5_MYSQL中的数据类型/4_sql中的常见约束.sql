/**
  sql中的常见约束（创建表的时候）
  create table table_name(
    id int 约束
    )
  约束：一种限制表中列的数据的说明，保证数据的准确性和可靠性
    六大约束：
        NOT NULL        该字段不为空
        DEFAULT         该字段有默认值
        PRIMARY KEY     主键，该字段具有唯一性，并且非空
        UNIQUE          唯一性，可以为空
        CHECK           检查约束【mysql不支持】，用于对插入值的约束，符合才可以插入修改等，比如性别，年龄
        FOREIGN KEY     外键，用于限制两个表的关系，用于保证该字段的值必须来自于主表关联列的值
                        在从表中添加外键约束，用来关联主表的关联列的值
  添加约束的时机（数据未添加之时）：
    1、创建表时
    2、修改表时
  分类：
    列级约束：
        六大约束都支持，但是外键约束没有效果
    表级约束
        除了非空和默认，其他的都支持

  主键和唯一的对比
                唯一性     是否为空    在一个表的个数     是否允许组合(不推荐使用，多个列组合成一个，组合在一起一样时才不可以插入)
  primary key   √           x          0或1个          可以，组合主键
  unique        √           √          任意个数         可以，组合唯一键

  外键 foreign key
    1、要求从表设置外键关系
    2、从表的外键列的类型和主表的关联列的类型要求保持一致或者兼容，名称没有要求
    3、主表的关联列必须是一个key（一般是主键或者唯一键），从表中的被关联的键为主键或者唯一
    4、插入数据，先主表再从表，删除数据时，先删除从表再删除主表
  */
create database if not exists students;
use students;
# 1、创建表时添加约束
# 1.1、添加列级约束
# 创建从表
drop table if exists major;
create table major(
    id int primary key ,
    majorName varchar(20)
);
# 创建主表
create table stuInfo(
    id int primary key ,# 主键
    stuName varchar(20) not null ,#非空
    gender char(1) check ( gender = '男' or gender = '女'),# 检查
    seat int unique ,# 唯一约束 可为空
    age int default 18 ,# 默认约束
    majorID int references major(id) # 外键
);
desc stuInfo;
# 查看表的索引，默认主键外键，唯一性都会自动创建索引
show index from stuInfo;

# 1.2、创建表级约束
drop table if exists stuInfo;
create table stuInfo(
    # 先都不加表级约束
    id int ,# 主键
    stuName varchar(20) ,#非空
    gender char(1) ,# 检查
    seat int ,# 唯一约束 可为空
    age int ,# 默认约束
    majorID int , # 外键
    # 不起别名默认使用column_name
    constraint pk primary key (id),# 主键，主键名称默认都是primary
    constraint uq unique (seat),#唯一键
    constraint ck check ( gender = '男' or gender = '女'),# 检查，不生效，没什么用
    constraint fk_stuInfo_majorID foreign key (majorID) references major(id)# 外键
);
show index from students.stuInfo;

# 2、修改表时添加约束
create table stuInfo
(
    # 先都不加表级约束
    id      int,# 主键
    stuName varchar(20),#非空
    gender  char(1),# 检查
    seat    int,# 唯一约束 可为空
    age     int,# 默认约束
    majorID int
);
desc students.stuInfo;
# 改列级约束
alter table students.stuInfo modify column stuName varchar(20) not null ;
alter table students.stuInfo modify column stuName varchar(20) null ;
alter table students.stuInfo modify column age int default 19 ;
# 添加主键
# 列级添加法
alter table students.stuInfo modify column id int primary key ;
# 表级添加法
alter table students.stuInfo add primary key (id) ;
# 添加唯一键
alter table students.stuInfo modify column seat int unique ;
alter table students.stuInfo add unique (seat) ;
# 添加外键
alter table students.stuInfo add foreign key (majorID) references major(id) ;
alter table students.stuInfo add constraint fk_stuInfo_major foreign key (majorID) references major(id) ;
desc students.stuInfo;
show index from students.stuInfo;

# 3、删除约束
# 删除主键
alter table students.stuInfo drop primary key ;
# 删除唯一键，删除其索引
alter table students.stuInfo drop index seat;
# 删除外键
alter table students.stuInfo drop foreign key fk_stuInfo_major;