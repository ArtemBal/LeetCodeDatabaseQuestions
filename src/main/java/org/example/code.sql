-- 175 Combine two tables
select p.firstName, p.lastName, a.city, a.state
from Person as p left join Address as a
on p.personId = a.personId;

-- 197 Rising Temperature
select b.id
from Weather a, Weather b
where datediff(b.recordDate, a.recordDate) = 1
and b.temperature > a.temperature