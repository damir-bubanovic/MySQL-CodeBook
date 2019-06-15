/*

!!HANDLING DUPLICATES - COUNTING & IDENTIFYING DUPLICATES!!

> You want to determine whether a table contains duplicates, and to what extent they
occur. Or you want to see the rows that contain the duplicated values

> Use a counting summary that displays duplicated values. To see the rows in which the
duplicated values occur, join the summary to the original table to display the matching
rows

*/

/*
> To determine whether duplicates occur in a table, use a counting summary
	>> Summary techniques can be applied to identifying and counting duplicates by grouping 
	rows with GROUP BY and counting the rows in each group using COUNT()
	
> Suppose that you define “duplicate” using the last_name and first_name columns

> The following statements characterize the table and assess the existence and extent of 
duplicate values
EXAMPLE:
1) The total number of rows in the table
2) The number of distinct names
3) The number of rows containing duplicated names
4) The fraction of the rows that contain unique or nonunique names

5) To see the duplicated names in the catalog_list table, use a summary statement that displays 
the nonunique values along with the counts
*/
1)
mysql> SELECT COUNT(*) AS rows FROM catalog_list;
2)
mysql> SELECT COUNT(DISTINCT last_name, first_name) AS 'distinct names'
	-> FROM catalog_list;
3)
mysql> SELECT COUNT(*) - COUNT(DISTINCT last_name, first_name)
	-> AS 'duplicate names'
	-> FROM catalog_list;
4)
mysql> SELECT COUNT(DISTINCT last_name, first_name) / COUNT(*)
	-> AS 'unique',
	-> 1 - (COUNT(DISTINCT last_name, first_name) / COUNT(*))
	-> AS 'nonunique'
	-> FROM catalog_list;
	
5)
1)
mysql> SELECT COUNT(*), last_name, first_name
	-> FROM catalog_list
	-> GROUP BY last_name, first_name
	-> HAVING COUNT(*) > 1;

	
/*
> The statement includes a HAVING clause that restricts the output to include only those
names that occur more than once. In general, to identify sets of values that are duplicated,
do the following:
	1. Determine which columns contain the values that may be duplicated.
	2. List those columns in the column selection list, along with COUNT(*).
	3. List the columns in the GROUP BY clause as well.
	4. Add a HAVING clause that eliminates unique values by requiring group counts to be
	greater than one.
	
EXAMPLE:
1) Queries constructed that way have the following form

2) It’s easy to generate duplicate-finding queries like that within a program, given database
and table names and a nonempty set of column names. (PHP)
	> insert into PHP
*/
1)
SELECT COUNT(*), column_list
FROM tbl_name
GROUP BY column_list
HAVING COUNT(*) > 1

2)
SELECT COUNT(*),last_name,first_name
FROM cookbook.catalog_list
GROUP BY last_name,first_name
HAVING COUNT(*) > 1

/*
> If duplicates are determined using only a subset of a table’s columns, a summary in itself 
cannot display the entire content of the rows that contain the duplicate values
+) To see the original rows containing the duplicate names, join the summary information to the 
table from which it’s generated.
*/
+)
mysql> CREATE TABLE tmp
	-> SELECT COUNT(*) AS count, last_name, first_name FROM catalog_list
	-> GROUP BY last_name, first_name HAVING count > 1;
mysql> SELECT catalog_list.*
	-> FROM tmp INNER JOIN catalog_list USING (last_name, first_name)
	-> ORDER BY last_name, first_name;
