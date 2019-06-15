/*

!!SELECTING DATA FROM TABLES - BASICS!!

> examples in this chapter use a table named mail that contains rows that 
track mail message traffic between users on a set of hosts

EXAMPLE TABLE:
*/
CREATE TABLE mail
(
	t DATETIME, # when message was sent
	srcuser VARCHAR(8), # sender (source user and host)
	srchost VARCHAR(20),
	dstuser VARCHAR(8), # recipient (destination user and host)
	dsthost VARCHAR(20),
	size BIGINT, # message size in bytes
	INDEX (t)
);