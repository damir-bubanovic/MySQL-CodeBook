/*

!!DATE & TIME - CHANGING MySQL DATE FORMAT!!

> You want to change the ISO format that MySQL uses for representing date values

> You can’t. 
	>> However, you can rewrite non-ISO input values into ISO format when storing
	dates, and you can rewrite ISO values to other formats for display with the 
	DATE_FORMAT() function

*/

/*
> The CCYY-MM-DD format that MySQL uses for DATE values follows the ISO 8601 standard
for representing dates
> MySQL always stores dates in ISO format, a fact with implications both
for data entry (input) and for displaying query results (output)
	• For data-entry purposes, to store values that are not in ISO format, you normally
	must rewrite them first. 
		>> If you don’t want to rewrite them, you can store them as	strings 
		(for example, in a CHAR column). But then you can’t operate on them as dates.
		>> In some cases, if your values are close to ISO format, rewriting may not be necessary. 
			>>> npr. MySQL interprets the string values 87-1-7 and 1987-1-7 and the numbers 
			870107 and 19870107 as the date 1987-01-07 when storing them into a DATE column.
	• For display purposes, you can rewrite dates to non-ISO formats. The DATE_FORMAT() function 
	provides a lot of flexibility for changing date values into other formats
		>> You can also use functions such as YEAR() to extract parts of dates for display 


EXAMPLE:
> One way to rewrite non-ISO values for date entry is to use the STR_TO_DATE() function,
which takes a string representing a temporal value and a format string that specifies the
“syntax” of the value
*/
mysql> INSERT INTO t (d) VALUES(STR_TO_DATE('May 13, 2007','%M %d, %Y'));
mysql> SELECT d FROM t;

/*
> For date display, MySQL uses ISO format (CCYY-MM-DD) unless you tell it otherwise. 
	>> To display dates or times in other formats, use the DATE_FORMAT() or TIME_FORMAT()
	function to rewrite them

EXAMPLE:
1) Shows the values in the date_val table, both as MySQL displays 
them by default and as reformatted with DATE_FORMAT()

2) Because DATE_FORMAT() produces long column headings, it’s often useful to provide an
alias (see Recipe 3.2) to make a heading more concise or meaningful
*/
1)
mysql> SELECT d, DATE_FORMAT(d,'%M %d, %Y') FROM date_val;

2)
mysql> SELECT d, DATE_FORMAT(d,'%M %d, %Y') AS date FROM date_val;


/*
> MySQL Reference Manual provides a complete list of format sequences to use with
DATE_FORMAT(), TIME_FORMAT(), and STR_TO_DATE()

Sequence 	Meaning
%Y 			Four-digit year
%y 			Two-digit year
%M 			Complete month name
%b 			Month name, initial three letters
%m 			Two-digit month of year (01..12)
%c 			Month of year (1..12)
%d 			Two-digit day of month (01..31)
%e 			Day of month (1..31)
%W 			Weekday name (Sunday..Saturday)
%r 			12-hour time with AM or PM suffix
%T 			24-hour time
%H 			Two-digit hour
%i 			Two-digit minute
%s 			Two-digit second
%% 			Literal %
*/

/*
> The time-related format sequences shown in the table are useful only when you pass
DATE_FORMAT() a value that has both date and time parts (a DATETIME or TIMESTAMP)

EXAMPLE:
1) The following statement displays DATETIME values from the datetime_val table using
formats that include the time of day

2) TIME_FORMAT() is similar to DATE_FORMAT(). It works with TIME, DATETIME, or TIME
STAMP values, but understands only time-related specifiers in the format string


> If DATE_FORMAT() or TIME_FORMAT() cannot produce the results that you want, write a
stored function that does
3) convert 24-hour TIME values to 12-hour format but with a suffix of a.m. or p.m. 
rather than AM or PM.
*/
1)
mysql> SELECT dt,
	-> DATE_FORMAT(dt,'%c/%e/%y %r') AS format1,
	-> DATE_FORMAT(dt,'%M %e, %Y %T') AS format2
	-> FROM datetime_val;
	
2)
mysql> SELECT dt,
	-> TIME_FORMAT(dt, '%r') AS '12-hour time',
	-> TIME_FORMAT(dt, '%T') AS '24-hour time'
	-> FROM datetime_val;
	
3)
CREATE FUNCTION time_ampm (t TIME)
RETURNS VARCHAR(13) # mm:dd:ss {a.m.|p.m.} format
DETERMINISTIC
RETURN CONCAT(LEFT(TIME_FORMAT(t, '%r'), 9),
	IF(TIME_TO_SEC(t) < 12*60*60, 'a.m.', 'p.m.'));
	
mysql> SELECT t1, time_ampm(t1) FROM time_val
