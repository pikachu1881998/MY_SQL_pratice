select '2021-09-02';

select 2021-09-02;
use company;


select fname, lname, address from employee where (dno=5 and salary > 30000) ;
select fname, lname, address, bdate from employee where '1964-01-01' < bdate and bdate < '1970-08-10';
select fname, lname, address from employee where lname like '%aya%' and lname not like '%aya'  ;
select fname, lname, salary + 0.1000*salary as raise from employee where dno = 5 ;
select sum(salary)  from employee where dno = 5;
select count(distinct salary) from employee ;
select count(*) from employee where superssn = 333445555;
select min(salary), avg(salary), max(salary), dno from employee group by dno;
select min(salary), avg(salary), max(salary), dno from employee group by dno having count(*)<4; 
select count(*) from dependent where relationship = 'Spouse' and bdate >='1958-05-03';

select count(*) from employee group by address like '%Houston%';
select essn, count(essn) from works_on group by essn; 
select count(*) from employee where address not like '%Houston%' group by salary >= 30000 ;
select count(*) from employee; 
select distinct salary from employee;
select dno, count(*) from employee where salary >25000 group by dno;
select fname, lname, address from employee where address like '%Dallas%';
select fname, lname, address from employee order by fname;
select fname, lname, address from employee order by lname desc;