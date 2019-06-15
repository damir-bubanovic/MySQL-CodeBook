/*

!!SELECTING DATA FROM TABLES - SPECIFYING WHICH COLUMNS & ROWS TO SELECT!!

> You want to display specific columns and rows from a table

> To indicate which columns to display, name them in the output column list. 
> To indicate which rows to display, use a WHERE clause that specifies conditions 
that rows must satisfy


EXAMPLE:
> display all columns from a table
*/
mysql> SELECT * FROM mail;

/*
EXAMPLE:
> This query omits the recipient columns and displays the sender before the date
and size
*/
mysql> SELECT srcuser, srchost, t, size FROM mail;


/*
EXAMPLE:
> To be more precise, provide a WHERE clause that specifies one or more conditions
that rows must satisfy
> The following statements select columns from rows in the mail table containing 
srchost values that are exactly equal to the string 'venus' or that begin with the 
letter 's'
> LIKE operator in query performs a pattern match, where % acts as a
wildcard that matches any string
*/
mysql> SELECT t, srcuser, srchost FROM mail WHERE srchost = 'venus';

mysql> SELECT t, srcuser, srchost FROM mail WHERE srchost LIKE 's%';

/*
EXAMPLE:
> A WHERE clause can test multiple conditions and different conditions can test different
columns. The following statement finds messages sent by barb to tricia
*/
mysql> SELECT * FROM mail WHERE srcuser = 'barb' AND dstuser = 'tricia';

/*
EXAMPLE:
> This query combines the srcuser and srchost columns using CONCAT() to produce composite 
values in email address format:
*/
mysql> SELECT t, CONCAT(srcuser,'@',srchost), size FROM mail;
