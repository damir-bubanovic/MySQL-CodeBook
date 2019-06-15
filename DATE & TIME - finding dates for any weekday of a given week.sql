/*

!!DATE & TIME - FINDING DATES FOR ANY WEEKDAY OF A GIVEN WEEK!!

> You want to compute the date of some weekday for the week in which a given date lies.
	>> Suppose that you want to know the date of the Tuesday that falls in the same 
	week as 2014-07-09
	
> This is an application of date shifting. 
	>> Figure out the number of days between the starting weekday of the given date 
	and the desired day, and shift the date by that many days

*/

/*
> shift the reference date first to a known point relative to the beginning of the week, 
and then shift forward
	1. Shift the reference date back by its DAYOFWEEK() value, which always produces the
	date for the Saturday preceding the week.
	2. Shift the Saturday date by one day to reach the Sunday date, by two days to reach
	the Monday date, and so forth.
	
EXAMPLE:
1) In SQL, those operations can be expressed as follows for a date d, where n is 1 through
7 to produce the dates for Sunday through Saturday

2) That expression splits the “shift back to Saturday” and “shift forward” phases into separate
operations, but because the intervals for both DATE_SUB() and DATE_ADD() are in days, the expression 
can be simplified into a single DATE_ADD() call

3) Applying this formula to the dates in our date_val table, using an n of 1 for Sunday and
7 for Saturday to find the first and last days of the week, yields this result

4) To compute the date for Wednesday two weeks ago, you can perform the day-within-week 
shift first, like this

5) Or you can perform the week shift first
*/
1)
DATE_ADD(DATE_SUB(d,INTERVAL DAYOFWEEK(d) DAY),INTERVAL n DAY)

2)
DATE_ADD(d,INTERVAL n-DAYOFWEEK(d) DAY)

3)
mysql> SELECT d, DAYNAME(d) AS day,
	-> DATE_ADD(d,INTERVAL 1-DAYOFWEEK(d) DAY) AS Sunday,
	-> DATE_ADD(d,INTERVAL 7-DAYOFWEEK(d) DAY) AS Saturday
	-> FROM date_val;
	
4)
mysql> SET @target =
	-> DATE_SUB(DATE_ADD(CURDATE(),INTERVAL 4-DAYOFWEEK(CURDATE()) DAY),
	-> INTERVAL 14 DAY);
mysql> SELECT CURDATE(), @target, DAYNAME(@target);

5)
mysql> SET @target =
	-> DATE_ADD(DATE_SUB(CURDATE(),INTERVAL 14 DAY),
	-> INTERVAL 4-DAYOFWEEK(CURDATE()) DAY);
mysql> SELECT CURDATE(), @target, DAYNAME(@target);
