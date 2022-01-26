use company;

select pnumber, dnum, lname, address,bdate from employee join department on superssn = mgrssn join project on dno = dnum
where dno in (select dnum from project where plocation = "Stafford") and dnumber = 1;

select fname, lname from employee
where not exists (select pnumber from project where dnum = 5
and pnumber not in (select pno from works_on where ssn = essn));

(select pno from works_on, employee where essn = ssn and lname = 'Smith')
 union
(select pnumber from project, department, employee where dnum = dnumber and mgrssn = ssn and lname = 'Smith');

select fname, lname from employee where ssn in (select essn from dependent group by essn having count(*) >= 2);


select fname, lname from employee where ssn not in (select essn from dependent);

select fname, lname from employee join department on ssn=mgrssn where ssn in (select essn from dependent group by essn having count(*) >= 1);

select tableA.fname as A_fname, tableA.lname as A_lname, tableB.fname as B_fname, tableB.lname as B_lname
from employee as tableA left outer join employee as tableB on tableA.superssn = tableB.ssn;

select pnumber, pname, count(distinct essn) from project left outer join works_on
on pnumber = pno group by pname, pnumber;

select fname, lname, address from employee join dependent on ssn=essn where ssn in (select essn from dependent where sex = 'F') group by ssn;

select fname, lname from employee where superssn in 
(select ssn from employee where superssn = '888665555');

select dno, count(ssn) from employee where salary > 25000 and dno in 
(select dno from employee group by dno having count(ssn)<4) group by dno;

select ssn from employee left outer join works_on on ssn =essn where salary > 25000 and pno = 20;

select dno,count(ssn) from employee where salary > 25000 group by dno;

select dno,count(*) from employee where salary > 25000 and dno not in (select dnumber from department where dname = "Headquarters") group by dno;

select dno from employee group by dno having count(ssn) < 4;

select dno,count(*) from employee where salary>25000 and dno in (select dno from employee group by dno having count(ssn) < 4) group by dno;

select fname, lname, address from employee join dependent on ssn = essn where ssn in (select essn from dependent where relationship = 'Daughter') group by ssn;

select fname, lname, address from employee, project,works_on where ssn in (select essn from works_on where pno in (select pnumber from project where plocation = "Houston")) group by ssn;

(select ssn from employee where salary > 25000)
union
(select essn from works_on where pno =20);

select ssn from employee where ssn in (select essn from works_on where pno =20);

select ssn from employee where salary>25000 and ssn not in (select essn from works_on where pno =20);

select fname, lname, address,dno,dnumber,dname from employee, department;

select fname, lname, address,dnumber,dname from employee join department on dno = dnumber;
select fname, lname, address,dno from employee natural join (select dname, dnumber as dno from department) as temp ;
select worker.fname as work_fname, worker.lname as work_lname, worker.address, worker.superssn, supervisor.fname, supervisor.lname
from employee as worker left outer join employee as supervisor on worker.superssn = supervisor.ssn;

select dependent_name, dependent.bdate, fname, lname from dependent right outer join employee on essn = ssn;

select fname, lname, dname,dnumber from employee, department where ssn = mgrssn group by ssn;

select fname, lname, dno, dname from employee left outer join department on mgrssn = ssn;

select fname, lname, address, pname, plocation from employee join project
on locate(plocation,address) > 0;

select worker.fname as work_fname, worker.lname as work_lname, worker.bdate as work_bdate, supervisor.fname, supervisor.lname, supervisor.bdate
from (employee as worker) join (employee as supervisor) on worker.bdate < supervisor.bdate
where supervisor.ssn in (select mgrssn from department);

select fname, lname, address from employee where dno in (select dnumber from department where dname = "Research");

select pnumber, dnum, lname, address, bdate from project, employee, department where dnum  = dno and mgrssn = ssn and plocation  = "Stafford";

select pno from works_on, employee where ssn = essn and lname = "Smith"; 

select fname, lname from employee, dependent where ssn = essn group by essn having count(essn)>2;

select fname, lname from employee where ssn not in (select essn from dependent) ;

select fname, lname from employee where ssn in (select mgrssn from department) and  ssn in (select essn from dependent);

select employee.fname, employee.lname, supervisor.fname, supervisor.lname 
from employee left outer join (select * from employee) as supervisor on employee.superssn = supervisor.ssn;

select ssn from employee;

select ssn, dname from employee, department order by dname;

select distinct(salary) from employee;

select fname, lname from employee where address like '%Houston TX%';

select fname, lname, salary from employee where ssn not in
(select essn from works_on, project where pno = pnumber and pname = 'ProductX')
union
select fname, lname, salary * 1.10 from employee where ssn in
(select essn from works_on, project where pno = pnumber and pname = 'ProductX');

select * from employee where dno = 5 and salary >=30000 and salary<=40000;

select dname, fname, lname, pname from project, department, employee where dnumber = dno and dno = dnum order by lname, fname;

select fname, lname from employee, dependent where ssn=essn and fname = dependent_name and employee.sex = dependent.sex;

select essn from works_on where pno in(1,2,3) group by essn;

select fname, lname from employee where superssn is null;

select dnumber, count(ssn), avg(salary) from department, employee where dnumber = dno group by dnumber;

select pnumber, pname, count(distinct essn) from project left outer join works_on on pnumber = pno group by pnumber, pname having count(distinct essn) >2;

select pnumber, pname, count(distinct essn) from project left outer join works_on on pnumber = pno where dnum = 5 ;


select last_name,first_name,address,birthdate from  users, employees,customers where users.uname = employees.uname and employees.uname = customers.uname and service>10 and credit <150;


select storeID, droneTag, remaining_trips,capacity from drones,employees where pilot = uname and hired < "2021-01-01";

(select storeID,revenue,0 from stores);

select taxID,hired,salary,table1.storeID,table1.revenue from employees,floor_workers,users,(select storeID,revenue from stores) as table1 where users.uname = employees.uname and employees.uname = floor_workers.uname and year(users.birthdate) < 1973 group by storeID ;

select taxID,hired,salary, stores.storeID, stores.revenue from employees,users,employed_workers join stores on employed_workers.storeID = stores.storeID where users.uname = employees.uname and employees.uname = employed_workers.uname and stores.manager = employed_workers.uname and year(users.birthdate) < 1973;


