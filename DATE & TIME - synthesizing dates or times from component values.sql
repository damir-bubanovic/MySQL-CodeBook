/*

!!DATE & TIME - SYNTHESIZING DATES OR TIMES FROM COMPONENT VALUES!!

> You want to combine the parts of a date or time to produce a complete date or time
value. Or you want to replace parts of a date to produce another date

> You have several options:
	• Use MAKETIME() to construct a TIME value from hour, minute, and second parts.
	• Use DATE_FORMAT() or TIME_FORMAT() to combine parts of the existing value with
	parts you want to replace.
	• Pull out the parts that you need with component-extraction functions and recombine
	the parts with CONCAT().

*/

/*
EXAMPLE:
> The reverse of splitting a date or time value into components is synthesizing a temporal
value from its constituent parts
1) The MAKETIME() function takes component hour, minute, and second values as arguments
and combines them to produce a time

> Date synthesis often is performed beginning with a given date, then keeping parts that
you want to use and replacing the rest
2) Produce the first day of the month in which a date falls, use DATE_FORMAT() to extract 
the year and month parts from the date, combining them with a day part of 01

3) TIME_FORMAT() can be used similarly. The following example produces time values that
have the seconds part set to 00

> TIME values can be produced from hours, minutes, and seconds values using methods
analogous to those for creating DATE values
4) Change a TIME value so that its seconds part is 00, extract the hour and minute parts, 
and then recombine them with CONCAT()

5) To produce a combined date-and-time value from separate date and time values, simply
concatenate them separated by a space
*/
1)
mysql> SELECT MAKETIME(10,30,58), MAKETIME(-5,0,11);

2)
mysql> SELECT d, DATE_FORMAT(d,'%Y-%m-01') FROM date_val;

3)
mysql> SELECT t1, TIME_FORMAT(t1,'%H:%i:00') FROM time_val;

4)
mysql> SELECT t1,
	-> CONCAT(LPAD(HOUR(t1),2,'0'),':',LPAD(MINUTE(t1),2,'0'),':00')
	-> AS recombined
	-> FROM time_val;
	
5)
mysql> SET @d = '2014-02-28', @t = '13:10:05';
mysql> SELECT @d, @t, CONCAT(@d,' ',@t);
