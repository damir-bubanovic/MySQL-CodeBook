/*

!!SORTING QUERY RESULTS - CONTROLLING CASE SENSITIVITY OF STRING SORTS!!

> String-sorting operations are case sensitive when you don’t want them to be, or vice
versa

> Alter the comparison characteristics of the sorted values

*/

/*
> string-comparison properties depend on whether the strings
are binary or nonbinary
	• Binary strings are sequences of bytes. 
		>> They are compared byte by byte using numeric byte values. 
		>> Character set and lettercase have no meaning for comparisons
	• Nonbinary strings are sequences of characters. 
		>> They have a character set and collation and are compared character 
		by character using the order defined by the collation
*/

/*
> To alter the sorting properties of a string column, alter its comparison properties
> Examples in this section use a table that has case-insensitive and case-sensitive
nonbinary columns, and a binary column
*/
CREATE TABLE str_val
(
ci_str CHAR(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci,
cs_str CHAR(3) CHARACTER SET latin1 COLLATE latin1_general_cs,
bin_str BINARY(3)
);

/*
> Each column contains the same values, but the natural sort orders for the column data
types produce three different results

EXAMPLE:
1) The case-insensitive collation sorts a and A together, placing them before b and B.

2) The case-sensitive collation puts A and a before B and b, and sorts uppercase before
lowercase

3) The binary strings sort numerically. Assuming that uppercase letters have numeric
values less than those of lowercase letters, a binary sort results in the following
ordering:
*/
1)
mysql> SELECT ci_str FROM str_val ORDER BY ci_str;

2)
mysql> SELECT cs_str FROM str_val ORDER BY cs_str;

3)
mysql> SELECT bin_str FROM str_val ORDER BY bin_str;


/*
> To alter the sorting properties of each column, use the techniques described earlier
for controlling string comparisons

EXAMPLE:
1) To sort case-insensitive strings in case-sensitive fashion, order the sorted values
using a case-sensitive collation

2) To sort case-sensitive strings in case-insensitive fashion, order the sorted values
using a case-insensitive collation

3) Alternatively, sort using values that have been converted to the same lettercase,
which makes lettercase irrelevant

> To sort binary strings using a case-insensitive ordering, convert them to
nonbinary strings and apply an appropriate collation
4) Perform a case-insensitive sort
*/
1)
mysql> SELECT ci_str FROM str_val
	-> ORDER BY ci_str COLLATE latin1_general_cs;

2)
mysql> SELECT cs_str FROM str_val
	-> ORDER BY cs_str COLLATE latin1_swedish_ci;

3)
mysql> SELECT cs_str FROM str_val
	-> ORDER BY UPPER(cs_str);

4)
mysql> SELECT bin_str FROM str_val
-> ORDER BY CONVERT(bin_str USING latin1) COLLATE latin1_swedish_ci;
