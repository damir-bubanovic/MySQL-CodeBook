/*

!!SORTING QUERY RESULTS - DEFINING A CUSTOM SORT ORDER!!

> You want to sort values in a nonstandard order

> Use FIELD() to map column values to a sequence that places the values in the desired
order.

*/

/*
>To impose a specific order on all values in a column, use the FIELD() function
to map them to a list of numeric values and use the numbers for sorting

EXAMPLE:
1)The following FIELD() call compares value to str1, str2, str3, and str4, and returns
1, 2, 3, or 4, depending on which of them value is equal to

> If value is NULL or none of the values match, FIELD() returns 0

> You can use FIELD() to sort an arbitrary set of values into any order you please
2) To display driver_log rows for Henry, Suzi, and Ben, in that order
*/
1)
FIELD(value,str1,str2,str3,str4)

2)
mysql> SELECT * FROM driver_log
 -> ORDER BY FIELD(name,'Henry','Suzi','Ben');