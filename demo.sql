alter table customer drop column grade;
alter table customer add grade integer;
select * from customer;
select * from salesman;
select * from orders;
insert into salesman values(1001,'Varun','Puttur',5);
insert into salesman values(1002,'Sampath','Suratkal',3);
insert into salesman values(1003,'Tushar','Suratkal',6);
insert into salesman values(1004,'Ranjith','Mangalore',2);
insert into salesman values(1005,'Shrutha','Mangalore',4);
insert into salesman values(1006,'Prajna','Mangalore',5);
insert into salesman values(1007,'Vignesh','Udupi',3);
insert into salesman values(1008,'Shravya','Udupi',6);
insert into salesman values(1000,'Srishti','Bangalore',6);

insert into customer values(2001,'Shubha','Karkala',1001,5);
insert into customer values(2002,'Shreema','Karkala',1003,7);
insert into customer values(2003,'Rahul','Udupi',1006,4);
insert into customer values(2004,'Sheethal','Bangalore',1003,5);
insert into customer values(2005,'Deepak','Bangalore',1007,3);
insert into customer values(2006,'Rakesh','Karkala',1002,7);
insert into customer values(2007,'Rakshith','Bangalore',1008,8);
insert into customer values(2008,'Prinston','Karkala',1004,9);
insert into customer values(2009,'Aditya','Bangalore',1005,10);
insert into customer values(2010,'Drishti','Bangalore',1000,10);
insert into customer values(2011,'Harish','Bangalore',1000,10);

insert into orders values(3001,4099,'2022-12-02',2001,1001);
insert into orders values(3002,2099,'2022-12-02',2001,1001);
insert into orders values(3003,699,'2022-12-02',2002,1003);
insert into orders values(3004,469,'2022-07-08',2003,1006);
insert into orders values(3005,599,'2022-07-08',2004,1003);
insert into orders values(3006,799,'2022-07-08',2005,1007);
insert into orders values(3007,4099,'2022-02-03',2006,1002);
insert into orders values(3008,9099,'2022-02-03',2007,1008);
insert into orders values(3009,1299,'2022-02-03',2008,1004);
insert into orders values(3010,6999,'2022-02-03',2009,1005);
insert into orders values(3011,6969,'2022-06-03',2010,1000);
insert into orders values(3012,999,'2022-06-03',2011,1000); 

--query 1
select count(customer_id) from customer where 
grade>(select avg(grade) from customer where ccity='Bangalore') group by grade;

--query 2
select sname,count(c.customer_id) from salesman s,customer c 
where s.salesman_id=c.salesman_id group by s.salesman_id,sname
having count(c.customer_id)>1;

--query 3
(select sname,(case when scity=ccity then 'same city' end) "city?" from salesman s,customer c
where s.salesman_id=c.salesman_id and scity=ccity)
union
(select sname,(case when scity<>ccity then 'different city' end) "city?" from salesman s,customer c
where s.salesman_id=c.salesman_id and scity<>ccity);

--query 4
create view highest_purchase  as (select  distinct sname,scity,commission from salesman s,customer c where s.salesman_id=c.salesman_id
and c.customer_id in(select customer_id from orders group by ord_date,customer_id 
having sum(purchase_amt) in(select MAX(tot_amt) from (select ord_date,customer_id,sum(purchase_amt) tot_amt 
from orders group by ord_date,customer_id) as temp group by ord_date))); 

select * from highest_purchase;
--query 5
delete from salesman where salesman_id=1000;