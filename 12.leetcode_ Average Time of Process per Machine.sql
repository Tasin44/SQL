# Approach1
select a1.machine_id ,round(avg(a2.timestamp-a1.timestamp),3) as processing_time
from Activity as a1
join Activity as a2
on a1.machine_id=a2.machine_id
and a1.process_id=a2.process_id
and a1.activity_type='start'
and a2.activity_type='end'
group by a1.machine_id;
#we use group by here because in the output table,we return the grouped machine ids

/*
Here, inner join is appropriate because we're only interested in the pairs where both a start and an end exist.


After performing join(inner join),the returned table will be:

machine_id	process_id	start_time	end_time
0	               0	0.712	    1.520
0	               1	3.140	    4.120
1	               0	0.550	    1.550
1	               1	0.430	    1.420
2	               0	4.100	    4.512
2	               1	2.500	    5.000


Each row in the result shows the start_time and end_time 
for each combination of machine_id and process_id.

The join condition ensures that you pair the start and end events 
for each process on each machine.

Filtering by activity_type (start, end) gives you meaningful pairs of start and end times.
*/

#approach 2
select a1.machine_id ,round(avg(a2.timestamp-a1.timestamp),3) as processing_time
from Activity as a1
join Activity as a2
on a1.machine_id=a2.machine_id
and a1.process_id=a2.process_id
and a1.timestamp<a2.timestamp
group by a1.machine_id;


























