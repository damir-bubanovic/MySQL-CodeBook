/*

!!DATE & TIME - CHOOSING A TEMPORAL DATA TYPE!!

> You need to store temporal data but aren’t sure which is the most appropriate data type

> Choose the data type according to the characteristics of the information to be stored
and how you need to use it

*/

/*
QUESTIONS:
> consider questions such as these
	• Do you need times only, dates only, or combined date and time values?
	• What range of values do you require?
	• Do you want automatic initialization of the column to the current date and time?

	
> MySQL provides DATE and TIME data types for representing date and time values separately,
and DATETIME and TIMESTAMP types for combined date-and-time values. 
	> These values have the following characteristics:
		• DATE values have CCYY-MM-DD format, where CC, YY, MM, and DD represent the century,
		year within century, month, and day parts of the date. 
		
		• TIME values have hh:mm:ss format, where hh, mm, and ss are the hours, minutes,
		and seconds parts of the time. 
		
		• DATETIME and TIMESTAMP are combined date-and-time values in CCYY-MM-DD
		hh:mm:ss format.
		> The DATETIME and TIMESTAMP data types are similar in many respects, but watch
		out for these difference:
			- When a client inserts a TIMESTAMP value, the server converts it from the time
			zone associated with the client session to UTC and stores the UTC value. When
			the client retrieves a TIMESTAMP value, the server performs the reverse operation
			to convert the UTC value back to the client session time zone. A client in a time
			zone different from the server can configure its session so that this conversion
			is appropriate for its own time zone
			
		• Types that include a time part can have a fractional seconds part for subsecond
		resolution
*/

/*
> Many of the examples in this chapter draw on the following tables, which contain columns
representing time, date, and date-and-time values
*/
mysql> SELECT t1, t2 FROM time_val;

mysql> SELECT d FROM date_val;

mysql> SELECT dt FROM datetime_val;
