/*

!!TABLE MANAGEMENT - CREATING TEMPORARY TABLES!!

> You need a table only for a short time, after which you want it to disappear automatically

> Create a table using the TEMPORARY keyword, and let MySQL take care of removing it

OPTIONS:
1) execute a DROP TABLE statement explicitly to remove a table when you’re done with it. 
2) use CREATE TEMPORARY TABLE
	> creates a transient table that disappears when your session with the server ends
	> Temporary tables are session-specific, so multiple clients can each create a 
	temporary table having the same name without interfering with each other

*/

/*
EXAMPLE:
1) Create the table from explicit column definitions

2) Create the table from an existing table

3) Create the table on the fly from a result set:
*/
1)
CREATE TEMPORARY TABLE tbl_name (...column definitions...);

2)
CREATE TEMPORARY TABLE new_table LIKE original_table;

3)
CREATE TEMPORARY TABLE tbl_name SELECT ... ;


/*
LOOK OUT:
	• To reuse a temporary table within a given session, you must still drop it explicitly
	before re-creating it. 
		> Attempting to create a second temporary table with the same name results in an error.
	• If you modify a temporary table that “hides” a permanent table with the same name, be sure 
	to test for errors resulting from dropped connections if you use a programming
	interface that has reconnect capability enabled. 
		> If a client program automatically reconnects after detecting a dropped connection, 
		modifications affect the permanent table after the reconnect, not the temporary table.
	• Some APIs support persistent connections or connection pools. 
		> These prevent	temporary tables from being dropped as you expect when your script ends 
		because	the connection remains open for reuse by other scripts. 
		> Your script has no control over when the connection closes. 
			>> This means it can be prudent to execute the following statement prior to creating 
			a temporary table, just in case it’s still in existence	from a previous execution
			of the script
				DROP TEMPORARY TABLE IF EXISTS tbl_name
*/
