/*

!!STATISTICS - FINDING CUMULATIVE SUMS & RUNNING AVERAGES!!

> You have a set of observations measured over time and want to compute the cumulative
sum of the observations at each measurement point. 
> Or you want to compute a running average at each point

> Use a self-join to produce the sets of successive observations at each measurement point,
then apply aggregate functions to each set of values to compute its sum or average.

*/

/*
EXAMPLE:
1) The following table shows a set of rainfall measurements taken over a series of days. 
The values in each row show the observation date and precipitation in inches

> To calculate cumulative rainfall for a given day, add that day’s precipitation value to the
values for all the previous days. 
2) npr. determine the cumulative rainfall as of 2014-06-03

> A self-join can do this for all days with a single statement.
> Use one instance of the rainfall table as a reference, and determine for the date in each 
row the sum of the precip values in all rows occurring up through that date in another instance 
of the table. 
3) Show the daily and cumulative precipitation for each day

4) The self-join can be extended to display the number of days elapsed at each date, as well
as the running averages for amount of precipitation each day

> If missing days are permitted, the calculation becomes more complicated because the number 
of days elapsed for each calculation is no longer the same as the number of rows. 
5) You can see this by deleting the rows for the days that had no precipitation to produce 
“holes” in the table
*/
1)
mysql> SELECT date, precip FROM rainfall ORDER BY date;

2)
mysql> SELECT SUM(precip) FROM rainfall WHERE date <= '2014-06-03';

3)
mysql> SELECT t1.date, t1.precip AS 'daily precip',
	-> SUM(t2.precip) AS 'cum. precip'
	-> FROM rainfall AS t1 INNER JOIN rainfall AS t2
	-> ON t1.date >= t2.date
	-> GROUP BY t1.date;
	
4)
mysql> SELECT t1.date, t1.precip AS 'daily precip',
	-> SUM(t2.precip) AS 'cum. precip',
	-> COUNT(t2.precip) AS 'days elapsed',
	-> AVG(t2.precip) AS 'avg. precip'
	-> FROM rainfall AS t1 INNER JOIN rainfall AS t2
	-> ON t1.date >= t2.date
	-> GROUP BY t1.date;

5)
mysql> DELETE FROM rainfall WHERE precip = 0;
mysql> SELECT date, precip FROM rainfall ORDER BY date;


/*
EXAMPLE:
1) Determine the number of days elapsed a different way. Take the minimum and maximum date involved 
in each sum and calculate a days-elapsed value from them

2) That value must be used for the days-elapsed column and for computing the running
averages
*/
1)
DATEDIFF(MAX(t2.date),MIN(t2.date)) + 1

2)
mysql> SELECT t1.date, t1.precip AS 'daily precip',
	-> SUM(t2.precip) AS 'cum. precip',
	-> DATEDIFF(MAX(t2.date),MIN(t2.date)) + 1 AS 'days elapsed',
	-> SUM(t2.precip) / (DATEDIFF(MAX(t2.date),MIN(t2.date)) + 1)
	-> AS 'avg. precip'
	-> FROM rainfall AS t1 INNER JOIN rainfall AS t2
	-> ON t1.date >= t2.date
	-> GROUP BY t1.date;
