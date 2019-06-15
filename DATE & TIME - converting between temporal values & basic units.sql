/*

!!DATE & TIME - CONVERTING BETWEEN TEMPORAL VALUES & BASIC UNITS!!

> You want to convert a temporal value such as a time or date to basic units such as seconds
or days. 
	>> This is often useful or necessary for performing temporal arithmetic operations

> The conversion method depends on the type of value to be converted:
	• To convert between time values and seconds, use the TIME_TO_SEC() and
	SEC_TO_TIME() functions.
	• To convert between date values and days, use the TO_DAYS() and FROM_DAYS()
	functions.
	• To convert between date-and-time values and seconds, use the UNIX_TIME
	STAMP() and FROM_UNIXTIME() functions.

*/

/*
CONVERTING BETWEEN TIMES & SECONDS

EXAMPLE:
1) TIME_TO_SEC() converts a TIME value to the equivalent number of seconds, and
SEC_TO_TIME() does the opposite

2) To express time values as minutes, hours, or days, perform the appropriate divisions
	> Use FLOOR() on the division results if you prefer integer values that have no 
	fractional part
	
3) If you pass TIME_TO_SEC() a date-and-time value, it extracts the time part and discards
the date
*/
1)
mysql> SELECT t1,
	-> TIME_TO_SEC(t1) AS 'TIME to seconds',
	-> SEC_TO_TIME(TIME_TO_SEC(t1)) AS 'TIME to seconds to TIME'
	-> FROM time_val;
	
2)
mysql> SELECT t1,
	-> TIME_TO_SEC(t1) AS 'seconds',
	-> TIME_TO_SEC(t1)/60 AS 'minutes',
	-> TIME_TO_SEC(t1)/(60*60) AS 'hours',
	-> TIME_TO_SEC(t1)/(24*60*60) AS 'days'
	-> FROM time_val;
	
3)
mysql> SELECT dt,
	-> TIME_TO_SEC(dt) AS 'time part in seconds',
	-> SEC_TO_TIME(TIME_TO_SEC(dt)) AS 'time part as TIME'
	-> FROM datetime_val;
	

/*
CONVERTING BETWEEN DATES & TIMES
> If you have a date but want a value in days, or vice versa, use the TO_DAYS() and
FROM_DAYS() functions. 
> Date-and-time values also can be converted to days if you can suffer loss of the time part

EXAMPLE:
1) TO_DAYS() converts a date to the corresponding number of days, and FROM_DAYS() does
the opposite

2) If you pass TO_DAYS() a date-and-time value, it extracts the date part and discards the
time. This provides another means of extracting dates from DATETIME (or TIMESTAMP)
values
*/
1)
mysql> SELECT d,
	-> TO_DAYS(d) AS 'DATE to days',
	-> FROM_DAYS(TO_DAYS(d)) AS 'DATE to days to DATE'
	-> FROM date_val;

2)
mysql> SELECT dt,
	-> TO_DAYS(dt) AS 'date part in days',
	-> FROM_DAYS(TO_DAYS(dt)) AS 'date part as DATE'
	-> FROM datetime_val;
	

/*
CONVERTING BETWEEN DATE-AND-TIME VALUES AND SECONDS

EXAMPLE:
1) For DATETIME or TIMESTAMP values that lie within the range of the TIMESTAMP data type
(from the beginning of 1970 partially through 2038), the UNIX_TIMESTAMP() and
FROM_UNIXTIME() functions convert to and from the number of seconds elapsed since
the beginning of 1970

2) Change the session time zone to '+00:00' for UTC time and
run the query again to observe a different result

3) UNIX_TIMESTAMP() can convert DATE values to seconds, too. It treats such values as
having an implicit time-of-day part of 00:00:00
*/
1)
mysql> SELECT dt,
	-> UNIX_TIMESTAMP(dt) AS seconds,
	-> FROM_UNIXTIME(UNIX_TIMESTAMP(dt)) AS timestamp
	-> FROM datetime_val;

2)
mysql> set time_zone = '+00:00';
mysql> SELECT dt,
	-> UNIX_TIMESTAMP(dt) AS seconds,
	-> FROM_UNIXTIME(UNIX_TIMESTAMP(dt)) AS timestamp
	-> FROM datetime_val;
	
3)
mysql> SELECT
	-> CURDATE(),
	-> UNIX_TIMESTAMP(CURDATE()),
	-> FROM_UNIXTIME(UNIX_TIMESTAMP(CURDATE()))\G
