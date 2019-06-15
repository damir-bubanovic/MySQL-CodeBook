/*

!!DATE & TIME - SETTING THE CLIENT TIME ZONE!!

> You have a client application that connects from a time zone different from the server.
	>> Consequently, when it stores TIMESTAMP values, they don’t have the correct UTC values

> The client should set the time_zone system variable after connecting to the server

*/

/*
> Time zone settings have an important effect on TIMESTAMP values
• When the MySQL server starts, it examines its operating environment to determine
its time zone. (To use a different value, start the server with the --default-timezone
option.)
	• For each client that connects, the server interprets TIMESTAMP values with respect
	to the time zone associated with the client session. 
		> When a client inserts a TIMESTAMP value, the server converts it from the client 
		time zone to UTC and stores the	UTC value. 
		> When the client retrieves a TIMESTAMP value, the server performs the reverse 
		operation to convert the UTC value back to the client time zone.
	• The default session time zone for each client when it connects is the server time
	zone. 
		> If all clients are in the same time zone as the server, nothing special need be
		done for proper TIMESTAMP time zone conversion to occur. 
		> But if a client is in a timezone different from the server and it inserts 
		TIMESTAMP values without making the	proper time zone correction, the UTC values 
		won’t be correct.
*/

/*
EXAMPLE:
1) Suppose that the server and client C1 are in the same time zone, and client C1 issues
these statements

2) To deal with this problem so that TIMESTAMP conversions use the proper time zone, a
client should set its time zone explicitly by setting the session value of the time_zone
system variable.
	2.1) Suppose that the server has a global time zone of six hours ahead of
	UTC. Each client initially is assigned that same value as its session time zone
	2.2) When client C2 connects, it sees the same TIMESTAMP value as client C1
	2.3) But that value is incorrect if client C2 is only four hours ahead of UTC. 
	C2 should set its time zone after connecting so that retrieved TIMESTAMP values are 
	properly adjusted for its own session
*/
1)
mysql> CREATE TABLE t (ts TIMESTAMP);
mysql> INSERT INTO t (ts) VALUES('2014-06-01 12:30:00');
mysql> SELECT ts FROM t;

2.1)
mysql> SELECT @@global.time_zone, @@session.time_zone;
2.2.)
mysql> SELECT ts FROM t;
2.3)
mysql> SET SESSION time_zone = '+04:00';
mysql> SELECT @@global.time_zone, @@session.time_zone;

mysql> SELECT ts FROM t;
