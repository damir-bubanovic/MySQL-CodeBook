/*

!!DATE & TIME - CANONIZING NOT-QUITE-ISO DATE STRINGS!!

> A date is in a format that’s close to but not exactly ISO format

> Canonize the date by passing it to a function that always returns an 
ISO-format date result.

*/

/*
> we ran into the problem that synthesizing dates with CONCAT() may produce
values that are not quite in ISO format. 
	1) npr. the following statement produces first-of-month values in which 
	the month part may have only a single digit
	
2) Another way to standardize a close-to-ISO date is to use it in an expression that
produces an ISO date result. For a date d, any of the following expressions will do

3) Using those expressions with the non-ISO results from the CONCAT() operation yields
ISO format in several ways
*/
1)
mysql> SELECT d, CONCAT(YEAR(d),'-',MONTH(d),'-01') FROM date_val;

2)
DATE_ADD(d,INTERVAL 0 DAY)
d + INTERVAL 0 DAY
FROM_DAYS(TO_DAYS(d))
STR_TO_DATE(d,'%Y-%m-%d')

3)
mysql> SELECT
	-> CONCAT(YEAR(d),'-',MONTH(d),'-01') AS 'non-ISO',
	-> DATE_ADD(CONCAT(YEAR(d),'-',MONTH(d),'-01'),INTERVAL 0 DAY) AS 'ISO 1',
	-> CONCAT(YEAR(d),'-',MONTH(d),'-01') + INTERVAL 0 DAY AS 'ISO 2',
	-> FROM_DAYS(TO_DAYS(CONCAT(YEAR(d),'-',MONTH(d),'-01'))) AS 'ISO 3',
	-> STR_TO_DATE(CONCAT(YEAR(d),'-',MONTH(d),'-01'),'%Y-%m-%d') AS 'ISO 4'
	-> FROM date_val;