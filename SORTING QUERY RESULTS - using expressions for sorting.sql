/*

!!SORTING QUERY RESULTS - USING EXPRESSIONS FOR SORTING!!

> sort a query result based on values calculated from a column rather than
the values actually stored in the column

> Put the expression that calculates the values in the ORDER BY clause

*/

/*
> Suppose that you want to retrieve rows for “big” mail messages (defined as those larger
than 50,000 bytes), but you want them to be displayed and sorted by sizes in terms of
kilobytes, not bytes. 
	1) In this case, the values to sort are calculated by an expression
	>> The +1023 in the FLOOR() expression groups size values to the nearest upper boundary
	of the 1,024-byte categories
	
	2) To sort by that expression, put it directly in the ORDER BY clause
	
	3) Alternatively, if the sorting expression appears in the output column list, you can alias
	it there and refer to the alias in the ORDER BY clause
*/
1)
FLOOR((size+1023)/1024)

2)
mysql> SELECT t, srcuser, FLOOR((size+1023)/1024)
	-> FROM mail WHERE size > 50000
	-> ORDER BY FLOOR((size+1023)/1024);
	
3)
mysql> SELECT t, srcuser, FLOOR((size+1023)/1024) AS kilobytes
	-> FROM mail WHERE size > 50000
	-> ORDER BY kilobytes;