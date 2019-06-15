/*

!!GENERATING SUMMARIES - FINDING SMALLEST OR LARGEST SUMMARY VALUES!!

> You want to compute per-group summary values but display only the smallest or largest
of them

> Add a LIMIT clause to the statement. 
> Or use a user-defined variable or subquery to pick the appropriate summary

*/

/*
> MIN() and MAX() find the values at the endpoints of a set of values, but to find the
endpoints of a set of summary values, those functions won’t work.

EXAMPLE:
1) To select only the row for the driver with the most miles
	> order the rows with the largest SUM() values first and use LIMIT to select the
	first row
	
2) If more than one row has the given summary value, a LIMIT 1 query won’t tell
you that
	> To find all most-frequent values when there may be more than one, use a user-defined 
	variable or subquery to determine the maximum count, then select those values with a 
	count equal to the maximum
*/
1)
mysql> SELECT name, SUM(miles)
	-> FROM driver_log
	-> GROUP BY name
	-> ORDER BY SUM(miles) DESC LIMIT 1;
	
2)
mysql> SET @max = (SELECT COUNT(*) FROM states
	-> GROUP BY LEFT(name,1) ORDER BY COUNT(*) DESC LIMIT 1);
mysql> SELECT LEFT(name,1) AS letter, COUNT(*) FROM states
	-> GROUP BY letter HAVING COUNT(*) = @max;
	
mysql> SELECT LEFT(name,1) AS letter, COUNT(*) FROM states
	-> GROUP BY letter HAVING COUNT(*) =
	-> (SELECT COUNT(*) FROM states
	-> GROUP BY LEFT(name,1) ORDER BY COUNT(*) DESC LIMIT 1);