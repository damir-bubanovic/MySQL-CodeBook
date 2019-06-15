/*

!!SORTING QUERY RESULTS - SORTING BY VARIABLE-LENGTH SUBSTRINGS!!

> You want to sort using parts of a column that do not occur at a given position within
the column

> Determine how to identify the parts you need so that you can extract them.

*/

/*
> If substrings to be used for sorting vary in length, you need a reliable means of 
extracting just the part you want

EXAMPLE:
1) use SUBSTRING() to skip the first three characters. Of the remainder beginning
with the fourth character (the first digit), take everything but the rightmost two
columns
*/
1)
mysql> SELECT id, LEFT(SUBSTRING(id,4),CHAR_LENGTH(SUBSTRING(id,4)-2))
	-> FROM housewares3;