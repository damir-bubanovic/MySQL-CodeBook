/*

!!SORTING QUERY RESULTS - SORTING DOTTED-QUAD IP VALUES IN NUMERIC ORDER!!

> You want to sort in numeric order strings that represent IP numbers

> Break apart the strings, and sort the pieces numerically. Or just use INET_ATON(). Or
consider storing the values as numbers instead.

*/

/*
> If a table contains IP numbers represented as strings in dotted-quad notation
(192.168.1.10), they sort lexically rather than numerically
> To produce a numeric ordering
instead, sort them as four-part values with each part sorted numerically

> To sort string-valued dotted-quad IP numbers, use a technique similar to that for sorting
hostnames, but with the following differences
	• Dotted quads always have four segments. There’s no need to add dots to the value
	before extracting substrings.
	• Dotted quads sort left to right. The order of the substrings used in the ORDER BY
	clause is opposite to that used for hostname sorting.
	• The segments of dotted-quad values are numbers. Add zero to each substring to
	force a numeric rather than lexical sort.
*/

/*
1) To sort the ip values numerically, extract each segment and add zero to convert it to a number

2) However, although that ORDER BY clause produces a correct result, it’s complicated. A
simpler solution uses the INET_ATON() function to convert network addresses in string
form to their underlying numeric values, then sorts those numbers

3) If you’re tempted to sort by simply adding zero to the ip value and using ORDER BY on
the result, consider the values that kind of string-to-number conversion actually produces
*/
1)
mysql> SELECT ip FROM hostip
	-> ORDER BY
	-> SUBSTRING_INDEX(ip,'.',1)+0,
	-> SUBSTRING_INDEX(SUBSTRING_INDEX(ip,'.',-3),'.',1)+0,
	-> SUBSTRING_INDEX(SUBSTRING_INDEX(ip,'.',-2),'.',1)+0,
	-> SUBSTRING_INDEX(ip,'.',-1)+0;
	
2)
mysql> SELECT ip FROM hostip ORDER BY INET_ATON(ip);

3)
mysql> SELECT ip, ip+0 FROM hostip;