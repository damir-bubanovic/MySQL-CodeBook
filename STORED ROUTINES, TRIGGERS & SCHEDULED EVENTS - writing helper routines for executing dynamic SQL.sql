/*

!!STORED ROUTINES, TRIGGERS & SCHEDULED EVENTS - WRITING HELPER ROUTINES FOR EXECUTING DYNAMIC SQL!!

> Prepared SQL statements enable you to construct and execute SQL statements on the
fly, but the supporting mechanism can be tedious to use

> Write a helper procedure that handles the drudgery

*/

/*
> Using a prepared SQL statement involves three steps: preparation, execution, and deallocation

EXAMPLE:
1) If the @tbl_name and @val variables hold a table name and a value to insert into the table, 
you can create the table and insert the value like this

2) To ease the burden of going through those steps for each dynamically created statement,
use a helper routine that, given a statement string, prepares, executes, and deallocates
it:

3) The exec_stmt() routine enables the same statements to be executed much more
simply
*/
1)
SET @stmt = CONCAT('CREATE TABLE ',@tbl_name,' (i INT)');
PREPARE stmt FROM @stmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
SET @stmt = CONCAT('INSERT INTO ',@tbl_name,' (i) VALUES(',@val,')');
PREPARE stmt FROM @stmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

2)
CREATE PROCEDURE exec_stmt(stmt_str TEXT)
BEGIN
	SET @_stmt_str = stmt_str;
	PREPARE stmt FROM @_stmt_str;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END;

3)
CALL exec_stmt(CONCAT('CREATE TABLE ',@tbl_name,' (i INT)'));
CALL exec_stmt(CONCAT('INSERT INTO ',@tbl_name,' (i) VALUES(',@val,')'));


/*
ANTI-SQL
> construct statement strings that incorporate values
	+) The QUOTE() function is available for quoting data values
	+) There is no corresponding function for identifiers, but it’s easy to write one that
	doubles internal backticks and adds a backtick at the beginning and end
	
1) Revising the preceding example to ensure the safety of data values and identifiers, we
have
*/
+)
CREATE FUNCTION quote_identifier(id TEXT)
RETURNS TEXT DETERMINISTIC
RETURN CONCAT('`',REPLACE(id,'`','``'),'`');

1)
SET @tbl_name = quote_identifier(@tbl_name);
SET @val = QUOTE(@val);
CALL exec_stmt(CONCAT('CREATE TABLE ',@tbl_name,' (i INT)'));
CALL exec_stmt(CONCAT('INSERT INTO ',@tbl_name,' (i) VALUES(',@val,')'));
