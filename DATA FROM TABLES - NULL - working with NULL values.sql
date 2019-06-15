/*

!!SELECTING DATA FROM TABLES - WORKING WITH NULL VALUES!!

> You’re trying to to compare column values to NULL, but it isn’t working

> Use the proper comparison operators: IS NULL, IS NOT NULL, or <=>

*/


/*
EXAMPLE:
> Write the statements like this
*/
mysql> SELECT * FROM expt WHERE score IS NULL;

mysql> SELECT * FROM expt WHERE score IS NOT NULL;


/*
EXAMPLE:
> The MySQL-specific <=> comparison operator, unlike the = operator, is true even for
two NULL values
*/
mysql> SELECT NULL = NULL, NULL <=> NULL;


/*
EXAMPLE:
> Sometimes it’s useful to map NULL values onto some other value that has more meaning
in the context of your application. 
	>> npr. use IF() to map NULL onto the string Unknown
*/
mysql> SELECT subject, test, IF(score IS NULL,'Unknown', score) AS 'score'
	-> FROM expt;