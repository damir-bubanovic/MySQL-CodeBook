/*

!!BASIC - MySQL-BASED PROGRAMS - CHECKING FOR ERRORS!!

> Something went wrong with your program, and you don’t know what

> Add some errorchecking code so your programs can help you figure out 
what went wrong


> When an error occurs, MySQL provides three values:
	• A MySQL-specific error number
	• A MySQL-specific descriptive text error message
	• A five-character SQLSTATE error code defined according to the ANSI and ODBC
	standards
*/


/*
> The new PDO() constructor raises an exception if it fails, but other PDO methods by
default indicate success or failure by their return value

> To cause all PDO methods to raise exceptions for errors, use the database handle 
resulting from a successful connection attempt to set the error-handling mode. 
	>> This enables uniform handling of all PDO errors without checking the result of 
	every call. 
	

EXAMPLE:
> how to set the error mode if the connection attempt succeeds and how to handle 
exceptions if it fails
*/
<?php
try {
	$dsn = "mysql:host=localhost;dbname=cookbook";
	$dbh = new PDO ($dsn, "baduser", "badpass");
	$dbh->setAttribute (PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	print ("Connected\n");
} catch (PDOException $e) {
	print ("Cannot connect to server\n");
	print ("Error code: " . $e->getCode () . "\n");
	print ("Error message: " . $e->getMessage () . "\n");
}
?>

/*
> Database and statement handles also provide information when an error occurs

EXAMPLE:
> how to get information from the exception object and the database handle
*/
try {
	$dbh->query ("SELECT"); # malformed query
} catch (PDOException $e) {
	print ("Cannot execute query\n");
	print ("Error information using exception object:\n");
	print ("SQLSTATE value: " . $e->getCode () . "\n");
	print ("Error message: " . $e->getMessage () . "\n");
	print ("Error information using database handle:\n");
	print ("Error code: " . $dbh->errorCode () . "\n");
	$errorInfo = $dbh->errorInfo ();
	print ("SQLSTATE value: " . $errorInfo[0] . "\n");
	print ("Error number: " . $errorInfo[1] . "\n");
	print ("Error message: " . $errorInfo[2] . "\n");
}
