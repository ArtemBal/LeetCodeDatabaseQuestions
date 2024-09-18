-- 175. Combine two tables
select p.firstName, p.lastName, a.city, a.state
from Person as p left join Address as a
on p.personId = a.personId;

--176. Second Highest Salary
select max(salary) as SecondHighestSalary
from Employee
where Salary not in (select max(salary) from Employee)

--177. Nth Highest Salary
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    set N = N - 1;
    RETURN (
        select distinct salary
        from Employee
        order by salary desc limit N,1
    );
END;

--178. Rank Scores
select score, dense_rank() over (order by score desc) as 'rank'
from Scores

--180. Consecutive Numbers
select distinct num as ConsecutiveNums
from (
    select id, num
    , lead(num, 1) over (order by id) as c1
    , lead(num, 2) over (order by id) as c2
    , lead(id, 1) over (order by id) as id1
    , lead(id, 2) over (order by id) as id2
    from Logs
) ConsLogs
where num = c1 and c1 = c2
and id + 1 = id1 and id + 2 = id2

--181. Employees Earning More Than Their Managers
select e1.name as Employee
from Employee as e1
inner join Employee as e2
on e1.managerId = e2.id
and e1.salary > e2.salary

--182. Duplicate Emails
select email as Email
from Person
group by email
having COUNT(*) > 1

--183. Customers Who Never Order
select name as Customers
from Customers
where id
not in (select customerId from Orders)

--184. Department Highest Salary
select d.name as Department, e.name as Employee, e.salary as Salary
from Employee as e right join Department as d
on e.departmentId = d.id
where (d.id, e.salary) in (select departmentId, max(salary)
from Employee
group by departmentid)

--185. Department Top Three Salaries
select Department.Name as "Department", e.name as "Employee", e.salary
from (select name, departmentId, salary
    , dense_rank() over (partition by departmentId order by salary desc) as r
    from Employee) e
join Department on e.departmentId = Department.id
where r <= 3

--196. Delete Duplicate Emails
delete p
from Person p, Person q
where p.id > q.id
and p.email = q.email

--197. Rising Temperature
select b.id
from Weather a, Weather b
where datediff(b.recordDate, a.recordDate) = 1
and b.temperature > a.temperature

--262. Trips and Users
select request_at as Day, round(avg(status != 'completed'), 2) as 'Cancellation Rate'
from Trips as t
join Users as u1 on (t.client_id = u1.users_id and u1.banned = 'No')
join Users as u2 on (t.driver_id = u2.users_id and u2.banned = 'No')
where request_at between '2013-10-01' and '2013-10-03'
group by day
order by day

--570. Managers with at Least 5 Direct Reports
select Manager.name
from Employee
inner join Employee as Manager
on (Manager.id = Employee.managerId)
group by Manager.id
having count(*) >= 5

--577. Employee Bonus
select e.name, b.bonus
from Employee as e left join Bonus as b
on e.empId = b.empId
where ifnull(b.bonus, 0) < 1000