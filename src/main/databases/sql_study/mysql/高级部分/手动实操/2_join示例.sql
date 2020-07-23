use db0629;
select * from tbl_emp a inner join tbl_dept b on a.deptId = b.id;

select * from tbl_emp a left join tbl_dept b on a.deptId = b.id;

select * from tbl_emp a right join tbl_dept b on a.deptId = b.id;

select * from tbl_emp a left join tbl_dept b on a.deptId = b.id
where b.id is null ;

select * from tbl_emp a right join tbl_dept b on a.deptId = b.id
where a.deptId is null ;

# select * from tbl_emp a full outer join tbl_dept b on a.deptId = b.id;
select * from tbl_emp a left join tbl_dept b on a.deptId = b.id
union
select * from tbl_emp a right join tbl_dept b on a.deptId = b.id;

# select * from tbl_emp a full outer join tbl_dept b on a.deptId = b.id where a.deptId is null or b.id is null;
select * from tbl_emp a left join tbl_dept b on a.deptId = b.id
where b.id is null
union # 联合查询并 去重
select * from tbl_emp a right join tbl_dept b on a.deptId = b.id
where a.deptId is null ;