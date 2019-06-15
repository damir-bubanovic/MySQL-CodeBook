/*

!!SELECTING DATA FROM TABLES - REMOVING DUPLICATE ROWS!!

> Output from a query contains duplicate rows. You want to eliminate them

> Use DISTINCT

*/

/*
EXAMPLE:
> Some queries produce results containing duplicate rows

1)To remove the duplicate rows and produce a set of
unique values, add DISTINCT to the query

2) To count the number of unique values in a column, use COUNT(DISTINCT)

> DISTINCT works with multiple-column output, too. 
3) The following query shows which dates are represented in the mail table
*/
1)
mysql> SELECT DISTINCT srcuser FROM mail;

2) 
mysql> SELECT COUNT(DISTINCT srcuser) FROM mail;

3) 
mysql> SELECT DISTINCT YEAR(t), MONTH(t), DAYOFMONTH(t) FROM mail;