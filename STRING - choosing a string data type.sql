/*

!!WORKING WITH STRINGS - CHOOSING A STRING DATA TYPE!!

> You want to store string data but aren’t sure which is the most appropriate data type

> Choose the data type according to the characteristics of the information to be stored
and how you need to use it. Consider questions such as these:
	• Are the strings binary or nonbinary?
	• Does case sensitivity matter?
	• What is the maximum string length?
	• Do you want to store fixed- or variable-length values?
	• Do you need to retain trailing spaces?
	• Is there a fixed set of permitted values?

	
Binary data type 	Nonbinary data type 	Maximum length
BINARY 				CHAR 					255
VARBINARY 			VARCHAR 				65,535
TINYBLOB 			TINYTEXT 				255
BLOB 				TEXT 					65,535
MEDIUMBLOB 			MEDIUMTEXT 				16,777,215
LONGBLOB 			LONGTEXT 				4,294,967,295

> npr. values stored in a BINARY(10) or CHAR(10) column always take 
10 bytes or 10 characters

*/


/*
> if you store character (nonbinary) strings that might end with spaces, and want to 
preserve them, use VARCHAR or one of the TEXT data types
> if you store a string that contains trailing spaces into a CHAR column,
they’re removed when you retrieve the value

> When you declare a nonbinary string column, use the CHARACTER SET and COLLATE attributes 
if you require a particular character set and collation


EXAMPLE:
> if you need to store utf8 (Unicode) and sjis (Japanese) strings, you might define a table 
with two columns like this
*/
CREATE TABLE mytbl
(
utf8str VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_danish_ci,
sjisstr VARCHAR(100) CHARACTER SET sjis COLLATE sjis_japanese_ci
);

/*
> The CHARACTER SET and COLLATE clauses are each optional in a column definition
	• If you specify CHARACTER SET and omit COLLATE, the default collation for the character
	set is used.
	• If you specify COLLATE and omit CHARACTER SET, the character set implied by the
	collation name (the first part of the name) is used. 
		>> This means that the CHARACTER SET attributes could have been omitted from the 
		preceding CREATE TABLE statement.
	• If you omit both CHARACTER SET and COLLATE, the column is assigned the table
	default character set and collation. 
		>> A table definition can include those attributes following the closing parenthesis 
		at the end of the CREATE TABLE statement. 
			>>> If present, they apply to columns that have no explicit character set or collation 
			of their own. 
			>>> If omitted, the table defaults are taken from the database defaults. 
		>> You can specify the database defaults when you create the database with the CREATE
		DATABASE statement. 
			>>> The server defaults apply to the database if they are omitted.
*/