/*

!!SELECTING DATA FROM TABLES - USING VIEWS TO SIMPLIFY TABLE ACCESS!!

> You want to refer to values calculated from expressions without writing 
the expressions each time you retrieve them

> Use a view defined such that its columns perform the desired calculations

*/


/*
> Instead of this

EXAMPLE:
*/
mysql> SELECT
	-> DATE_FORMAT(t,'%M %e, %Y') AS date_sent,
	-> CONCAT(srcuser,'@',srchost) AS sender,
	-> CONCAT(dstuser,'@',dsthost) AS recipient,
	-> size FROM mail;
	
/*
> Use this

> If you must issue such a statement often, it’s inconvenient to keep writing the 
expressions. To make the statement results easier to access, use a view, which is 
a virtual table that contains no data

EXAMPLE:
*/
mysql> CREATE VIEW mail_view AS
	-> SELECT
	-> DATE_FORMAT(t,'%M %e, %Y') AS date_sent,
	-> CONCAT(srcuser,'@',srchost) AS sender,
	-> CONCAT(dstuser,'@',dsthost) AS recipient,
	-> size FROM mail;
	
	
/*
> To access the view contents, refer to it like any other table. You can select some or 
all of its columns, add a WHERE clause to restrict which rows to retrieve, use ORDER BY 
to sort the rows, and so forth

EXAMPLE:
*/
mysql> SELECT date_sent, sender, size FROM mail_view
	-> WHERE size > 100000 ORDER BY size;