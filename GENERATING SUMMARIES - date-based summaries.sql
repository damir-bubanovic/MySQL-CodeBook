/*

!!GENERATING SUMMARIES - DATE-BASED SUMMARIES!!

> You want to produce a summary based on date or time values

> Use GROUP BY to place temporal values into categories of the appropriate duration. 
> Often this involves using expressions that extract the significant parts of dates 
or times

*/

/*
> To sort rows temporally, use ORDER BY with a temporal column. 
> To summarize rows instead, based on groupings into time intervals, determine how 
to categorize rows into the proper intervals and use GROUP BY to group them accordingly

EXAMPLE:
1) Determine how many drivers were on the road and how many miles
were driven each day, group the rows in the driver_log table by date

> However, this per-day summary grows lengthier as you add more rows to the table.
Over time, the number of distinct dates will become so large that the summary fails to
be useful, and you’d probably decide to increase the category size
2) This query categorizes by month
> Now the number of summary rows grows much more slowly over time. 
> Eventually, you could summarize based only on year to collapse rows even more
*/
1)
mysql> SELECT trav_date,
	-> COUNT(*) AS 'number of drivers', SUM(miles) As 'miles logged'
	-> FROM driver_log GROUP BY trav_date;
	
2)
mysql> SELECT YEAR(trav_date) AS year, MONTH(trav_date) AS month,
	-> COUNT(*) AS 'number of drivers', SUM(miles) As 'miles logged'
	-> FROM driver_log GROUP BY year, month;
	
	
/*
Uses for temporal categorizations are numerous
	1) To produce daily summaries from DATETIME or TIMESTAMP columns that have the
	potential to contain many unique values, strip the time-of-day part to collapse all
	values occurring within a given day to the same value.
	2) To produce monthly or quarterly sales reports, group by MONTH(col_name) or 
	QUARTER(col_name) to place dates into the correct part of the year.
	3) To summarize web server activity, store your server’s logs in MySQL and run 
	statements that collapse the rows into different time categories.
*/
1)
GROUP BY DATE(col_name)
GROUP BY FROM_DAYS(TO_DAYS(col_name))
GROUP BY YEAR(col_name), MONTH(col_name), DAYOFMONTH(col_name)
