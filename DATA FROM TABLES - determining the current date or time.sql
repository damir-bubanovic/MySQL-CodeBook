/*

!!DATE & TIME - DETERMINING THE CURRENT DATA OR TIME!!

> What’s today’s date? What time is it?

> Use the CURDATE(), CURTIME(), or NOW() functions to obtain values expressed in the
client session time zone. Use UTC_DATE(), UTC_TIME(), or UTC_TIMESTAMP() for values
in UTC time


> Some applications must know the current date or time, such as those that write timestamped
log records. 
	>> This kind of information is also useful for date calculations performed in relation to 
	the current date, such as finding the first (or last) day of the month, or determining the 
	date for Wednesday of next week

*/

/*
EXAMPLE:
> The CURDATE() and CURTIME() functions return the current date and time separately,
and NOW() returns both as a combined date-and-time value
*/
mysql> SELECT CURDATE(), CURTIME(), NOW();