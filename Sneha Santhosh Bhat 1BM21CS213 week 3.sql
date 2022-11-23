create database sneha_bank;
use sneha_bank;

create table branch
(branch_name varchar(30),
branch_city varchar(10),
assets float(20),
primary key(branch_name)
);

create table bank_account
(acc_no int(20),
branch_name varchar(30),
balance float(20),
primary key(acc_no),
foreign key(branch_name) references branch(branch_name) on delete cascade
);

create table bank_customer
(customer_name varchar(30),
customer_street varchar(20),
customer_city varchar(20),
primary key(customer_name)
);

create table depositer
(customer_name varchar(30),
acc_no int(20),
foreign key(customer_name) references bank_customer(customer_name) on delete cascade,
foreign key(acc_no) references bank_account(acc_no) on delete cascade
);

create table loan
(loan_no int,
branch_name varchar(30),
amount float(20),
primary key(loan_no),
foreign key(branch_name) references branch(branch_name) on delete cascade
);

insert into branch values ('SBI_Chamrajpet','Bangalore','50000'),('SBI_ResidencyRoad','Bangalore','10000'),
('SBI_ShivajiRoad','Bombay','20000'),('SBI_ParliamentRoad','Delhi','10000'),('SBI_JantarMantar','Delhi','20000');

select * from branch;

insert into bank_account values ('1','SBI_Chamrajpet','2000'),('2','SBI_ResidencyRoad','5000'),
('3','SBI_ShivajiRoad','6000'),('4','SBI_ParliamentRoad','9000'),('5','SBI_JantarMantar','8000'),
('6','SBI_ShivajiRoad','4000'),('8','SBI_ResidencyRoad','4000'),('9','SBI_ParliamentRoad','3000'),
('10','SBI_ResidencyRoad','5000'),('11','SBI_JantarMantar','2000');

select * from bank_account;

insert into bank_customer values('Avinash','Bull_Temple_Road','Bangalore'),('Dinesh','Bannerghatta_Road','Bangalore'),
('Mohan','NationalCollege_Road','Bangalore'),('Nikil','Akbar_Road','Delhi'),('Ravi','Prithviraj_Road','Delhi');

select * from bank_customer;

insert into depositer values('Avinash','1'),('Dinesh','2'),('Nikil','4'),('Ravi','5'),('Avinash','8'),('Nikil','9'),
('Dinesh','10'),('Nikil','11');

select * from depositer;

insert into loan values('1','SBI_Chamrajpet','1000'),('2','SBI_ResidencyRoad','2000'),('3','SBI_ShivajiRoad','3000'),
('4','SBI_ParliamentRoad','4000'),('5','SBI_JantarMantar','5000');

select * from loan;

select branch_name, assets/100000 as assets_in_lakhs from branch;

select d.customer_name from depositer d,bank_account a
where d.acc_no=a.acc_no
group by a.branch_name 
having(count(a.acc_no)>=2) and a.branch_name='SBI_ResidencyRoad';

create view total_sum_loan as select branch_name, amount total_sum from loan;
select * from total_sum_loan;

select a.branch_name, a.balance+1000 as updated_balance
from bank_account a, bank_customer b, depositer d
where b.customer_name=d.customer_name and a.acc_no=d.acc_no and b.customer_city='Bangalore';