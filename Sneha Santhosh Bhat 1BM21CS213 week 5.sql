create database sneha_employee1;
use sneha_employee1;

create table dept
(deptno char(10),
dname char(10),
dloc char(10),
primary key(deptno)
);

create table employee
(empno char(10),
ename char(10),
mgr_no char(10),
hiredate char(10),
sal int(10),
deptno char(10),
primary key(empno),
foreign key(deptno) references dept(deptno) on delete cascade
);

create table project
(pno int(10),
ploc char(10),
pname char(10),
primary key(pno)
);

create table assigned_to
(empno char(10),
pno int(10),
job_role char(10),
primary key(empno, pno),
foreign key(empno) references employee(empno) on delete cascade,
foreign key(pno) references project(pno) on delete cascade
);

create table incentives
(empno char(10),
incentive_date char(10),
incentive_amount char(10),
primary key(empno,incentive_date),
foreign key(empno) references employee(empno) on delete cascade
);

insert into dept values('1','LIB','PJ1'),('2','FIR','PJ2'),('3','ECE','PJ3'),('4','CSE','PJ4'),('5','ISE','PJ4'),
('6','ETE','PJ6'),('7','AIML','PJ7');

select * from dept;

insert into employee values('1','Rahul','2','29-07-2019','50000','2'),('2','Naina','5','05-04-2020','20000','4'),
('3','Raj','3','16-09-2018','60000','3'),('4','Mira','1','14-12-2019','5000','5'),('5','Tina','4','06-01-2020','10000','7'),
('6','Nisha','3','27-06-2018','30000','3'),('7','Raksha','5','09-08-2021','8000','6');

select * from employee;

insert into project values('1','Delhi','Apple'),('2','Bengaluru','Infosys'),('3','Kerala','Microsoft'),
('4','Chennai','Accenture'),('5','Gujarat','Tata'),('6','Hyderabad','HP'),('7','Mumbai','Google');

select * from project;

insert into assigned_to values('1','2','Design'),('2','7','Marketing'),('3','1','Sales'),('4','5','Intern'),
('5','3','Guide'),('6','4','PR'),('7','6','HR');

select * from assigned_to;

insert into incentives values('1','30-12-2019','5000'),('2','12-10-2020','10000'),('3','25-12-2019','8000'),
('4','04-06-2021','1200'),('6','31-08-2019','10000');

select * from incentives;

select e.empno
from employee e, project p, assigned_to a
where p.ploc in('Mysuru','Bengaluru','Hyderabad') and p.pno=a.pno and a.empno=e.empno;

select e.empno
from employee e
where e.empno not in (select empno from incentives);

update dept set dloc='Mysuru' where deptno='1';
update dept set dloc='Bengaluru' where deptno='2';
update dept set dloc='Hubli' where deptno='3';
update dept set dloc='Mumbai' where deptno='4';
update dept set dloc='Udupi' where deptno='5';

select e.ename, e.empno, d.deptno, d.dname, a.job_role, d.dloc, p.ploc
from employee e, dept d, assigned_to a, project p
where p.ploc=d.dloc and e.empno=a.empno and e.deptno=d.deptno and p.pno=a.pno;

update incentives set incentive_date='25-12-2021' where empno='3';

select distinct e.ename,d.dname,a.job_role
from employee e, dept d, assigned_to a, incentives i
where e.empno=a.empno and e.empno=i.empno and e.deptno=d.deptno and i.incentive_amount=(select max(incentive_amount) from incentives i where i.incentive_date between '01-01-2021' and '31-12-2021');

update employee set mgr_no='3' where empno='1';
update employee set mgr_no='3' where empno='10';
update employee set mgr_no='3' where empno='2';
update employee set mgr_no='3' where empno='4';
update employee set mgr_no='3' where empno='5';
update employee set mgr_no='3' where empno='6';
update employee set mgr_no='3' where empno='7';

select m.ename, count(*)
from employee e,employee m
where e.mgr_no = m.empno
group by m.ename
having count(*) =(select MAX(mycount)
from (select COUNT(*) mycount
from employee
group by mgr_no) a);
                      
insert into employee values('8','Shweta',NULL,'05-01-2018','60000','2'),('9','Shreya',NULL,'25-11-2019','30000','1'),
('10','Arjun',NULL,'05-12-2019','15000','1');

select *
from employee e1
where sal>(select avg(sal) from employee e where e1.deptno=e.deptno) and e1.mgr_no is NULL;

select ename from employee where empno in(select distinct
mgr_no from employee);

insert into incentives values('6','11-01-2019','15000'),('5','18-01-2019','10000');

select *
from employee e,incentives i
where e.empno=i.empno and i.incentive_date like "%01-2019"and 2=(select count(*) from incentives j where i.incentive_amount<j.incentive_amount and incentive_date between '01-01-2019' and '31-01-2019');
   
select *
from employee e
where deptno=(select deptno from employee where empno=e.mgr_no);


