/*

!!SORTING QUERY RESULTS - USING ORDER BY TO SORT QUERY RESULTS!!

> Rows in a query result don’t appear in the order you want

> Add an ORDER BY clause to the query to sort its result

*/

/*
> Rows do tend to be returned from a table in the order in which they were 
originally inserted, but only until the table is subjected to delete and update 
operations
> Rows inserted after that are likely to be returned in the middle of the result 
set somewhere

> ORDER BY has the following general characteristics:
	• You can sort using one or more column or expression values.
	• You can sort columns independently in ascending order (the default) or descending
	order.
	• You can refer to sort columns by name or by using an alias.
*/

/*
EXAMPLE:
1) This query produces a single-column sort using the driver name
2) The default sort direction is ascending. To make the direction for an ascending sort
explicit, add ASC after the sorted column’s name

> To more fully control output order, specify a multiple-column sort by listing each 
column to use for sorting, separated by commas. 
3) The following query sorts in ascending order by name and by trav_date within the rows for 
each name

> Multiple-column ORDER BY clauses can perform mixed-order sorting where some columns
are sorted in ascending order and others in descending order. 
4) The following query sorts by name in descending order, then by trav_date in ascending 
order for each name

> The ORDER BY clauses in the queries shown thus far refer to the sorted columns by name.
5) You can also name the columns by using aliases
*/
1)
mysql> SELECT * FROM driver_log ORDER BY name;
2)
mysql> SELECT * FROM driver_log ORDER BY name DESC

3)
mysql> SELECT * FROM driver_log ORDER BY name, trav_date;

4)
mysql> SELECT * FROM driver_log ORDER BY name DESC, trav_date;

5)
mysql> SELECT name, trav_date, miles AS distance FROM driver_log
	-> ORDER BY distance;
