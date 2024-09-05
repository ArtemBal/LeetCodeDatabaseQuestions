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

--183. Customers Who Never Order
select name as Customers
from Customers
where id
not in (select customerId from Orders)

-- 196. Delete Duplicate Emails
delete p
from Person p, Person q
where p.id > q.id
and p.email = q.email

-- 197. Rising Temperature
select b.id
from Weather a, Weather b
where datediff(b.recordDate, a.recordDate) = 1
and b.temperature > a.temperature



