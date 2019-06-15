/*

!!TABLE MANAGEMENT - CLONING A TABLE!!

> You want to create a table that has exactly the same structure as an existing table

> Use CREATE TABLE … LIKE to clone the table structure. 
> To also copy some or all of the rows from the original table to the new one, 
use INSERT INTO … SELECT

*/

/*
EXAMPLE:
1) To create a new table that is just like an existing table
	> ALERT <
		CREATE TABLE … LIKE does not copy foreign key definitions, and it doesn’t
		copy any DATA DIRECTORY or INDEX DIRECTORY table options that the table 
		might use

2) If you also want the contents to be the same as the original table,
copy the rows using an INSERT INTO … SELECT statement

3) To copy only part of the table, add an appropriate WHERE clause that identifies 
which rows to copy
	>> npr. these statements create a copy of the mail table named mail2, populated 
	only with the rows for mail sent by barb
*/
1)
CREATE TABLE new_table LIKE original_table;

2) 
INSERT INTO new_table SELECT * FROM original_table;

3) 
CREATE TABLE mail2 LIKE mail;
INSERT INTO mail2 SELECT * FROM mail WHERE srcuser = 'barb';