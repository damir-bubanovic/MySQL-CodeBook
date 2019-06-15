/*

!!BASIC - CLIENT PROGRAM - CREATING A DABATASE & A SAMPLE TABLE!!

> You want to create a database and set up tables within it

> Use a CREATE DATABASE statement to create the database, a CREATE TABLE 
statement for each table, and INSERT statements to add rows to the tables


EXAMPLE:
> create the database
*/

mysql> CREATE DATABASE cookbook;

/*
1) Now that you have a database, you can create tables in it. 
First, select cookbook as the default database:

2) Then create a simple table:

3) And populate it with a few rows:

4) Verify that the rows were added to the limbs table by executing a SELECT statement
*/

mysql> USE cookbook;

mysql> CREATE TABLE limbs (thing VARCHAR(20), legs INT, arms INT);

mysql> INSERT INTO limbs (thing,legs,arms) VALUES('human',2,2);
mysql> INSERT INTO limbs (thing,legs,arms) VALUES('insect',6,0);
mysql> INSERT INTO limbs (thing,legs,arms) VALUES('squid',0,10);
mysql> INSERT INTO limbs (thing,legs,arms) VALUES('fish',0,0);
mysql> INSERT INTO limbs (thing,legs,arms) VALUES('centipede',100,0);
mysql> INSERT INTO limbs (thing,legs,arms) VALUES('table',4,0);
mysql> INSERT INTO limbs (thing,legs,arms) VALUES('armchair',4,2);
mysql> INSERT INTO limbs (thing,legs,arms) VALUES('phonograph',0,1);
mysql> INSERT INTO limbs (thing,legs,arms) VALUES('tripod',3,0);
mysql> INSERT INTO limbs (thing,legs,arms) VALUES('Peg Leg Pete',1,2);
mysql> INSERT INTO limbs (thing,legs,arms) VALUES('space alien',NULL,NULL);

mysql> SELECT * FROM limbs;