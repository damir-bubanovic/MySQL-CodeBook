/*

!!GENERATING SUMMARIES - USING COUNTS TO DETERMINE WHETHER VALUES ARE UNIQUE!!

> You want to know whether values in a table are unique

> Use HAVING in conjunction with COUNT()

*/

/*
> DISTINCT eliminates duplicates but doesn’t show which values actually were duplicated
in the original data. 
> You can use HAVING to find unique values in situations to which DISTINCT does not apply

EXAMPLE:
1) Show the days on which only one driver was active, and the days on which more than 
one driver was active

> This technique works for combinations of values, too
2) Find message sender/recipient pairs between whom only one message was sent, look for 
combinations that occur only once in the mail table
*/
1)
mysql> SELECT trav_date, COUNT(trav_date) FROM driver_log
	-> GROUP BY trav_date HAVING COUNT(trav_date) = 1;
	
mysql> SELECT trav_date, COUNT(trav_date) FROM driver_log
	-> GROUP BY trav_date HAVING COUNT(trav_date) > 1;
	
2)
mysql> SELECT srcuser, dstuser FROM mail
	-> GROUP BY srcuser, dstuser HAVING COUNT(*) = 1;