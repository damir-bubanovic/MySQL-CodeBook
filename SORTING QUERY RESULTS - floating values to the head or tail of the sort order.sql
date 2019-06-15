/*

!!SORTING QUERY RESULTS - FLOATING VALUES TO THE HEAD OR TAIL OF THE SORT ORDER!!

> You want a column to sort the way it normally does, except for a few values that should
appear at the beginning or end of the sort order. 
	>> npr. you want to sort a list in lexical order except for certain high-priority values 
	that should appear first no matter where they fall in the normal sort order
	
> Add an initial sort column to the ORDER BY clause that places those few values where you
want them. The remaining sort columns have their usual effect for the other values

*/

/*
> To sort a result set normally except that you want particular values first, create an 
additional sort column that is 0 for those values and 1 for everything else. 
	>> This enables you to float the values to the head of the sort order. 
	>> To put the values at the tail instead, use the additional column to map the values 
	to 1 and all other values to 0.
*/

/*
EXAMPLE:
1) Normally, sorting groups the NULL values at the beginning for an ascending sort

2) To put them at the end instead, without changing the order of other values, introduce
an extra ORDER BY column that maps NULL values to a higher value than non-NULL values
*/
1)
mysql> SELECT val FROM t ORDER BY val;

2)
mysql> SELECT val FROM t ORDER BY IF(val IS NULL,1,0), val;