use company;
select 'Hello World!';
show Tables;
select * from department;
/*
concat to merge two column and use as to rename 
*/
select concat(fname,'  ',lname) as "whole name",address from employee