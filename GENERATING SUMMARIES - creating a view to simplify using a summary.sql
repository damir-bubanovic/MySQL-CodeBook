/*

!!GENERATING SUMMARIES - CREATING A VIEW TO SIMPLIFY USING A SUMMARY!!

> You want to make it easier to perform a summary

> Create a view that does it for you

*/

/*
EXAMPLE:
1) view implements the weekend versus weekday trip

2) Selecting from this view is much easier than selecting directly from the underlying table
*/
1)
mysql> CREATE VIEW trip_summary_view AS
	-> SELECT
	-> COUNT(IF(DAYOFWEEK(trav_date) IN (1,7),1,NULL)) AS weekend_trips,
	-> COUNT(IF(DAYOFWEEK(trav_date) IN (1,7),NULL,1)) AS weekday_trips
	-> FROM driver_log;
	
2)
mysql> SELECT * FROM trip_summary_view;