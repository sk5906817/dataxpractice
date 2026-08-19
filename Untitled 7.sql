select * from employee
select * from department
select * from manager
select * from projects

select e.emp_name,d.dept_name from employee e left join department d on e.dept_id=d.dept_id

