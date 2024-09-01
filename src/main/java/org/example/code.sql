-- 175. Combine two tables
select p.firstName, p.lastName, a.city, a.state
from Person as p left join Address as a
on p.personId = a.personId;

-- 181. Employees Earning More Than Their Managers
select e1.name as Employee
from Employee as e1
inner join Employee as e2
on e1.managerId = e2.id
and e1.salary > e2.salary

-- 182. Duplicate Emails
select email as Email
from Person
group by email
having COUNT(*) > 1

-- 197. Rising Temperature
select b.id
from Weather a, Weather b
where datediff(b.recordDate, a.recordDate) = 1
and b.temperature > a.temperature



