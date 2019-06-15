/*

!!TABLE MANAGEMENT - SAVING A QUERY RESULT IN A TABLE!!

> You want to save the result from a SELECT statement to a table rather than display it

> If the table exists, retrieve rows into it using INSERT INTO … SELECT. 
> If the table does not exist, create it on the fly using CREATE TABLE … SELECT

*/

/*
> It’s possible to save the results of a SELECT statement in a table instead, which is
useful in several ways
	• You can easily create a complete or partial copy of a table. If you’re developing an
	algorithm that modifies a table, it’s safer to work with a copy of a table so that you
	need not worry about the consequences of mistakes. If the original table is large,
	creating a partial copy can speed the development process because queries run
	against it take less time.
	• For a data-loading operation based on information that might be malformed, load
	new rows into a temporary table, perform some preliminary checks, and correct
	the rows as necessary. When you’re satisfied that the new rows are okay, copy them
	from the temporary table to your main table.
	• Some applications maintain a large repository table and a smaller working table
	into which rows are inserted on a regular basis, copying the working table rows to
	the repository periodically and clearing the working table.
	• To perform summary operations on a large table more efficiently, avoid running
	expensive summary operations repeatedly on it. Instead, select summary information
	once into a second table and use that for further analysis.
*/


/*
EXAMPLE:
> The table names src_tbl and dst_tbl in the examples refer to the source table from which 
rows are selected and the destination table into which they are stored

1) If the destination table already exists, use INSERT … SELECT to copy the result set into
it.
	> dst_tbl contains an integer column i and a string column s, the following statement 
	copies rows from src_tbl into dst_tbl, assigning column val to i and column name to s

2) Copy all columns, you can shorten the statement to this form

3) To copy only certain rows, add a WHERE clause that selects those rows

4) SELECT statement can produce values from expressions
	> counts the number of times each name occurs in src_tbl and stores both the counts and 
	the names in dst_tbl
*/
1)
INSERT INTO dst_tbl (i, s) SELECT val, name FROM src_tbl;

2) 
INSERT INTO dst_tbl SELECT * FROM src_tbl;

3)
INSERT INTO dst_tbl SELECT * FROM src_tbl
WHERE val > 100 AND name LIKE 'A%';

4)
INSERT INTO dst_tbl (i, s) SELECT COUNT(*), name
FROM src_tbl GROUP BY name;


/*
EXAMPLE:
1) If the destination table does not exist, create it first with a CREATE TABLE statement, 
then copy rows into it with INSERT … SELECT
	> create dst_tbl and copy the entire contents of src_tbl into it
	
2) To copy only certain rows, add an appropriate WHERE clause. 
To create an empty table, use a WHERE clause that selects no rows

3) To copy only some of the columns, name the ones you want in the SELECT part of the
statement. 
	> npr. if src_tbl contains columns a, b, c, and d, copy just b and d

4) To create columns in an order different from that in which they appear in the source
table, name them in the desired order. 
	> If the source table contains columns a, b, and c that should appear in the destination 
	table in the order c, a, b,
*/
1)
CREATE TABLE dst_tbl SELECT * FROM src_tbl;

2)
CREATE TABLE dst_tbl SELECT * FROM src_tbl WHERE FALSE;

3) 
CREATE TABLE dst_tbl SELECT b, d FROM src_tbl;

4)
CREATE TABLE dst_tbl SELECT c, a, b FROM src_tbl;


/*
EXAMPLE:
> summary that lists each invoice named in the table and the total cost of its items, using
an alias for the expression
*/
CREATE TABLE dst_tbl
SELECT inv_no, SUM(unit_cost*quantity) AS total_cost
FROM src_tbl GROUP BY inv_no;


/*
> ALERT <
	MySQL has no idea whether a result set column should be indexed or what its default value is.

SOLUTION:
	• To make the destination table an exact copy of the source table, use the cloning technique
	• To include indexes in the destination table, specify them explicitly
		> 1) npr. if src_tbl has a PRIMARY KEY on the id column, and a multiple-column index on
		state and city, specify them for dst_tbl as well
	• Column attributes such as AUTO_INCREMENT and a column’s default value are not
	copied to the destination table. To preserve these attributes, create the table, then
	use ALTER TABLE to apply the appropriate modifications to the column definition.
		> 2)if src_tbl has an id column that is not only a PRIMARY KEY but also
		an AUTO_INCREMENT column, copy the table and modify the copy
EXAMPLE:
*/
1)
CREATE TABLE dst_tbl (PRIMARY KEY (id), INDEX(state,city))
SELECT * FROM src_tbl;

2)
CREATE TABLE dst_tbl (PRIMARY KEY (id)) SELECT * FROM src_tbl;
ALTER TABLE dst_tbl MODIFY id INT UNSIGNED NOT NULL AUTO_INCREMENT;

