create database db0629;
use db0629;
create table `tbl_dept`(
    `id` int(11) not null auto_increment,
    `deptName` varchar(30) default null,
    `locAdd` varchar(40) default null,
    primary key (`id`)
)engine=innodb auto_increment=1 default charset=utf8;
create table `tbl_emp`(
    `id` int(11) not null auto_increment,
    `name` varchar(20) default null,
    `deptId` int(11) default null,
    primary key (`id`),
    constraint `fk_dept_id` foreign key (`deptId`) references `tbl_dept`(`id`)
)engine=innodb auto_increment=1 default charset=utf8;
insert into tbl_dept(deptName, locAdd) VALUES ('RD',11);
insert into tbl_dept(deptName, locAdd) VALUES ('HR',12);
insert into tbl_dept(deptName, locAdd) VALUES ('MK',13);
insert into tbl_dept(deptName, locAdd) VALUES ('MIS',14);
insert into tbl_dept(deptName, locAdd) VALUES ('FD',15);

INSERT INTO tbl_emp(name, deptId) VALUES ('z3',1);
INSERT INTO tbl_emp(name, deptId) VALUES ('z4',1);
INSERT INTO tbl_emp(name, deptId) VALUES ('z5',1);

INSERT INTO tbl_emp(name, deptId) VALUES ('w5',2);
INSERT INTO tbl_emp(name, deptId) VALUES ('w6',2);

INSERT INTO tbl_emp(name, deptId) VALUES ('s7',3);

INSERT INTO tbl_emp(name, deptId) VALUES ('s8',4);

INSERT INTO tbl_emp(name, deptId) VALUES ('s9',5);

alter table tbl_emp drop foreign key fk_dept_id;
update tbl_emp set deptId=51 where id=9;