/*

!!SELECTING DATA FROM TABLES - SORTING QUERY RESULTS!!

> Your query results aren’t sorted the way you want

> Use an ORDER BY clause to tell it how to sort result rows

*/


/*
EXAMPLE:
> This statement names multiple columns in the ORDER BY clause to sort rows 
by host and by user within each host
*/
mysql> SELECT * FROM mail WHERE dstuser = 'tricia'
	-> ORDER BY srchost, srcuser;
	
/*
EXAMPLE:
> To sort a column in reverse (descending) order, add the keyword DESC after 
its name in the ORDER BY clause
*/
mysql> SELECT * FROM mail WHERE size > 50000 ORDER BY size DESC;