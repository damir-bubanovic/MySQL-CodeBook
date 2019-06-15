/*

!!HANDLING DUPLICATES - ELIMINATING DUPLICATES FROM A TABLE!!

> You want to remove duplicate rows from a table, leaving only unique rows

> Select the unique rows from the table into a second table, then use it to replace the
original one. Or use DELETE … LIMIT n to remove all but one instance of a specific set
of duplicate rows

*/

/*
> If you forget to include the index when you create a table, you may discover later 
that it contains duplicates and that it’s necessary to apply some sort of duplicate-removal 
technique

To eliminate duplicates, you have a few options:
	• Select the table’s unique rows into another table, then use that table to replace the
	original one. This works when “duplicate” means “the entire row is the same as
	another.”
	• To remove duplicates for a specific set of duplicate rows, use DELETE … LIMIT n to
	remove all but one row.
	
When you consider which to choose under various circumstances, the applicability of a given 
method to a specific problem is often determined by several factors
	• Does the method require the table to have a unique index?
	• If the columns in which duplicate values occur may contain NULL, will the method
	remove duplicate NULL values?
	• Does the method prevent duplicates from occurring in the future?
*/

/*
REMOVING DUPLICATES USING TABLE REPLACEMENT
> select its unique rows into a new table that has the same structure, and then replace the 
original table with the new one

EXAMPLE:
1) Create a new table that has the same structure as the original one. CREATE TABLE …
LIKE is useful for this

2) Use INSERT INTO … SELECT DISTINCT to select the unique rows from the original
table into the new one
3) Select rows from the tmp table to verify that the new table contains no duplicates

4) After creating the new tmp table that contains unique rows, use it to replace the
original catalog_list table

> This method requires rows to be completely identical to be considered duplicates. Thus,
it treats as distinct those rows for Wallace Baxter that have slightly different street
values

1) If duplicates are defined only with respect to a subset of the columns in the table, create
a new table that has a unique index for those columns, select rows into it using INSERT IGNORE, 
and replace the original table with the new one
*/
1)
mysql> CREATE TABLE tmp LIKE catalog_list;

2)
mysql> INSERT INTO tmp SELECT DISTINCT * FROM catalog_list;
3)
mysql> SELECT * FROM tmp ORDER BY last_name, first_name;

4)
mysql> DROP TABLE catalog_list;
mysql> RENAME TABLE tmp TO catalog_list;

1)
mysql> CREATE TABLE tmp LIKE catalog_list;
mysql> ALTER TABLE tmp ADD PRIMARY KEY (last_name, first_name);
mysql> INSERT IGNORE INTO tmp SELECT * FROM catalog_list;

mysql> SELECT * FROM tmp ORDER BY last_name, first_name;

mysql> DROP TABLE catalog_list;
mysql> RENAME TABLE tmp TO catalog_list;


/*
REMOVING DUPLICATES OF A PARTICULAR ROW
> You can use LIMIT to restrict the effect of a DELETE statement to a subset of the rows that
it otherwise would delete

EXAMPLE:
1) Original unindexed catalog_list table contains duplicates

2) To remove the extra instances of each name

> This technique works in the absence of a unique index, and it eliminates duplicate NULL
values. 
> It’s handy for removing duplicates only for a specific set of rows within a table
*/
1)
mysql> SELECT COUNT(*), last_name, first_name
	-> FROM catalog_list
	-> GROUP BY last_name, first_name
	-> HAVING COUNT(*) > 1;

2)
mysql> DELETE FROM catalog_list WHERE last_name = 'Baxter'
	-> AND first_name = 'Wallace' LIMIT 2;
mysql> DELETE FROM catalog_list WHERE last_name = 'Pinter'
	-> AND first_name = 'Marlene' LIMIT 1;
mysql> SELECT * FROM catalog_list;


/*
> In general, using DELETE … LIMIT n is likely to be slower than removing duplicates by
using a second table or by adding a unique index
*/
