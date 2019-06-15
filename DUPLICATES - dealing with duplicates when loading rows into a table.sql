/*

!!HANDLING DUPLICATES - DEALING WITH DUPLICATES WHEN LOADING ROWS INTO A TABLE!!

> You’ve created a table with a unique index to prevent duplicate values in the indexed
column or columns. But this results in an error if you attempt to insert a duplicate row,
and you want to avoid having to deal with such errors

> One approach is to just ignore the error. Another is to use an INSERT IGNORE, REPLACE,
or INSERT … ON DUPLICATE KEY UPDATE statement, each of which modifies MySQL’s
duplicate-handling behavior. 
	>> For bulk-loading operations, LOAD DATA has modifiers that enable you to specify 
	how to handle duplicates

*/

/*
EXAMPLE:
1) Suppose that the person table has the following structure, with a unique index on the 
last_name and first_name columns

2) An attempt to insert a row with duplicate values in the indexed columns results in an
error
*/
1)
CREATE TABLE person
(
last_name CHAR(20) NOT NULL,
first_name CHAR(20) NOT NULL,
address CHAR(40),
PRIMARY KEY (last_name, first_name)
);

2)
mysql> INSERT INTO person (last_name, first_name)
	-> VALUES('X1','Y1');
	
Query OK, 1 row affected (0.00 sec)
mysql> INSERT INTO person (last_name, first_name)
	-> VALUES('X1','Y1');
	
ERROR 1062 (23000): Duplicate entry 'X1-Y1' for key 'PRIMARY'


/*
> MySQL provides three single-query solutions to the problem of handling duplicate rows

EXAMPLE:
	1) To keep the original row when a duplicate occurs, use INSERT IGNORE rather than
	INSERT. If the row duplicates no existing row, MySQL inserts it as usual. If the row
	is a duplicate, the IGNORE keyword tells MySQL to discard it silently without generating
	an error
		> From within a program, you can obtain this value by checking the rows-affected 
		function provided by your API
		
	2) To replace the original row with the new one when a duplicate occurs, use RE
	PLACE rather than INSERT. If the row is new, it’s inserted just as with INSERT. If it’s
	a duplicate, the new row replaces the old one
		> The rows-affected value in the second case is 2 because the original row is deleted
		and the new row is inserted in its place
		
	3) To modify columns of an existing row when a duplicate occurs, use INSERT … ON
	DUPLICATE KEY UPDATE. If the row is new, it’s inserted. If it’s a duplicate, the ON
	DUPLICATE KEY UPDATE clause indicates how to modify the existing row in the table.
	In other words, this statement can insert or update a row as necessary. The rowsaffected
	count indicates what happened: 1 for an insert, 2 for an update
		> INSERT … ON DUPLICATE KEY UPDATE is appropriate when you must insert a record if it 
		doesn’t exist, but just update some of its columns if the new record is a duplicate in 
		the indexed columns
		3.1) Suppose that you record votes for candidates in polls, using the following table
		3.2) INSERT … ON DUPLICATE KEY UPDATE works better here
*/
1)
mysql> INSERT IGNORE INTO person (last_name, first_name)
	-> VALUES('X2','Y2');
	
Query OK, 1 row affected (0.00 sec)
mysql> INSERT IGNORE INTO person (last_name, first_name)
	-> VALUES('X2','Y2');
	
Query OK, 0 rows affected (0.00 sec)

2)
mysql> REPLACE INTO person (last_name, first_name)
	-> VALUES('X3','Y3');
	
Query OK, 1 row affected (0.00 sec)
mysql> REPLACE INTO person (last_name, first_name)
	-> VALUES('X3','Y3');

Query OK, 2 rows affected (0.00 sec)

3.1)
CREATE TABLE poll_vote
(
poll_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
candidate_id INT UNSIGNED,
vote_count INT UNSIGNED,
PRIMARY KEY (poll_id, candidate_id)
);
3.2)
mysql> SELECT * FROM poll_vote;
Empty set (0.00 sec)
mysql> INSERT INTO poll_vote (poll_id,candidate_id,vote_count) VALUES(14,3,1)
	-> ON DUPLICATE KEY UPDATE vote_count = vote_count + 1;
Query OK, 1 row affected (0.00 sec)
mysql> SELECT * FROM poll_vote;

1 row in set (0.00 sec)
mysql> INSERT INTO poll_vote (poll_id,candidate_id,vote_count) VALUES(14,3,1)
-> ON DUPLICATE KEY UPDATE vote_count = vote_count + 1;
Query OK, 2 rows affected (0.00 sec)
mysql> SELECT * FROM poll_vote;
