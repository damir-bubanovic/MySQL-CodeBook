/*

!!DATE & TIME - CALCULATING DATES BY SUBSTRING REPLACEMENT!!

> Given a date, you want to produce another date from it when you know that the two
dates share some components in common

> Treat a date or time value as a string, and perform direct replacement on parts of the
string

*/

/*
> In some cases, you can use substring replacement to calculate dates without performing
any date arithmetic

EXAMPLE:
1) string operation produces the first-of-month value for a given date by replacing the 
day component with 01. You can do this either with DATE_FORMAT() or with CONCAT()

> The string replacement technique can also produce dates with a specific position within
the calendar year
2) For New Year’s Day (January 1), replace the month and day with 01;
for Christmas, replace the month and day with 12 and 25

3) The following statement shows two ways to determine the date for Christmas two years hence
*/
1)
mysql> SELECT d,
	-> DATE_FORMAT(d,'%Y-%m-01') AS '1st of month A',
	-> CONCAT(YEAR(d),'-',LPAD(MONTH(d),2,'0'),'-01') AS '1st of month B'
	-> FROM date_val;
	
2) 
mysql> SELECT d,
	-> DATE_FORMAT(d,'%Y-01-01') AS 'New Year''s A',
	-> CONCAT(YEAR(d),'-01-01') AS 'New Year''s B',
	-> DATE_FORMAT(d,'%Y-12-25') AS 'Christmas A',
	-> CONCAT(YEAR(d),'-12-25') AS 'Christmas B'
	-> FROM date_val;
	
3)
mysql> SELECT CURDATE(),
	-> DATE_ADD(DATE_FORMAT(CURDATE(),'%Y-12-25'),INTERVAL 2 YEAR)
	-> AS 'Christmas A',
	-> DATE_FORMAT(DATE_ADD(CURDATE(),INTERVAL 2 YEAR),'%Y-12-25')
	-> AS 'Christmas B';