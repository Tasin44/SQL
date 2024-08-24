#approach 1:
select id , movie , description , rating
from Cinema as c
where id%2=1 and  description!='boring'
order by rating desc;



#approach 2:
select *
from Cinema
where id%2=1 and  description<>'boring'
order by rating desc;
