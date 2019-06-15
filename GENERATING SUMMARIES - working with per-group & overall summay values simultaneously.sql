/*

!!GENERATING SUMMARIES - WORKING WITH PER-GROUP & OVERALL SUMMARY VALUES SIMULTANEOUSLY!!

> You want to produce a report that requires different levels of summary detail. 
> Or you want to compare per-group summary values to an overall summary value

> Use two statements that retrieve different levels of summary information. 
> Or use a subquery to retrieve one summary value and refer to it in the outer query that 
refers to other summary values

*/

/*
> Some reports involve multiple levels of summary information. The following report
displays the total number of miles per driver from the driver_log table, along with
each driver’s miles as a percentage of the total miles in the entire table

EXAMPLE:
> To perform the percentage calculation, you need a per-group summary to get each
driver’s miles and also an overall summary to get the total miles
1) Run a query to get the overall mileage total

2) Then calculate the per-group values and use the overall total to compute the percentages

3) To combine the two statements into one, use a subquery that computes the total miles
*/
1)
mysql> SELECT @total := SUM(miles) AS 'total miles' FROM driver_log;

2) 
mysql> SELECT name,
	-> SUM(miles) AS 'miles/driver',
	-> (SUM(miles)*100)/@total AS 'percent of total miles'
	-> FROM driver_log GROUP BY name;
	
3)
SELECT name,
SUM(miles) AS 'miles/driver',
(SUM(miles)*100)/(SELECT SUM(miles) FROM driver_log)
AS 'percent of total miles'
FROM driver_log GROUP BY name;


/*
> A similar problem uses multiple summary levels to compare per-group summary values
with the corresponding overall summary value. 

EXAMPLE:
> Suppose that you want to display drivers who had a lower average miles per day than the 
group average. 
1) Calculate the overall average in a subquery, and then compare each driver’s 
average to the overall average using a HAVING clause

2) To display different summary-level values (and not perform calculations involving one
summary level against another), add WITH ROLLUP to the GROUP BY clause

> WITH ROLLUP produces multiple summary levels if you group by more than one column.
3) shows the number of mail messages sent between each pair of users

4) Adding WITH ROLLUP causes the output to include an intermediate count for each srcus
er value (these are the lines with NULL in the dstuser column), plus an overall count at
the end
*/
1)
mysql> SELECT name, AVG(miles) AS driver_avg FROM driver_log
	-> GROUP BY name
	-> HAVING driver_avg < (SELECT AVG(miles) FROM driver_log);
	
2)
mysql> SELECT name, SUM(miles) AS 'miles/driver'
	-> FROM driver_log GROUP BY name WITH ROLLUP;

mysql> SELECT name, AVG(miles) AS driver_avg FROM driver_log
	-> GROUP BY name WITH ROLLUP;

3)
mysql> SELECT srcuser, dstuser, COUNT(*)
	-> FROM mail GROUP BY srcuser, dstuser;

4)
mysql> SELECT srcuser, dstuser, COUNT(*)
	-> FROM mail GROUP BY srcuser, dstuser WITH ROLLUP;
