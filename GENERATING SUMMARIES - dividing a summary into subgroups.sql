/*

!!GENERATING SUMMARIES - DIVIDING A SUMMARY INTO SUBGROUPS!!

> You want a summary for each subgroup of a set of rows, not an overall summary value

> Use a GROUP BY clause to arrange rows into groups

*/

/*
EXAMPLE:
> Calculate summary values over all rows in the result set
1) Number of records in the mail table, and thus the total number of mail messages sent

> To arrange a set of rows into subgroups and summarize each group, use aggregate functions
in conjunction with a GROUP BY clause
2) Determine the number of messages per sender, group the rows by sender name, count how many 
times each name occurs, and display the names with the counts

> You want a quick characterization of the mail table, showing for each sender listed in it 
the total amount of traffic sent (in bytes) and the average number of bytes per message
3) You still use the srcuser column to group the rows, but summarize the size values

4) Find out how many messages each sender sent from each host, use two grouping columns. 
This produces a result with nested groups (groups within groups)

> The preceding examples in this section used COUNT(), SUM(), and AVG() for per-group
summaries. You can use MIN() or MAX(), too
5) Groups mail table rows by message sender, displaying for each the size of the largest 
message sent and the date of the most recent message

> You can group by multiple columns and display a maximum for each combination of
values in those columns
6) Finds the size of the largest message sent between each pair of sender and recipient 
values listed in the mail table


7) The general solution to the problem of displaying contents of rows associated with
minimum or maximum group values involves a join
*/
1)
mysql> SELECT COUNT(*) FROM mail;

2)
mysql> SELECT srcuser, COUNT(*) FROM mail GROUP BY srcuser;

3)
mysql> SELECT srcuser,
	-> SUM(size) AS 'total bytes',
	-> AVG(size) AS 'bytes per message'
	-> FROM mail GROUP BY srcuser;
	
4)
mysql> SELECT srcuser, srchost, COUNT(srcuser) FROM mail
	-> GROUP BY srcuser, srchost;
	
5) 
mysql> SELECT srcuser, MAX(size), MAX(t) FROM mail GROUP BY srcuser;

6)
mysql> SELECT srcuser, dstuser, MAX(size) FROM mail GROUP BY srcuser, dstuser;


7)
mysql> CREATE TEMPORARY TABLE t
	-> SELECT name, MAX(miles) AS miles FROM driver_log GROUP BY name;
mysql> SELECT d.name, d.trav_date, d.miles AS 'longest trip'
	-> FROM driver_log AS d INNER JOIN t USING (name, miles) ORDER BY name;
	