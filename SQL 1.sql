create database shivaa ;
Use shivaa ;

create table students (Student_id int, Name varchar (25), Age int, Course varchar (10), Mobile_no varchar(13));
describe students;

insert into students (Student_id, Name, Age, Course, Mobile_no) 
values
(01,"Shivanshu",21,"MCA AI","917275990129"),
(02,"Riddhima",21,"MCA AI","919876543210"),
(03,"Dhruv",23,"MCA AI","910123456789"),
(04,"Ravi",35,"MCA AI","915263410789");
select * from students;
