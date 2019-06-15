/*

!!METADATA - DETERMINING THE NUMBER OF ROWS AFFECTED BY A STATEMENT!!

> You want to know how many rows an SQL statement changed

> Sometimes the row count is the return value of the function that executes the statement.
> Other times the count is returned by a separate function that you call after executing
the statement

*/

/*
> For statements that affect rows (UPDATE, DELETE, INSERT, REPLACE), each API provides
a way to determine the number of rows involved. 
	>> For MySQL, the default meaning of “affected by” is “changed by,” not “matched by.”
*/

/*
EXAMPLE:
1) In PDO, the database handle exec() method returns the rows-affected count

2) If you use prepare() plus execute() instead, the rows-affected count is available from
the statement handle rowCount() method

3) Pass PDO::MYSQL_ATTR_FOUND_ROWS => 1 in this array to request rows-matched counts
*/
1)
$count = $dbh->exec ($stmt);
printf ("Number of rows updated: %d\n", $count);

2)
$sth = $dbh->prepare ($stmt);
$sth->execute ();
printf ("Number of rows updated: %d\n", $sth->rowCount ());

3)
$dsn = "mysql:host=localhost;dbname=cookbook";
$dbh = new PDO ($dsn, "cbuser", "cbpass",
				array (PDO::MYSQL_ATTR_FOUND_ROWS => 1));