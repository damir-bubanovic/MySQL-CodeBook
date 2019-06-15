/*

!!DATE & TIME - SELECTING ROWS BASED ON TEMPORAL CHARACTERISTICS!!

> You want to select rows based on temporal conditions

> Use a date or time condition in the WHERE clause
	> select rows by looking for values that occur before or after a given date, within a
	date range, or that match particular month or day values

*/

/*
COMPARING DATES TO ONE ANOTHER

EXAMPLE:
1) find rows from the date_val table that occur either before 1900 or during the 1900s

> When you don’t know the exact date needed for a comparison in a WHERE clause, you
can often calculate it using an expression
	2) perform an “on this day in history” statement to search for rows in a table named 
	history to find events occurring exactly 50 years ago
	
3) find dates that occur later than 20 years ago, use DATE_SUB() to calculate the cutoff date
*/
1)
mysql> SELECT d FROM date_val where d < '1900-01-01';

mysql> SELECT d FROM date_val where d BETWEEN '1900-01-01' AND '1999-12-31';

2)
SELECT * FROM history WHERE d = DATE_SUB(CURDATE(),INTERVAL 50 YEAR);

3)
mysql> SELECT d FROM date_val WHERE d >= DATE_SUB(CURDATE(),INTERVAL 20 YEAR);


/*
COMPARING TIMES TO ONE ANOTHER
> find times in the t1 column that occurred from 9 AM to 2 PM
*/
WHERE t1 BETWEEN '09:00:00' AND '14:00:00';
WHERE HOUR(t1) BETWEEN 9 AND 14;

/*
COMPARING DATES TO CALENDAR DAYS
1) Who has a birthday today? This requires matching a particular calendar day, so you
extract the month and day but ignore the year when performing comparisons

2) Who has a birthday this month? In this case, it’s necessary to check only the month

3) Who has a birthday next month?
*/
1)
WHERE MONTH(d) = MONTH(CURDATE()) AND DAYOFMONTH(d) = DAYOFMONTH(CURDATE());

2)
WHERE MONTH(d) = MONTH(CURDATE());

3)
WHERE MONTH(d) = MONTH(DATE_ADD(CURDATE(),INTERVAL 1 MONTH));
WHERE MONTH(d) = MOD(MONTH(CURDATE()),12)+1;
