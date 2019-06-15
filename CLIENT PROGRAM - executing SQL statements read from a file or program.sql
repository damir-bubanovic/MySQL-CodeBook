/*

!!BASIC - CLIENT PROGRAM - EXECUTING SQL STATEMENTS READ FROM A FILE OR PROGRAM!!

> You want mysql to read statements stored in a file so that you need not enter 
them manually. Or you want mysql to read the output from another program

> To read a file, redirect mysql’s input, or use the source command. 
To read from a program, use a pipe

EXAMPLE:
> To create an SQL script for mysql to execute in batch mode, put your statements in a
text file. Then invoke mysql and redirect its input to read from that file
*/
% mysql cookbook < file_name;

/*
> Batch mode is convenient for executing a set of statements on repeated 
occasions without entering them manually each time

EXAMPLE:
> statements for creating and populating the limbs table
*/
DROP TABLE IF EXISTS limbs;

CREATE TABLE limbs
(
thing VARCHAR(20), # what the thing is
legs INT, # number of legs it has
arms INT # number of arms it has
);

INSERT INTO limbs (thing,legs,arms) VALUES('human',2,2);
INSERT INTO limbs (thing,legs,arms) VALUES('insect',6,0);
INSERT INTO limbs (thing,legs,arms) VALUES('squid',0,10);
INSERT INTO limbs (thing,legs,arms) VALUES('fish',0,0);
INSERT INTO limbs (thing,legs,arms) VALUES('centipede',100,0);
INSERT INTO limbs (thing,legs,arms) VALUES('table',4,0);
INSERT INTO limbs (thing,legs,arms) VALUES('armchair',4,2);
INSERT INTO limbs (thing,legs,arms) VALUES('phonograph',0,1);
INSERT INTO limbs (thing,legs,arms) VALUES('tripod',3,0);
INSERT INTO limbs (thing,legs,arms) VALUES('Peg Leg Pete',1,2);
INSERT INTO limbs (thing,legs,arms) VALUES('space alien',NULL,NULL);

/*
> To execute the statements in this SQL script file, change location into the tables 
directory of the recipes distribution and run this command
*/
% mysql cookbook < limbs.sql

/*
> To read a file of SQL statements from within a mysql session,
use a source filename command (or \. filename, which is synonymous)
*/
mysql> source limbs.sql;
mysql> \. limbs.sql;

/*
> copy a database over the network to another MySQL server
*/
% mysqldump cookbook > dump.sql
% mysql -h other-host.example.com cookbook < dump.sql

/*
> to connect the two programs directly with a pipe, 
avoiding the need for an intermediary file
*/
% mysqldump cookbook | mysql -h other-host.example.com cookbook

/*
> Program-generated SQL also can be useful for populating a table with test data without
writing the INSERT statements by hand. 
> Create a program that generates the statements, then send its output to mysql using a pipe
*/
% generate-test-data | mysql cookbook
