/*

!!BASIC - CLIENT PROGRAM - EXECUTING SQL STATEMENTS INTERACTIVELY!!

> You’ve started mysql. Now you want to send SQL statements to the 
MySQL server to be executed

> Just type them in, letting mysql know where each one ends. 
Or specify “one-liners” directly on the command line

*/

mysql> SELECT NOW();

/*
OR
*/

mysql> SELECT
	-> NOW()\g

	
/*
The output shows column values on separate lines
*/

mysql> SHOW FULL COLUMNS FROM limbs LIKE 'thing';

/*
To execute a statement directly from the command line
> npr. to count the rows in the limbs table
*/

% mysql -e "SELECT COUNT(*) FROM limbs" cookbook

/*
To execute multiple statements, separate them with semicolons
*/

% mysql -e "SELECT COUNT(*) FROM limbs;SELECT NOW()" cookbook