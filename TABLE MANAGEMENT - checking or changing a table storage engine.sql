/*

!!TABLE MANAGEMENT - CHECKING OR CHANGING A TABLE STORAGE ENGINE!!

> You want to check which storage engine a table uses so that you can determine what
engine capabilities are applicable. 
> Or you need to change a table’s storage engine because you realize that the 
capabilities of another engine are more suitable for the way you use the table

> To determine a table’s storage engine, you can use any of several statements. 
To change the table’s engine, use ALTER TABLE with an ENGINE clause


> ALERT <
	Be aware that converting a large table to a different storage engine might take a long
	time and be expensive in terms of CPU and I/O activity

*/

/*
EXAMPLE:
1) To determine the current engine for a table, check INFORMATION_SCHEMA or use the SHOW
TABLE STATUS or SHOW CREATE TABLE statement. 

2) For the mail table, obtain engine information as follows

3) To change the storage engine for a table, use ALTER TABLE with an ENGINE specifier. 
	> npr. to convert the mail table to use the MyISAM storage engine
*/
1) 
mysql> SELECT ENGINE FROM INFORMATION_SCHEMA.TABLES
	-> WHERE TABLE_SCHEMA = 'cookbook' AND TABLE_NAME = 'mail';
	
2)
mysql> SHOW TABLE STATUS LIKE 'mail'\G
2) 
mysql> SHOW CREATE TABLE mail\G

3)
ALTER TABLE mail ENGINE = MyISAM;