/*

!!DATE & TIME - EXTRACTING PARTS OF DATES OR TIMES!!

> You want to obtain just a part of a date or a time

> Invoke a function specifically intended for extracting part of a temporal value, such as
MONTH() or MINUTE(). 
	>> This is usually the fastest method for component extraction if you need only a single 
	component of a value. 
	>> Alternatively, use a formatting function such as DATE_FORMAT() or TIME_FORMAT() with a 
	format string that includes a specifier for the part of the value you want to obtain

*/

/*
EXAMPLE:
> DATE() and TIME() extract the date and time components of temporal values
*/
mysql> SELECT dt, DATE(dt), TIME(dt) FROM datetime_val;

/*
> several component-extraction functions

Function 		Return value
YEAR() 			Year of date
MONTH() 		Month number (1..12)
MONTHNAME() 	Month name (January..December)
DAYOFMONTH() 	Day of month (1..31)
DAYNAME() 		Day name (Sunday..Saturday)
DAYOFWEEK() 	Day of week (1..7 for Sunday..Saturday)
WEEKDAY() 		Day of week (0..6 for Monday..Sunday)
DAYOFYEAR() 	Day of year (1..366)
HOUR() 			Hour of time (0..23)
MINUTE() 		Minute of time (0..59)
SECOND() 		Second of time (0..59)
EXTRACT() 		Varies

1)

2) day-of-year value
*/
1)
mysql> SELECT dt, YEAR(dt), DAYOFMONTH(dt), HOUR(dt), SECOND(dt)
	-> FROM datetime_val;

2)
mysql> SELECT d, DAYOFYEAR(d) FROM date_val;	


/*
> day of the week, which is available by name or number

EXAMPLE:
1) DAYNAME() returns the complete day name. 
	>> There is no function for returning the three-character name abbreviation, 
	but you can get it easily by passing the full name to LEFT()
	
2) To get the day of the week as a number, use DAYOFWEEK() or WEEKDAY(), but pay
attention to the range of values each function returns
*/
1)
mysql> SELECT d, DAYNAME(d), LEFT(DAYNAME(d),3) FROM date_val;

2)
mysql> SELECT d, DAYNAME(d), DAYOFWEEK(d), WEEKDAY(d) FROM date_val;

/*
EXAMPLE:
> EXTRACT() is another function for obtaining individual parts of temporal values
*/
mysql> SELECT dt, EXTRACT(DAY FROM dt), EXTRACT(HOUR FROM dt)
	-> FROM datetime_val;


/*
EXAMPLE:
1) To obtain the current year, month, day, or day of week, apply the extraction functions
shown in this recipe to CURDATE() or NOW()

2) To obtain the current hour, minute, or second, pass CURTIME() or NOW() to a
time-component function
*/
1)
mysql> SELECT CURDATE(), YEAR(CURDATE()) AS year,
	-> MONTH(CURDATE()) AS month, MONTHNAME(CURDATE()) AS monthname,
	-> DAYOFMONTH(CURDATE()) AS day, DAYNAME(CURDATE()) AS dayname;

2)
mysql> SELECT NOW(), HOUR(NOW()) AS hour,
	-> MINUTE(NOW()) AS minute, SECOND(NOW()) AS second;


/*
DECOMPOSING DATES OR TIMES USING FORMATTING FUNCTIONS
1) The DATE_FORMAT() and TIME_FORMAT() functions reformat date and time values. 
	> By specifying appropriate format strings, you can extract individual parts of 
	temporal values

2) Formatting functions are advantageous when you want to extract more than one part
of a value, or display extracted values in a format different from the default. 
	> npr. to extract the entire date or time from DATETIME values, do this

3) To present a date in other than CCYY-MM-DD format or a time without the seconds part
*/
1)
mysql> SELECT dt,
	-> DATE_FORMAT(dt,'%Y') AS year,
	-> DATE_FORMAT(dt,'%d') AS day,
	-> TIME_FORMAT(dt,'%H') AS hour,
	-> TIME_FORMAT(dt,'%s') AS second
	-> FROM datetime_val;

2)
mysql> SELECT dt,
	-> DATE_FORMAT(dt,'%Y-%m-%d') AS 'date part',
	-> TIME_FORMAT(dt,'%T') AS 'time part'
	-> FROM datetime_val;

3)
mysql> SELECT dt,
	-> DATE_FORMAT(dt,'%M %e, %Y') AS 'descriptive date',
	-> TIME_FORMAT(dt,'%H:%i') AS 'hours/minutes'
	-> FROM datetime_val;
