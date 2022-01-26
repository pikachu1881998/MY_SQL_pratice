-- CS4400: Introduction to Database Systems
-- Company ANSWER KEY (v3 - Actual Queries for Book and Other Practice Problems)
-- Wednesday, December 23, 2020

-- [Tue, 19 May 2020: Fixed practice query 51 / Reversed the order of the first and last names]
-- [Sat, 23 May 2020: Fixed practice queries 25-27 / Switched project number & name columns]

drop view if exists practiceQuery0;
create view practiceQuery0 as 
select bdate, address from employee where fname = 'John' and lname = 'Smith';

drop view if exists practiceQuery1;
create view practiceQuery1 as 
select fname, lname, address from employee where dno in (select dnumber from department where dname = 'Research');

drop view if exists practiceQuery2;
create view practiceQuery2 as 
select pnumber, dnum, lname, address, bdate from project, department, employee where dnum = dnumber and mgrssn = ssn and plocation = 'Stafford';

drop view if exists practiceQuery3;
create view practiceQuery3 as
select fname, lname from employee
where not exists (select pnumber from project where dnum = 5
and pnumber not in (select pno from works_on where ssn = essn));

/*
-- Alternate Approach to practiceQuery3
select fname, lname from employee where ssn in
(select essn from works_on where pno in (select pnumber from project where dnum = 5)
group by essn
having count(distinct pno) >= (select count(distinct pnumber) from project where dnum = 5));
*/

drop view if exists practiceQuery4;
create view practiceQuery4 as 
(select pno from works_on, employee where essn = ssn and lname = 'Smith') union
(select pnumber from project, department, employee where dnum = dnumber and mgrssn = ssn and lname = 'Smith');

drop view if exists practiceQuery5;
create view practiceQuery5 as 
select fname, lname from employee where ssn in
(select essn from dependent group by essn having count(*) >= 2);

drop view if exists practiceQuery6;
create view practiceQuery6 as 
select fname, lname from employee where ssn not in
(select essn from dependent);

drop view if exists practiceQuery7;
create view practiceQuery7 as 
select fname, lname from employee where ssn in (select essn from dependent)
and ssn in (select mgrssn from department);

drop view if exists practiceQuery8;
create view practiceQuery8 as 
select tableA.fname as A_fname, tableA.lname as A_lname, tableB.fname as B_fname, tableB.lname as B_lname
from employee as tableA left outer join employee as tableB on tableA.superssn = tableB.ssn;

drop view if exists practiceQuery9;
create view practiceQuery9 as 
select ssn from employee;

drop view if exists practiceQuery10;
create view practiceQuery10 as 
select ssn, dname from employee, department;

drop view if exists practiceQuery11;
create view practiceQuery11 as 
select distinct salary from employee;

drop view if exists practiceQuery12;
create view practiceQuery12 as 
select fname, lname from employee where address like '%Houston TX%';

drop view if exists practiceQuery13;
create view practiceQuery13 as 
select fname, lname, salary from employee where ssn not in
(select essn from works_on, project where pno = pnumber and pname = 'ProductX')
union
select fname, lname, salary * 1.10 from employee where ssn in
(select essn from works_on, project where pno = pnumber and pname = 'ProductX');

drop view if exists practiceQuery14;
create view practiceQuery14 as 
select * from employee where dno = 5 and salary between 30000 and 40000;

drop view if exists practiceQuery15;
create view practiceQuery15 as 
select dname, lname, fname, pname from department, employee, project
where dnumber = dno and dno = dnum order by dname, lname, fname;

drop view if exists practiceQuery16;
create view practiceQuery16 as 
select distinct fname, lname from employee, dependent
where ssn = essn and fname = dependent_name and employee.sex = dependent.sex;

drop view if exists practiceQuery17;
create view practiceQuery17 as 
select ssn from employee where ssn in (select essn from works_on where pno in (1, 2, 3));

drop view if exists practiceQuery18;
create view practiceQuery18 as 
select fname, lname from employee where superssn is null;

drop view if exists practiceQuery19;
create view practiceQuery19 as 
select sum(salary), max(salary), min(salary), avg(salary) from employee;

drop view if exists practiceQuery20;
create view practiceQuery20 as 
select sum(salary), max(salary), min(salary), avg(salary) from employee where dno in
(select dnumber from department where dname = 'Research');

drop view if exists practiceQuery21;
create view practiceQuery21 as 
select count(*) from employee;

drop view if exists practiceQuery22;
create view practiceQuery22 as 
select count(*) from employee where dno in
(select dnumber from department where dname = 'Research');

drop view if exists practiceQuery23;
create view practiceQuery23 as 
select count(distinct salary) from employee;

drop view if exists practiceQuery24;
create view practiceQuery24 as 
select dnumber, count(ssn), avg(salary) from department, employee where dnumber = dno group by dnumber
union (select dnumber, 0, 0 from department where dnumber not in (select dno from employee));

drop view if exists practiceQuery25;
create view practiceQuery25 as 
select pnumber, pname, count(distinct essn) from project left outer join works_on
on pnumber = pno group by pname, pnumber;

drop view if exists practiceQuery26;
create view practiceQuery26 as 
select pnumber, pname, count(distinct essn) from project left outer join works_on
on pnumber = pno group by pname, pnumber having count(distinct essn) > 2;

drop view if exists practiceQuery27;
create view practiceQuery27 as 
select pnumber, pname, count(distinct essn) from project left outer join
(select essn , pno from works_on where essn in (select ssn from employee where dno = 5)) as temp
on pnumber = pno group by pname, pnumber;

drop view if exists practiceQuery28;
create view practiceQuery28 as 
select dno, count(ssn) from employee where salary > 25000 and dno in
(select dno from employee group by dno having count(ssn) < 4) group by dno;

drop view if exists practiceQuery29;
create view practiceQuery29 as 
select * from employee where dno = 5;

drop view if exists practiceQuery30;
create view practiceQuery30 as 
select * from employee, department where dno = dnumber;

drop view if exists practiceQuery31;
create view practiceQuery31 as 
select fname, lname, bdate from employee where bdate between '1950-01-01' and '1959-12-31';

drop view if exists practiceQuery32;
create view practiceQuery32 as 
select fname, lname from employee where dno = 5 and ssn in (select essn from works_on where pno in
(select pnumber from project where pname = 'ProductX') group by essn having sum(hours) > 10);

drop view if exists practiceQuery33;
create view practiceQuery33 as 
select fname, lname from employee, dependent where ssn = essn and fname = dependent_name;

drop view if exists practiceQuery34;
create view practiceQuery34 as 
select fname, lname from employee
where superssn = (select ssn from employee where fname = 'Franklin' and lname = 'Wong');

drop view if exists practiceQuery35;
create view practiceQuery35 as 
select fname, lname from employee where dno in
(select dno from employee group by dno having max(salary) >= (select max(salary) from employee));

drop view if exists practiceQuery36;
create view practiceQuery36 as 
select fname, lname from employee where superssn in
(select ssn from employee where superssn = '888665555');

drop view if exists practiceQuery37;
create view practiceQuery37 as 
select fname, lname from employee where salary >= (select min(salary) from employee) + 10000;

drop view if exists practiceQuery40;
create view practiceQuery40 as 
select 'Hello World!';

drop view if exists practiceQuery41;
create view practiceQuery41 as 
select 'Hello World!' as 'greeting';

drop view if exists practiceQuery42;
create view practiceQuery42 as 
select 4 + 6;

drop view if exists practiceQuery43;
create view practiceQuery43 as 
select 4 + 6 as 'my_sum', 3 * 7 as 'my_product', 9 - 5 as 'my_difference';

drop view if exists practiceQuery44;
create view practiceQuery44 as 
select * from employee;

drop view if exists practiceQuery50;
create view practiceQuery50 as 
select fname, lname, address from employee;

drop view if exists practiceQuery51;
create view practiceQuery51 as 
select lname as 'Last Name', fname as 'First Name', address as 'Residence Location' from employee;

drop view if exists practiceQuery52;
create view practiceQuery52 as 
select concat(fname, ' ', lname) as 'Whole Name', address from employee;

drop view if exists practiceQuery53;
create view practiceQuery53 as 
select dno from employee;

drop view if exists practiceQuery54;
create view practiceQuery54 as 
select distinct dno from employee;

drop view if exists practiceQuery55;
create view practiceQuery55 as 
select salary, dno from employee;

drop view if exists practiceQuery56;
create view practiceQuery56 as 
select distinct salary, dno from employee;

drop view if exists practiceQuery60;
create view practiceQuery60 as 
select fname, lname, address from employee where dno = 5;

drop view if exists practiceQuery61;
create view practiceQuery61 as 
select fname, lname, address from employee where dno <> 5;

drop view if exists practiceQuery62;
create view practiceQuery62 as 
select fname, lname, address from employee where salary > 30000;

drop view if exists practiceQuery63;
create view practiceQuery63 as 
select fname, lname, address from employee where dno = 5 or salary > 30000;

drop view if exists practiceQuery64;
create view practiceQuery64 as 
select fname, lname, address from employee where dno = 5 and salary > 30000;

drop view if exists practiceQuery65;
create view practiceQuery65 as 
select fname, lname, address, bdate from employee where bdate > '1968-01-01';

drop view if exists practiceQuery66;
create view practiceQuery66 as 
select fname, lname, address, bdate from employee where bdate > '1964-01-01' and bdate < '1970-08-10';

drop view if exists practiceQuery67;
create view practiceQuery67 as 
select fname, lname, address from employee order by fname;

drop view if exists practiceQuery68;
create view practiceQuery68 as 
select fname, lname, address from employee order by lname desc;

drop view if exists practiceQuery69;
create view practiceQuery69 as 
select fname, address from employee order by lname desc;

drop view if exists practiceQuery70;
create view practiceQuery70 as 
select fname, lname, address from employee order by lname, fname;

drop view if exists practiceQuery71;
create view practiceQuery71 as 
select fname, lname, address from employee where address like '%Houston%';

drop view if exists practiceQuery72;
create view practiceQuery72 as 
select fname, lname, address from employee where address like '%Dallas%';

drop view if exists practiceQuery73;
create view practiceQuery73 as 
select fname, lname, address from employee where fname like 'J%';

drop view if exists practiceQuery74;
create view practiceQuery74 as 
select fname, lname, address from employee where lname like '%aya%';

drop view if exists practiceQuery75;
create view practiceQuery75 as 
select fname, lname, address from employee where lname like '%aya_%';

drop view if exists practiceQuery80;
create view practiceQuery80 as 
select fname, lname, salary + (salary * 1/10) as 'raise' from employee where dno = 5;

drop view if exists practiceQuery81;
create view practiceQuery81 as 
select sum(salary) from employee where dno = 5;

drop view if exists practiceQuery82;
create view practiceQuery82 as 
select min(salary), max(salary) from employee where dno = 5;

drop view if exists practiceQuery83;
create view practiceQuery83 as 
select count(distinct salary) from employee;

drop view if exists practiceQuery84;
create view practiceQuery84 as 
select count(distinct superssn) from employee;

drop view if exists practiceQuery85;
create view practiceQuery85 as 
select count(*) from employee where superssn = 333445555;

drop view if exists practiceQuery86;
create view practiceQuery86 as 
select count(*) from employee where superssn <> 333445555;

drop view if exists practiceQuery87;
create view practiceQuery87 as 
select count(*) from employee;

drop view if exists practiceQuery88;
create view practiceQuery88 as 
select dno, min(salary), avg(salary), max(salary) from employee group by dno;

drop view if exists practiceQuery89;
create view practiceQuery89 as 
select dno, min(salary), avg(salary), max(salary) from employee group by dno having count(*) < 4;

drop view if exists practiceQuery100;
create view practiceQuery100 as 
select dno, count(*) from employee where salary > 25000 group by dno;

drop view if exists practiceQuery101;
create view practiceQuery101 as 
select dno, count(*) from employee where salary > 25000 and dno not in
(select dnumber from department where dname = 'Headquarters') group by dno;

drop view if exists practiceQuery102;
create view practiceQuery102 as 
select dno from employee group by dno having count(*) < 4;

drop view if exists practiceQuery103;
create view practiceQuery103 as 
select dno, count(*) from employee where salary > 25000
and dno in (select dno from employee group by dno having count(*) < 4)
group by dno;

drop view if exists practiceQuery104;
create view practiceQuery104 as 
select fname, lname, address from employee where ssn in
(select essn from dependent where relationship = 'Daughter');

drop view if exists practiceQuery105;
create view practiceQuery105 as 
select fname, lname, address from employee where ssn in
(select essn from works_on where pno in
(select pnumber from project where plocation = 'Houston'));

drop view if exists practiceQuery106;
create view practiceQuery106 as 
(select ssn from employee where salary > 25000) union
(select essn from works_on where pno = 20);

drop view if exists practiceQuery107;
create view practiceQuery107 as 
select ssn from employee where salary > 25000 and ssn in
(select essn from works_on where pno = 20);

drop view if exists practiceQuery108;
create view practiceQuery108 as 
select ssn from employee where salary > 25000 and ssn not in
(select essn from works_on where pno = 20);

drop view if exists practiceQuery120;
create view practiceQuery120 as 
select fname, lname, address, dno, dnumber, dname from employee, department;

drop view if exists practiceQuery121;
create view practiceQuery121 as 
select fname, lname, address, dname, dno from employee, department where dno = dnumber;

drop view if exists practiceQuery122;
create view practiceQuery122 as 
select fname, lname, address, dname, dno from employee join department on dno = dnumber;

drop view if exists practiceQuery123;
create view practiceQuery123 as 
select fname, lname, address, dname, dno from employee natural join
(select dname, dnumber as dno from department) as temp;

drop view if exists practiceQuery124;
create view practiceQuery124 as 
select worker.fname as work_fname, worker.lname as work_lname, worker.address, worker.superssn, supervisor.fname, supervisor.lname
from employee as worker left outer join employee as supervisor on worker.superssn = supervisor.ssn;

drop view if exists practiceQuery125;
create view practiceQuery125 as 
select dependent_name, dependent.bdate, fname, lname from dependent right outer join employee on essn = ssn;

drop view if exists practiceQuery126;
create view practiceQuery126 as 
select fname, lname, dname, dnumber from employee join department on ssn = mgrssn;

drop view if exists practiceQuery127;
create view practiceQuery127 as 
select fname, lname, dno, dname from employee left outer join department on ssn = mgrssn;

drop view if exists practiceQuery128;
create view practiceQuery128 as 
select fname, lname, address, pname, plocation from employee join project
on locate(plocation,address) > 0;

drop view if exists practiceQuery129;
create view practiceQuery129 as 
select worker.fname as work_fname, worker.lname as work_lname, worker.bdate as work_bdate, supervisor.fname, supervisor.lname, supervisor.bdate
from (employee as worker) join (employee as supervisor) on worker.bdate < supervisor.bdate
where supervisor.ssn in (select mgrssn from department);
