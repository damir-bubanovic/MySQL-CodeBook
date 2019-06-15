/*

!!SORTING QUERY RESULTS - DATE-BASED SORTING!!

> You want to sort rows in temporal order

> Sort using a date or time column. 
	>> If some parts of the values are irrelevant for the sort that 
	you want to accomplish, ignore them

*/

/*
> Many database tables include date or time information and it’s very often necessary to
sort results in temporal order

EXAMPLE:
1) To display the messages, most recently sent ones first, use ORDER BY with DESC
*/
1)
mysql> SELECT * FROM mail WHERE srcuser = 'phil' ORDER BY t DESC;


/*
SORTING BY TIME OF DAY
> To put DATETIME or TIMESTAMP values in time-of-day order, extract the
time parts and sort them

EXAMPLE:
1) mail table contains DATETIME values, which can be sorted by time of day 
*/
1)
mysql> SELECT * FROM mail ORDER BY TIME(t);


/*
SORTING BY CALENDAR DAY
> To sort date values in calendar order, ignore the year part of the dates and use only the
month and day to order values by where they fall during the calendar year

EXAMPLE:
1) Sort them by month and day within month
*/
1)
mysql> SELECT date, description FROM occasion
	-> ORDER BY MONTH(date), DAYOFMONTH(date);
	

/*
SORTING BY DAY OF WEEK

EXAMPLE:
1) Display day names using DAYNAME(), but sort in day-of-week order using
DAYOFWEEK(), which returns numeric values from 1 to 7 for Sunday through Saturday

2) To sort rows in day-of-week order but treat Monday as the first day of the week and
Sunday as the last, use the MOD() function to map Monday to 0, Tuesday to 1, …, Sunday
to 6
*/
1)
mysql> SELECT DAYNAME(date) AS day, date, description
	-> FROM occasion
	-> ORDER BY DAYOFWEEK(date);
	
2)
mysql> SELECT DAYNAME(date), date, description
	-> FROM occasion
	-> ORDER BY MOD(DAYOFWEEK(date)+5, 7);
