use `project_samrat`;

select * from churn;
select * from customers;
select * from transactions;
select * from subscriptions;

select `FirstName`, `LastName` from customers;

select region, count(*) customer_count from customers
group by region
order by region asc;

select count(*) customer_count from customers;

select count(*) customer_count from customers
where status = 'active';

select `FirstName`, `LastName` Customer_Names from customers
where status = 'active';

select count(*) customer_count from customers
where joindate > 2021-01-01;

select count(*) from customers 
where str_to_date(`joindate`, "%d-%m-%Y") = '01-01-2021';

select count(*) customer_count from customers
where status = 'active' and region = 'europe';

select count(*) from customers 
where str_to_date(`joindate`, "%d-%m-%Y") >= '01-01-2022' and str_to_date(`joindate`, "%d-%m-%Y") <= '31-12-2022';

select count(*) from customers 
where str_to_date(`joindate`, "%d-%m-%Y") between '2022-01-01' and '2022-12-31';

select count(*) from customers 
where str_to_date(`joindate`, "%d-%m-%Y") between str_to_date('01-01-2022', "%d-%m-%Y") 
                                             and str_to_date('31-12-2022', "%d-%m-%Y");

select joindate from customers limit 10;

select distinct joindate from customers order by joindate;

select count(*) 
from customers 
where joindate between '2022-01-01' and '2022-12-31';

select count(*) 
from customers 
where joindate like '%2022%';

select count(*)
from customers
where year(joindate) = 2022;

select count(*)
from customers
where year(joindate) = 2022;

select `FirstName`, `LastName` Customer from customers
where email = 'john.doe@example.com';

select count(*) from subscriptions
where plantype = 'annual';

select c.firstname, c.lastname, s.plantype, count(*) Total_plans from customers as c
join subscriptions as s on c.customerid = s.CustomerID
where c.firstname = 'oscar'
group by c.firstname, c.lastname, s.plantype
order by c.LastName asc;

select avg(amount) from transactions;

select count(*) Transactions_over_$100 from transactions
where amount > 100;

select count(*) from transactions where customerid = 10;


select c.firstname, c.lastname, t.transactionid, t.amount from customers as c
join transactions as t on c.customerid = t.CustomerID
order by c.firstname, c.lastname desc;

select c.firstname, c.lastname, sum(t.amount) from customers as c
join transactions as t on c.customerid = t.CustomerID
group by c.firstname, c.lastname
order by c.firstname, c.lastname desc;

select * from transactions
order by TransactionDate desc
limit 5;

alter table transactions modify TransactionDate date;
alter table customers modify JoinDate date;

update transactions
set transactiondate = null
where transactiondate is null;

select * from customers
where JoinDate between 30-12-2011 and 30-12-2022;

describe customers;
describe transactions;

select * from customers
order by JoinDate desc
limit 5;

alter table customers modify JoinDate date;

select * from customers where JoinDate is null;

update customers set joindate = null where joindate is null;

UPDATE customers 
SET joindate = NULL 
WHERE customer_id IS NOT NULL AND joindate IS NULL;

update customers set joindate = null where joindate is null;

alter table customers modify JoinDate date;

set sql_safe_updates = 0;

SET SQL_SAFE_UPDATES = 0;

UPDATE customers SET joindate = NULL WHERE joindate IS NULL;

SET SQL_SAFE_UPDATES = 1;

select distinct(reason) from churn;

select count(distinct(reason)) from churn;

select reason, count(customerid) from churn
group by reason;

select c.customerid, c.`FirstName`, c.`LastName`, s.plantype from customers as c
join subscriptions as s on c.customerid = s.CustomerID;

select c.customerid, c.`FirstName`, c.`LastName`,  count(s.plantype) No_of_plans from customers as c
join subscriptions as s on c.customerid = s.CustomerID
where c.customerid = 252
group by c.customerid, c.`FirstName`, c.`LastName`
order by count(s.plantype) desc, c.`FirstName`, c.`LastName`;

update customers
set firstname = 'Vishnu'
where customerid = 252;


select s.plantype, count(c.customerid) plan_type_count from customers as c
join subscriptions as s on c.customerid = s.CustomerID
group by s.plantype;

select s.plantype, count(c.customerid) from customers as c
join subscriptions as s on c.customerid = s.CustomerID
where c.status = 'active' and s.plantype = 'annual'
group by s.plantype;


select count(customerid) from customers where customerid not in (
select c.customerid from customers as c
join churn as cc on c.customerid = cc.CustomerID);

select count(customerid) from customers where customerid in (
select c.customerid from customers as c
join churn as cc on c.customerid = cc.CustomerID)
and status = 'active';

select count(customerid) from customers;

select count(customerid) from churn;

select customerid, firstname, lastname, status from customers where customerid not in (
select c.customerid from customers as c
join churn as cc on c.customerid = cc.CustomerID)
and status = 'active';

select count(customerid) from customers where CustomerID not in (
select customerid from churn );


select c.customerid, c.firstname, c.lastname, sum(t.amount) TotalSpent from customers as c
join transactions as t on c.customerid = t.CustomerID
group by c.customerid, c.firstname, c.lastname
order by sum(t.amount) desc, c.customerid, c.firstname, c.lastname;


select * from subscriptions
where year(EndDate) = 2022;

describe subscriptions;

alter table subscriptions
modify StartDate date,
modify EndDate date;


UPDATE subscriptions
SET StartDate = STR_TO_DATE(StartDate, '%d-%m-%Y')
WHERE StartDate LIKE '%-%-%';

UPDATE subscriptions
SET StartDate = STR_TO_DATE(EndDate, '%d-%m-%Y')
WHERE StartDate LIKE '%-%-%';

SELECT StartDate FROM subscriptions
WHERE STR_TO_DATE(StartDate, '%d-%m-%Y') IS NULL;

SHOW COLUMNS FROM subscriptions LIKE 'StartDate';
SHOW COLUMNS FROM subscriptions LIKE 'EndDate';

ALTER TABLE subscriptions
ADD COLUMN StartDate_temp DATE,
ADD COLUMN EndDate_temp DATE;

UPDATE subscriptions
SET StartDate_temp = STR_TO_DATE(StartDate, '%Y-%m-%d'),
    EndDate_temp = STR_TO_DATE(EndDate, '%Y-%m-%d');


UPDATE subscriptions
SET 
  StartDate_temp = CASE
    WHEN StartDate LIKE '__-__-____' THEN STR_TO_DATE(StartDate, '%d-%m-%Y')
    WHEN StartDate LIKE '____-__-__' THEN STR_TO_DATE(StartDate, '%Y-%m-%d')
    ELSE NULL
  END,
  EndDate_temp = CASE
    WHEN EndDate LIKE '__-__-____' THEN STR_TO_DATE(EndDate, '%d-%m-%Y')
    WHEN EndDate LIKE '____-__-__' THEN STR_TO_DATE(EndDate, '%Y-%m-%d')
    ELSE NULL
  END;
  
SELECT StartDate, StartDate_temp, EndDate, EndDate_temp
FROM subscriptions
LIMIT 20; 

ALTER TABLE subscriptions
DROP COLUMN StartDate,
DROP COLUMN EndDate;

ALTER TABLE subscriptions
CHANGE StartDate_temp StartDate DATE,
CHANGE EndDate_temp EndDate DATE;

select count(*) from subscriptions
where year(EndDate) = 2022;

select count(*) from transactions
where TransactionType <> 'renewal';

select * from customers
order by JoinDate asc
limit 1
offset 2;

DELETE FROM customers
WHERE joindate is NULL;

select min(JoinDate) from customers;

select count(*) as subscriptions from subscriptions 
where EndDate between '2023-01-01' and '2023-01-31';

select * from customers where CustomerID not in (
select customerid from transactions);

select count(*) No_sunscription from customers where customerid not in (
select customerid from subscriptions);

select * from customers where customerid not in (
select customerid from subscriptions);

