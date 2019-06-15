/*

!!GENERATING & USING SEQUENCES - RETRIEVING SEQUENCE VALUES!!

> After creating a row that includes a new sequence number, you want to know what that
number is

> Invoke the LAST_INSERT_ID() function. 
	>> If you’re writing a program, your MySQL API may provide a way to get the value 
	directly without issuing an SQL statement

*/

/*
> It’s common for applications to need to know the AUTO_INCREMENT value of a newly
created row
*/

/*
USING LAST_INSERT_ID() TO OBTAIN AUTO_INCREMENT VALUES
> invoke the LAST_INSERT_ID() function.
	>> It returns the most recent AUTO_INCREMENT value generated within your session,
	regardless of what other clients are doing. 
	1) npr. to insert a row into the insect table and retrieve its id value
	2) Or you can use the new value to retrieve the entire row, without even 
	knowing what it is
*/
1)
mysql> INSERT INTO insect (name,date,origin)
	-> VALUES('cricket','2014-09-11','basement');
mysql> SELECT LAST_INSERT_ID();

2)
mysql> INSERT INTO insect (name,date,origin)
	-> VALUES('moth','2014-09-14','windowsill');
mysql> SELECT * FROM insect WHERE id = LAST_INSERT_ID();


/*
USING API-SPECIFIC METHODS TO OBTAIN AUTO_INCREMENT VALUES
1) The PDO interface for MySQL has a lastInsertId() database-handle method that
returns the most recent AUTO_INCREMENT value
*/
1)
$dbh->exec ("INSERT INTO insect (name,date,origin)
			VALUES('moth','2014-09-14','windowsill')");
$seq = $dbh->lastInsertId ();