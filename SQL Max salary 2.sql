create database bussiness;
use bussiness;
create table employees(empl_id int,empl_Name varchar(50),department varchar(50),salary int);
insert into employees(empl_id,empl_Name,department,salary)values
(01,"Naitik","IT",60000),
(02,"Pankaj", "HR", 75000),
(03,"Nidhi", "IT", 68000),
(04,"Sunita", "Sales", 95000),
(05, "Anshika", "IT", 84000);
select*from employees where salary =(select max(salary)from employees);

