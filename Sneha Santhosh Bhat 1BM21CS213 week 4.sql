create database sneha_insurance;
use sneha_insurance;

create table person
(driver_id char(10),
name varchar(25),
address varchar(40),
primary key(driver_id)
);

create table car
(reg_num char(10) primary key,
model varchar(15),
year int(4)
);

create table accident
(report_num int(10) primary key,
accident_date date,
location varchar(40)
);

create table owns
(driver_id char(10),
reg_num char(10),
primary key (driver_id,reg_num),
foreign key(driver_id) references person(driver_id) on delete cascade,
foreign key(reg_num) references car(reg_num) on delete cascade
);

create table accidents
(report_num int,
accident_date char(10),
location varchar(20),
primary key(report_num)
);

create table participated
(driver_id char(10),
reg_num char(10),
report_num int,
damage_amount int,
primary key (driver_id, reg_num, report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accidents(report_num)
);

insert into person values ('A01','Richard','Srinivas nagar'),('A02','Pradeep','Rajaji nagar'),
('A03','Smith','Ashok nagar'),('A04','Venu','N R Colony'),('A05','Jhon','Hanumanth nagar');

insert into car values('KA052250','Indica','1990'),('KA031181','Lancer','1957'),('KA095477','Toyota','1998'),
('KA053408','Honda','2008'),('KA041702','Audi','2005');

insert into owns values('A01','KA052250'),('A02','KA053408'),('A03','KA031181'),('A04','KA095477'),('A05','KA041702');

insert into accidents values('11','2003-01-01','Mysore Road'),('12','2004-02-02','South end Circle'),
('13','2003-01-21','Bull temple Road'),('14','2008-02-17','Mysore Road'),('15','2004-03-05','Kanakpura Road');

insert into participated values('A01','KA052250','11','10000'),('A02','KA053408','12','50000'),('A03','KA095477','13','25000'),
('A04','KA031181','14','3000'),('A05','KA041702','15','5000');

select * from participated;

select * from car
order by year asc;

select count(report_num)
from car c, participated p
where c.reg_num=p.reg_num and c.model='Lancer';

select count(distinct driver_id) CNT
from participated a, accident b
where a.report_num=b.report_num and b.accident_date like '08%';

select * from participated
order by damage_amount desc;

select avg(damage_amount)
from participated;

delete from participated
where damage_amount<(select t.amt from(select avg(damage_amount)amt from participated)t);

select name from person
where driver_id in (select driver_id from participated where damage_amount >(select avg(damage_amount) from participated));

show tables;
select max(damage_amount)
from participated;

select per.name,c.model,p.damage_amount from person per,car c,participated p,accident a where per.driver_id=p.driver_id and c.reg_num=p.reg_num  and a.report_num=p.report_num and a.location='Mysore road';