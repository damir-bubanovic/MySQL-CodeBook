/*

!!SORTING QUERY RESULTS - BASIC!!

> To sort a query result, add an ORDER BY clause to the query

> You can sort rows of a query result several ways:
	• Using a single column, a combination of columns, or even parts of columns or
	expression results
	• Using ascending or descending order
	• Using case-sensitive or case-insensitive string comparisons
	• Using temporal ordering

*/

/*
1) Several examples in this chapter use the driver_log table, which contains columns for
recording daily mileage logs for a set of truck drivers

2) Many other examples use the mail table (used in earlier chapters)
*/
1)
mysql> SELECT * FROM driver_log;

2)
mysql> SELECT * FROM mail;