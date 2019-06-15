/*

!!TABLE MANAGEMENT - GENERATING UNIQUE TABLE NAMES!!

> You need to create a table with a name guaranteed not to exist.

> If you create a TEMPORARY table, it doesn’t matter whether a permanent table with that
name exists. 
> Otherwise, try to generate a value that is unique to your client program and incorporate 
it into the table name

*/

/*
BEST OPTIONS:
1) Process ID (PID) values are a better source of unique values. PIDs are reused over time,
but never for two processes at the same time, so a given PID is guaranteed to be unique
among the set of currently executing processes

2) Connection identifiers are another source of unique values. The MySQL server reuses
these numbers over time, but no two simultaneous connections to the server have the
same ID. To get your connection ID, execute this statement and retrieve the result
*/
1)
$tbl_name = "tmp_tbl_" . posix_getpid ();

2)
SELECT CONNECTION_ID();