/*

!!GENERATING & USING SEQUENCES - CHOOSING THE DEFINITION FOR A SEQUENCE COLUMN!!

> You want to know more about how to define a sequence column

> Use the guidelines given here

*/

/*
> You should follow certain principles when creating AUTO_INCREMENT columns:

	• INT is the column’s base data type. You need not necessarily use INT, but the column
	should be one of the integer types: TINYINT, SMALLINT, MEDIUMINT, INT, or BIGINT.

	• UNSIGNED prohibits negative column values. 
		> This is not a required attribute for AUTO_INCREMENT columns, but sequences 
		consist only of positive integers (normally	beginning at 1), so there is no 
		reason to permit negative values.
		
	• AUTO_INCREMENT columns cannot contain NULL values, so id is declared as NOT NULL.
	
	• AUTO_INCREMENT columns must be indexed. 
		> Normally, because a sequence column exists to provide unique identifiers, 
		you use a PRIMARY KEY or UNIQUE index to enforce uniqueness.
*/