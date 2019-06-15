/*

!!SELECTING DATA FROM TABLES - NAMING QUERY RESULTS COLUMNS!!

> The column names in a query result are unsuitable, ugly, or difficult to work with

> Use aliases to choose your own column names


> When you retrieve a result set, MySQL gives every output column a name
> By default, MySQL assigns the column names specified in the CREATE TABLE or ALTER TABLE 
statement to output columns, but if these defaults are not suitable, you can use column 
aliases to specify your own names

*/


/*
If an output column comes directly from a table, MySQL uses the table column name
for the output column name. 

EXAMPLE:
The following statement selects four table columns, the names of which become the 
corresponding output column names
*/
mysql> SELECT t, srcuser, srchost, size FROM mail;


/*
> If you generate a column by evaluating an expression, the expression itself is the column
name. This can produce long and unwieldy names in result sets, as illustrated by the
following statement that uses one expression to reformat the dates in the t column, and
another to combine srcuser and srchost into email address format

EXAMPLE:
*/
mysql> SELECT
	-> DATE_FORMAT(t,'%M %e, %Y'), CONCAT(srcuser,'@',srchost), size
	-> FROM mail;
	

/*
> To choose your own output column name, use an AS name clause to specify a column
alias (the keyword AS is optional). 

EXAMPLE:
The following statement retrieves the same result as the previous one, but renames the 
first column to date_sent and the second to sender
*/
mysql> SELECT
	-> DATE_FORMAT(t,'%M %e, %Y') AS date_sent,
	-> CONCAT(srcuser,'@',srchost) AS sender,
	-> size FROM mail;
	
	
/*
ERROR:
> If MySQL complains about a single-word alias, the word probably is reserved. Quoting
the alias should make it legal
*/
mysql> SELECT 1 AS INTEGER;
You have an error in your SQL syntax near 'INTEGER'
mysql> SELECT 1 AS 'INTEGER';


/*
ERROR:
> You cannot refer to column aliases in a WHERE clause. 
Thus, the following statement is illegal
*/
mysql> SELECT t, srcuser, dstuser, size/1024 AS kilobytes
-> FROM mail WHERE kilobytes > 500;
ERROR 1054 (42S22): Unknown column 'kilobytes' in 'where clause'
/*
> The error occurs because an alias names an output column, whereas a WHERE clause
operates on input columns to determine which rows to select for output. To make the
statement legal, replace the alias in the WHERE clause with the same column or expression
that the alias represents
*/
mysql> SELECT t, srcuser, dstuser, size/1024 AS kilobytes
	-> FROM mail WHERE size/1024 > 500;


