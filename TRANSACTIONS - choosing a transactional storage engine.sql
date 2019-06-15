/*

!!PERFORMING TRANSACTIONS - CHOOSING A TRANSACTIONAL STORAGE ENGINE!!

> You want to use transactions

> Check your MySQL server to determine which transactional storage engines it supports

*/

/*
> Currently, the transactional engines include InnoDB and NDB
	+) To see which your MySQL server supports, use this statement
	
> Transactional engines are those that have a TRANSACTIONS value of YES; those actually
usable have a SUPPORT value of YES or DEFAULT

EXAMPLE:
1) To create a table that uses a given engine, add an ENGINE = tbl_engine clause to your 
CREATE TABLE statement

2) Use ALTER TABLE to convert the tables to a transactional type
*/
+)
mysql> SELECT ENGINE FROM INFORMATION_SCHEMA.ENGINES
	-> WHERE SUPPORT IN ('YES','DEFAULT') AND TRANSACTIONS='YES';
	
1)
CREATE TABLE t (i INT) ENGINE = InnoDB;

2)
ALTER TABLE t ENGINE = InnoDB;