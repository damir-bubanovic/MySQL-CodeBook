/*

!!DATE & TIME - CALCULATING AGES!!

> You want to know how old someone is

> This is a date-arithmetic problem. It amounts to computing the interval between dates,
but with a twist. 
	>> For an age in years, it’s necessary to account for the relative placement
	of the start and end dates within the calendar year. 
	>> For an age in months, it’s also necessary to account for the placement of the 
	months and the days within the month

*/

/*
EXAMPLE:
1) To calculate ages, use the TIMESTAMPDIFF() function. Pass it a birth date, a current date,
and the unit in which you want the age expressed

2) TIMESTAMPDIFF() handles the calculations necessary to adjust for differing month and
year lengths and relative positions of the dates within the calendar year

3) How old are the Smith children today, in years and months?

4) How old were Gretchen and Wilbur when Franz was born, in years and months?
*/
1)
TIMESTAMPDIFF(unit,birth,current)

2)
mysql> SELECT * FROM sibling;

3)
mysql> SELECT name, birth, CURDATE() AS today,
	-> TIMESTAMPDIFF(YEAR,birth,CURDATE()) AS 'age in years',
	-> TIMESTAMPDIFF(MONTH,birth,CURDATE()) AS 'age in months'
	-> FROM sibling;
	
4) 
mysql> SELECT name, birth, '1953-03-05' AS 'Franz'' birth',
	-> TIMESTAMPDIFF(YEAR,birth,'1953-03-05') AS 'age in years',
	-> TIMESTAMPDIFF(MONTH,birth,'1953-03-05') AS 'age in months'
	-> FROM sibling WHERE name <> 'Franz';