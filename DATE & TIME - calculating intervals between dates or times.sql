/*

!!DATE & TIME - CALCULATING INTERVALS BETWEEN DATES OR TIMES!!

> You want to know how long it is between two dates or times; that is, the 
interval between them

> To calculate an interval, use one of the temporal-difference functions, or convert your
values to basic units and take the difference. 
	>> The permitted functions depend on the types of the values for which you want to 
	know the interval

*/

/*
CALCULATING INTERVALS WITH TEMPORAL-DIFFERENCE FUNCTIONS

EXAMPLE:
1) To calculate an interval in days between two date values, use the DATEDIFF() function
	> DATEDIFF() also works with date-and-time values, but ignores the time part. 
	> This makes it suitable for producing day intervals for DATE, DATETIME, or TIMESTAMP values

2) To calculate an interval between TIME values as another TIME value, use the TIME
DIFF() function
	> TIMEDIFF() also works for date-and-time values. 
	> That is, it accepts either time or dateand-time values, but the types of the arguments 
	must match
	
> to express a time interval in terms of its constituent hours, minutes, and seconds values, 
calculate time interval subparts using the HOUR(), MINUTE(), and SECOND() functions.
	3) The following SQL statement shows how to determine the components of the interval between 
	the t1 and t2 columns of the time_val table
*/
1)
mysql> SET @d1 = '2010-01-01', @d2 = '2009-12-01';
mysql> SELECT DATEDIFF(@d1,@d2) AS 'd1 - d2', DATEDIFF(@d2,@d1) AS 'd2 - d1';

2)
mysql> SET @t1 = '12:00:00', @t2 = '16:30:00';
mysql> SELECT TIMEDIFF(@t1,@t2) AS 't1 - t2', TIMEDIFF(@t2,@t1) AS 't2 - t1';

3)
mysql> SELECT t1, t2,
	-> TIMEDIFF(t2,t1) AS 't2 - t1 as TIME',
	-> IF(TIMEDIFF(t2,t1) >= 0,'+','-') AS sign,
	-> HOUR(TIMEDIFF(t2,t1)) AS hour,
	-> MINUTE(TIMEDIFF(t2,t1)) AS minute,
	-> SECOND(TIMEDIFF(t2,t1)) AS second
	-> FROM time_val;
	
	
/*
CALCULATING INTERVALS USING BASIC UNITS

> Another strategy for calculating intervals is to work with basic units such as seconds or
days:
	1. Convert your temporal values to basic units.
	2. Take the difference between the values to calculate the interval, also in basic units.
	3. If you want the result as a temporal value, convert it from basic units to the appropriate
	type
	
> The conversion functions involved in implementing this strategy depend on the types
of the values between which you calculate the interval:
	• To convert between time values and seconds, use TIME_TO_SEC() and
	SEC_TO_TIME().
	• To convert between date values and days, use TO_DAYS() and FROM_DAYS().
	• To convert between date-and-time values and seconds, use UNIX_TIMESTAMP() and
	FROM_UNIXTIME().
*/


/*
TIME INTERVAL CALCULATION USING BASIC UNITS
> To calculate intervals in seconds between pairs of time values, convert them to seconds
with TIME_TO_SEC() and take the difference. 
> To express the resulting interval as a TIME value, pass it to SEC_TO_TIME().

EXAMPLE:
> Calculates the intervals between the t1 and t2 columns of the time_val table, expressing each 
interval both in seconds and as a TIME value:
*/
mysql> SELECT t1, t2,
	-> TIME_TO_SEC(t2) - TIME_TO_SEC(t1) AS 't2 - t1 (in seconds)',
	-> SEC_TO_TIME(TIME_TO_SEC(t2) - TIME_TO_SEC(t1)) AS 't2 - t1 (as TIME)'
	-> FROM time_val;


/*
DATE OR DATE-AND-TIME INTERVAL CALCULATION USING BASIC UNITS
> When you calculate an interval between dates by converting both dates to a common
unit in relation to a given reference point and take the difference, the range of your
values determines which conversions are available:
	• DATE, DATETIME, or TIMESTAMP values dating back to 1970-01-01 00:00:00 UTC—
	the Unix epoch—can be converted to seconds elapsed since the epoch. With dates
	in that range, you can calculate intervals to an accuracy of one second.
	• Older dates from the beginning of the Gregorian calendar (1582) on can be converted
	to day values and used to compute intervals in days.
	• Dates that begin earlier than either of these reference points present more of a
	problem. In such cases, you may find that your programming language offers computations
	that are not available or are difficult to perform in SQL. If so, consider
	processing date values directly from within your API language. For example, the
	Date::Calc and Date::Manip modules are available from CPAN for use in Perl
	scripts.
	
EXAMPLE:
1) To calculate an interval in days between date or date-and-time values, convert them to
days with TO_DAYS() and take the difference

2) For intervals in other units, seconds are easily converted to minutes, hours, days, or weeks, 
as this expression shows for dates that lie two weeks apart
	> Use FLOOR() on the division results if you prefer integer values that have no fractional
	part
*/
1)
mysql> SET @days = TO_DAYS('1884-01-01') - TO_DAYS('1883-06-05');
mysql> SELECT @days AS days, @days/7 AS weeks;

2)
mysql> SET @dt1 = '1984-01-01 09:00:00';
mysql> SET @dt2 = @dt1 + INTERVAL 14 DAY;
mysql> SET @interval = UNIX_TIMESTAMP(@dt2) - UNIX_TIMESTAMP(@dt1);
mysql> SELECT @interval AS seconds,
	-> @interval / 60 AS minutes,
	-> @interval / (60 * 60) AS hours,
	-> @interval / (24 * 60 * 60) AS days,
	-> @interval / (7 * 24 * 60 * 60) AS weeks;
