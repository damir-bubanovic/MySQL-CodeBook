/*

!!DATE & TIME - ADDING DATE OR TIME VALUES!!

> You want to add temporal values. 
	>> npr. you want to add a given number of seconds to a time or determine 
	what the date will be three weeks from today

> To add date or time values, you have several options:
	• Use one of the temporal-addition functions.
	• Use the + INTERVAL or - INTERVAL operator.
	• Convert the values to basic units, and take the sum.	
	
*/

/*
ADDING TEMPORAL VALUES USING TEMPORAL-ADDITION FUNCTION OR OPERATORS

EXAMPLE:
1) To add a time to a time or date-and-time value, use the ADDTIME() function

2) To add a time to a date or date-and-time value, use the TIMESTAMP() function

> Use DATE_ADD() or DATE_SUB() to perform date arithmetic operations such as these
3) Determine the date three days from today

4) Find the date a week ago

5) For questions where you need to know both the date and the time, begin with a
DATETIME or TIMESTAMP value. 
	> To answer the question, “What time will it be in 60 hours?” do this

6) Some interval specifiers have both date and time parts. The following adds 14.5
hours to the current date and time

7) Similarly, adding 3 days and 4 hours produces this result

8) Use the + INTERVAL or - INTERVAL operator to perform date interval addition
or subtraction
*/
1)
mysql> SET @t1 = '12:00:00', @t2 = '15:30:00';
mysql> SELECT ADDTIME(@t1,@t2);

mysql> SET @dt = '1984-03-01 12:00:00', @t = '12:00:00';
mysql> SELECT ADDTIME(@dt,@t);

2)
mysql> SET @d = '1984-03-01', @t = '15:30:00';
mysql> SELECT TIMESTAMP(@d,@t);

mysql> SET @dt = '1984-03-01 12:00:00', @t = '12:00:00';
mysql> SELECT TIMESTAMP(@dt,@t);

3)
mysql> SELECT CURDATE(), DATE_ADD(CURDATE(),INTERVAL 3 DAY);

4)
mysql> SELECT CURDATE(), DATE_SUB(CURDATE(),INTERVAL 1 WEEK);

5) 
mysql> SELECT NOW(), DATE_ADD(NOW(),INTERVAL 60 HOUR);

6) 
mysql> SELECT NOW(), DATE_ADD(NOW(),INTERVAL '14:30' HOUR_MINUTE);

7)
mysql> SELECT NOW(), DATE_ADD(NOW(),INTERVAL '3 4' DAY_HOUR);

8)
mysql> SELECT CURDATE(), CURDATE() + INTERVAL 1 YEAR;

mysql> SELECT NOW(), NOW() - INTERVAL '1 12' DAY_HOUR;


/*
ADDING TEMPORAL VALUERS USING BASIC UNITS
> Another way to add intervals to date or date-and-time values is to perform temporal
“shifting” via functions that convert to and from basic units
*/


/*
ADDING TIME VALUES USING BASIC UNITS
> Adding times with basic units is similar to calculating intervals between times, except
that you compute a sum rather than a difference

EXAMPLE:
1) Two hours is 7,200 seconds (2 × 60 × 60), so the following statement adds two hours to each 
t1 value in the time_val table

2) Sum of the two TIME values in each row of the time_val table

*/
1)
mysql> SELECT t1,
	-> SEC_TO_TIME(TIME_TO_SEC(t1) + 7200) AS 't1 plus 2 hours'
	-> FROM time_val;
	
2)
mysql> SELECT t1, t2,
	-> TIME_TO_SEC(t1) + TIME_TO_SEC(t2)
	-> AS 't1 + t2 (in seconds)',
	-> SEC_TO_TIME(TIME_TO_SEC(t1) + TIME_TO_SEC(t2))
	-> AS 't1 + t2 (as TIME)'
	-> FROM time_val;
	
	
/*
ADDING TO DATE OR DATE-ADN TIME VALUES USING BASIC UNITS
> Date or date-and-time values converted to basic units can be shifted to produce other
dates

EXAMPLE:
1) shift a date forward or backward a week (seven days), use TO_DAYS() and FROM_DAYS()

2) shifts a DATETIME value forward and backward by an hour (3,600 seconds)
*/
1)
mysql> SET @d = '1980-01-01';
mysql> SELECT @d AS date,
	-> FROM_DAYS(TO_DAYS(@d) + 7) AS 'date + 1 week',
	-> FROM_DAYS(TO_DAYS(@d) - 7) AS 'date - 1 week';

2)
mysql> SET @dt = '1980-01-01 09:00:00';
mysql> SELECT @dt AS datetime,
	-> FROM_UNIXTIME(UNIX_TIMESTAMP(@dt) + 3600) AS 'datetime + 1 hour',
	-> FROM_UNIXTIME(UNIX_TIMESTAMP(@dt) - 3600) AS 'datetime - 1 hour';
