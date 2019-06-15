/*

!!DATE & TIME - FINDING THE FIRST DAY, LAST DAY, OR LENGTH OF A MONTH!!

> Given a date, you want to determine the date for the first or last day of the month in
which the date occurs, or the first or last day for the month n months away.
	>> A related problem is to determine the number of days in a month

> To determine the date for the first day in a month, use date shifting (an application of
date arithmetic). 
> To determine the date for the last day, use the LAST_DAY() function.
> To determine the number of days in a month, find the date for its last day and use it as
the argument to DAYOFMONTH()

*/

/*
> Sometimes you have a reference date and want to reach a target date that doesn’t have
a fixed relationship to the reference date

EXAMPLE:
1) To find the first day of the month for a given date, shift the date back by one fewer days
than its DAYOFMONTH() value

2) In the general case, to find the first of the month for any month n months away from a
given date, calculate the first of the month for the date and shift the result by n months


3) Find the first day of the previous and following months relative to a given date, n is -1 and 1

4) It’s easier to find the last day of the month for a given date because there is a function
for it


5) For the general case, to find the last of the month for any month n months away from
a given date, shift the date by that many months first, then pass it to LAST_DAY()

6) Find the last day of the previous and following months relative to a given
date, n is -1 and 1

7) To find the length of a month in days, determine the date of its last day with
LAST_DAY(), then use DAYOFMONTH() to extract the day-of-month component from the
result
*/
1)
mysql> SELECT d, DATE_SUB(d,INTERVAL DAYOFMONTH(d)-1 DAY) AS '1st of month'
	-> FROM date_val;
	
2)
DATE_ADD(DATE_SUB(d,INTERVAL DAYOFMONTH(d)-1 DAY),INTERVAL n MONTH)


3)
mysql> SELECT d,
	-> DATE_ADD(DATE_SUB(d,INTERVAL DAYOFMONTH(d)-1 DAY),INTERVAL -1 MONTH)
	-> AS '1st of previous month',
	-> DATE_ADD(DATE_SUB(d,INTERVAL DAYOFMONTH(d)-1 DAY),INTERVAL 1 MONTH)
	-> AS '1st of following month'
	-> FROM date_val;
	
4) 
mysql> SELECT d, LAST_DAY(d) AS 'last of month'
	-> FROM date_val;

	
5)
LAST_DAY(DATE_ADD(d,INTERVAL n MONTH))

6)
mysql> SELECT d,
	-> LAST_DAY(DATE_ADD(d,INTERVAL -1 MONTH))
	-> AS 'last of previous month',
	-> LAST_DAY(DATE_ADD(d,INTERVAL 1 MONTH))
	-> AS 'last of following month'
	-> FROM date_val;	

7)
mysql> SELECT d, DAYOFMONTH(LAST_DAY(d)) AS 'days in month' FROM date_val;	
