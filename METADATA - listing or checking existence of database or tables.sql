/*

!!METADATA - LISTING OR CHECKING EXISTENCE OF DATABASE OR TABLES!!

> You want to list the databases hosted by the MySQL server or the tables in a database.
> Or you want to check whether a particular database or table exists

> Use INFORMATION_SCHEMA to get this information. 
	>> The SCHEMATA table contains a row for each database, and the 
	TABLES table contains a row for each table in each database

*/

/*
EXAMPLE:
1) To retrieve the list of databases hosted by the server, use this statement

2) To sort the result, add an ORDER BY SCHEMA_NAME clause

3) To check whether a specific database exists, use a WHERE clause with a condition that
names the database. 
	>> If you get a row back, the database exists
	
4) To obtain the list of tables in a database, name the database in the WHERE clause of a
statement that selects from the TABLES table

5) To sort the result, add an ORDER BY TABLE_NAME clause

6) To obtain a list of tables in the default database, use this statement instead
*/
1)
SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA;

4)
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'cookbook';

6)
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = DATABASE();