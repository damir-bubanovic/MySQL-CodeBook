/*

!!PERFORMING TRANSACTIONS - PERFORMING TRANSACTIONS USING SQL!!

> A set of statements must succeed or fail as a unit—that is, you require a transaction

> Manipulate MySQL’s auto-commit mode to enable multiple-statement transactions, and
then commit or roll back the statements depending on whether they succeed or fail

*/

/*
> MySQL normally operates in auto-commit mode, which commits the effect of each
statement as soon as it executes. (In effect, each statement is its own transaction.) 
> To perform a transaction, you must disable auto-commit mode, execute the statements that
make up the transaction, and then either commit or roll back your changes. 

> In MySQL, you can do this two ways:

	1.1) Execute a START TRANSACTION (or BEGIN) statement to suspend auto-commit mode,
	then execute the statements that make up the transaction. 
	> If the statements succeed, record their effect in the database and terminate the 
	transaction by executing a COMMIT statement
	1.2) If an error occurs, don’t use COMMIT. Instead, cancel the transaction by executing a
	ROLLBACK statement. In the following example, t remains empty after the transaction
	because the effects of the INSERT statements are rolled back
	
	2.1) Another way to group statements is to turn off auto-commit mode explicitly by setting 
	the autocommit session variable to 0. After that, each statement you execute becomes part 
	of the current transaction. To end the transaction and begin the next one, execute a 
	COMMIT or ROLLBACK statement
	
	3) To turn auto-commit mode back on, use this statement
*/
1.1)
mysql> CREATE TABLE t (i INT) ENGINE = InnoDB;
mysql> START TRANSACTION;
mysql> INSERT INTO t (i) VALUES(1);
mysql> INSERT INTO t (i) VALUES(2);
mysql> COMMIT;
mysql> SELECT * FROM t;
1.2)
mysql> CREATE TABLE t (i INT) ENGINE = InnoDB;
mysql> START TRANSACTION;
mysql> INSERT INTO t (i) VALUES(1);
mysql> INSERT INTO t (x) VALUES(2);
ERROR 1054 (42S22): Unknown column 'x' in 'field list'
mysql> ROLLBACK;
mysql> SELECT * FROM t;
Empty set (0.00 sec)

2.1)
mysql> CREATE TABLE t (i INT) ENGINE = InnoDB;
mysql> SET autocommit = 0;
mysql> INSERT INTO t (i) VALUES(1);
mysql> INSERT INTO t (i) VALUES(2);
mysql> COMMIT;
mysql> SELECT * FROM t;

3)
mysql> SET autocommit = 1;
