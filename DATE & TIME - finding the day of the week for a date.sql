/*

!!DATE & TIME - FINDING THE DAY OF THE WEEK FOR A DATE!!

> You want to know the day of the week on which a date falls

> Use the DAYNAME() function

*/

/*
EXAMPLE:
1) To determine the name of the day of the week for a given date, use DAYNAME()

2) DAYNAME() is often useful in conjunction with other date-related techniques
	> determine the day of the week for the first of the month, use the first-of-month
	expression
*/
1)
mysql> SELECT CURDATE(), DAYNAME(CURDATE());

2)
mysql> SET @d = CURDATE();
mysql> SET @first = DATE_SUB(@d,INTERVAL DAYOFMONTH(@d)-1 DAY);
mysql> SELECT @d AS 'starting date',
	-> @first AS '1st of month date',
	-> DAYNAME(@first) AS '1st of month day';