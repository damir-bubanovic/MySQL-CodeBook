/*

!!BASIC - MySQL-BASED PROGRAMS - HANDLING SPECIAL CHARACTERS IN IDENTIFIERS!!

> You need to construct SQL statements that refer to identifiers containing special characters.

> Quote each identifier so it can be inserted safely into statement strings

*/

/*
> To make an identifier safe for insertion into an SQL statement, 
quote it by enclosing it within backticks
*/
CREATE TABLE "some table" (i INT);

/*
> Within a program, you can use an identifier-quoting routine if your API provides one,
or write one yourself if not
*/
function quote_identifier ($ident) {
	return ('`' . str_replace('`', '``', $ident) . '`');
}

/*
> In contexts where identifiers are used as data values, handle them as such. If you select
information from the INFORMATION_SCHEMA metadata database, it’s common to indicate
which rows to return by specifying database object names in the WHERE clause
*/
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'cookbook' AND TABLE_NAME = 'profile';