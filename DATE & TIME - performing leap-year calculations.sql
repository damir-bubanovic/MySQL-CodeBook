/*

!!DATE & TIME - PERFORMING LEAP-YEAR CALCULATIONS!!

> A date calculation must account for leap years. 
	>> The length of a month or a year depends on whether the date falls in a leap year

> Know how to test whether a year is a leap year, and factor the result into your calculation

*/

/*
DETERMINING WHEATHER A DATE OCCURS IN A LEAP YEAR
> For a year to qualify as a leap year, it must satisfy both of
these constraints:
	• The year must be divisible by four
	• The year cannot be divisible by 100, unless it is also divisible by 400

> Running our date_val table through both the rule-of-thumb leap-year test and the
complete test produces the following results
*/
mysql> SELECT
	-> d,
	-> YEAR(d) % 4 = 0
	-> AS 'rule-of-thumb test',
	-> (YEAR(d) % 4 = 0) AND ((YEAR(d) % 100 <> 0) OR (YEAR(d) % 400 = 0))
	-> AS 'complete test'
	-> FROM date_val;
	
/*
PHP
*/
$year = substr ($date, 0, 4);
$is_leap = ($year % 4 == 0) && ($year % 100 != 0 || $year % 400 == 0);


/*
USING LEAP-YEAR TESTS FOR YEAR-LENGTH CALCULATIONS
> To compute a year’s length in SQL, compute the date of the last day of the year and pass
it to DAYOFYEAR()
*/
mysql> SET @d1 = '2014-04-13', @d2 = '2016-04-13';
mysql> SELECT
	-> DAYOFYEAR(DATE_FORMAT(@d1,'%Y-12-31')) AS 'days in 2014',
	-> DAYOFYEAR(DATE_FORMAT(@d2,'%Y-12-31')) AS 'days in 2016';
	
