/*

!!METADATA - ACCESSING TABLE COLUMN DEFINITIONS!!

> You want to find out what columns a table has and how they are defined

> There are several ways to do this. You can obtain column definitions:
	+) from INFORMATION_SCHEMA
	+) from SHOW statements
	+) or from mysqldump

*/

/*
> Information about the structure of tables enables you to answer questions such as “What
columns does a table contain and what are their types?” or “What are the legal values
for an ENUM or SET column?”

> Here are some applications for that kind of information
Displaying column lists
	A simple use of table information is presenting a list of the table’s columns. This is
	common in web-based or GUI applications that enable users to construct statements
	interactively by selecting a table column from a list and entering a value
	against which to compare column values.
	
Interactive record editing
	Knowledge of a table’s structure can be very useful for interactive record-editing
	applications. Suppose that an application retrieves a record from the database, displays
	a form containing the record’s content so a user can edit it, and then updates
	the record in the database after the user modifies the form and submits it. 
	You can	use table structure information for validating column values. If a column is an
	ENUM, you can find out the valid enumeration values and check the value submitted
	by the user against them to determine whether it’s legal. If the column is an integer
	type, check the submitted value to make sure that it consists entirely of digits, possibly
	preceded by a + or − sign character. If the column contains dates, look for a
	legal date format.
	
Mapping column definitions onto web page elements
	Some data types such as ENUM and SET correspond naturally to elements of web
	forms:
		• An ENUM has a fixed set of values from which you choose a single value. This is
		analogous to a group of radio buttons, a pop-up menu, or a single-pick scrolling
		list.
		• A SET column is similar, except that you can select multiple values; this corresponds
		to a group of checkboxes or a multiple-pick scrolling list.

*/

/*
> MySQL provides several ways to find out about a table’s structure:
	• Retrieve the information from INFORMATION_SCHEMA. The COLUMNS table contains
	the column definitions.
	• Use a SHOW COLUMNS statement.
	• Use the SHOW CREATE TABLE statement or the mysqldump command-line program
	to obtain a CREATE TABLE statement that displays the table’s structure.
*/

/*
Using INFORMATION_SCHEMA to get table structure
1) use a statement of the following form

2) To obtain information about all columns, omit the COLUMN_NAME condition from the
WHERE clause

3) To retrieve only certain types of information, replace SELECT * with the columns of
interest
*/
1)
mysql> SELECT * FROM INFORMATION_SCHEMA.COLUMNS
	-> WHERE TABLE_SCHEMA = 'cookbook' AND TABLE_NAME = 'item'
	-> AND COLUMN_NAME = 'colors'\G

3)
mysql> SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE
-> FROM INFORMATION_SCHEMA.COLUMNS
-> WHERE TABLE_SCHEMA = 'cookbook' AND TABLE_NAME = 'item';


/*
> Here are some COLUMNS table columns likely to be of most use:
	• COLUMN_NAME: The column name.
	• ORDINAL_POSITION: The position of the column within the table definition.
	• COLUMN_DEFAULT: The column’s default value.
	• IS_NULLABLE: YES or NO to indicate whether the column can contain NULL values.
	• DATA_TYPE, COLUMN_TYPE: Data type information. DATA_TYPE is the data-type keyword
	and COLUMN_TYPE contains additional information such as type attributes
	• CHARACTER_SET_NAME, COLLATION_NAME: The character set and collation for string
	columns. They are NULL for nonstring columns.
	• COLUMN_KEY: Information about whether the column is indexed.
*/


/*
1) INFORMATION_SCHEMA content is easy to use from within programs
*/
1)
function get_column_names ($dbh, $db_name, $tbl_name) {
	$stmt = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?
	ORDER BY ORDINAL_POSITION";
	
	$sth = $dbh->prepare ($stmt);
	$sth->execute (array ($db_name, $tbl_name));
	return ($sth->fetchAll (PDO::FETCH_COLUMN, 0));
}


/*
Using SHOW COLUMNS to get table structure
1) The SHOW COLUMNS statement produces one row of output for each column in the table,
with each row providing various pieces of information about the corresponding column
*/
1)
mysql> SHOW COLUMNS FROM item LIKE 'colors'\G


/*
> The need to escape % and _ characters to match a LIKE pattern literally also applies to
other SHOW statements that permit a name pattern in the LIKE clause, such as SHOW TABLES
and SHOW DATABASES

1) Within a program, you can use your API language’s pattern-matching capabilities to
escape SQL pattern characters before putting the column name into a SHOW statement
*/
1)
$name = preg_replace ('/([%_])/', '\\\\$1', $name);


/*
Using CREATE TABLE to get table structure
1) Another way to obtain table structure information from MySQL is from the CREATE
TABLE statement that defines the table
*/
1)
mysql> SHOW CREATE TABLE item\G
