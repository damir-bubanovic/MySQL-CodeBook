/*

!!BASIC - MySQL-BASED PROGRAMS - EXECUTING STATEMENTS & RETRIEVING RESULTS!!

> You want a program to send an SQL statement to the MySQL server and retrieve 
its result

> Some statements return only a status code; others return a result set (a set of rows)


EXAMPLE:
> Table example

> id and name are declared as NOT NULL because they’re each required to have a value. 
> The other columns are implicitly permitted to be NULL (and that is also their default value)
 because we might not know the value to assign them for any given individual. 
	>> That is, NULL signifies “unknown.”
*/

CREATE TABLE profile
(
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
name VARCHAR(20) NOT NULL,
birth DATE,
color ENUM('blue','red','green','brown','black','white'),
foods SET('lutefisk','burrito','curry','eggroll','fadge','pizza'),
cats INT,
PRIMARY KEY (id)
);

/*
SQL STATEMENT CATEGORIES
> SQL statements can be grouped into two broad categories, depending on whether they
return a result set (a set of rows)
	• Statements that return no result set, such as INSERT, DELETE, or UPDATE. 
		>> As a general	rule, statements of this type generally change the database in some way. 
		>> There are some exceptions, such as USE db_name, which changes the default (current) 
		database for your session without making any changes to the database itself. 
	• Statements that return a result set, such as SELECT, SHOW, EXPLAIN, or DESCRIBE. 
		>> I refer to such statements generically as SELECT statements, but you should 
		understand that category to include any statement that returns rows. 

*/


/*
PDO has two connection-object methods to execute SQL statements: 
	+) exec() for statements that do not return a result set 
	+) query() for those that do

1) It returns a count to indicate how many rows were changed
	1.1. To determine the number of columns in the result set, call the statement handle 
	columnCount() method

2) use this object to call a row-fetching method in a loop, and count the rows if you need 
to know how many there are

> PDO::FETCH_NUM, fetch() returns an array with elements accessed using numeric
subscripts, beginning with 0. The array size indicates the number of result set columns
> PDO::FETCH_ASSOC, fetch() returns an associative array containing
values accessed by column name ($row["id"], $row["name"], $row["cats"])
> PDO::FETCH_OBJ, fetch() returns an object having members accessed
using the column names ($row->id, $row->name, $row->cats)

*/
1)
$count = $dbh->exec ("UPDATE profile SET cats = cats+1 WHERE name = 'Sybil'");
printf ("Number of rows updated: %d\n", $count);

2)
$sth = $dbh->query ("SELECT id, name, cats FROM profile");
$count = 0;
while($row = $sth->fetch (PDO::FETCH_NUM)) {
	printf ("id: %s, name: %s, cats: %s\n", $row[0], $row[1], $row[2]);
	$count++;
}
printf ("Number of rows returned: %d\n", $count);


/*
3) It’s also possible to use a statement handle as an iterator. 
	>> The handle uses the currentdefault fetch mode

4) The fetchAll() method fetches and returns the entire result set as an array of rows. 
	>> It permits an optional fetch-mode argument
*/
3)
$sth->setFetchMode (PDO::FETCH_NUM);
foreach($sth as $row) {
	printf ("id: %s, name: %s, cats: %s\n", $row[0], $row[1], $row[2]);
}

4)
$rows = $sth->fetchAll (PDO::FETCH_NUM);
foreach($rows as $row) {
	printf ("id: %s, name: %s, cats: %s\n", $row[0], $row[1], $row[2]);
}
