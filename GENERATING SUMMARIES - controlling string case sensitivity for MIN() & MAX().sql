/*

!!GENERATING SUMMARIES - CONTROLLING STRING CASE SENSITIVITY FOR MIN() & MAX()!!

> MIN() and MAX() select strings in case-sensitive fashion when you don’t want them to,
or vice versa

> Alter the comparison characteristics of the strings

*/

/*
EXAMPLE:
1) To compare case-insensitive strings in case-sensitive fashion, order the values using
a case-sensitive collation

2) To compare case-sensitive strings in case-insensitive fashion, order the values using
a case-insensitive collation

3) Another possibility is to compare values that have all been converted to the same
lettercase, which makes lettercase irrelevant. However, that also changes the retrieved
values

4) To compare binary strings using a case-insensitive ordering, convert
them to nonbinary strings and apply an appropriate collation
*/
1)
SELECT
MIN(str_col COLLATE latin1_general_cs) AS min,
MAX(str_col COLLATE latin1_general_cs) AS max
FROM tbl;

2)
SELECT
MIN(str_col COLLATE latin1_swedish_ci) AS min,
MAX(str_col COLLATE latin1_swedish_ci) AS max
FROM tbl;

3)
SELECT
MIN(UPPER(str_col)) AS min,
MAX(UPPER(str_col)) AS max
FROM tbl;

4
SELECT
MIN(CONVERT(str_col USING latin1) COLLATE latin1_swedish_ci) AS min,
MAX(CONVERT(str_col USING latin1) COLLATE latin1_swedish_ci) AS max
FROM tbl;