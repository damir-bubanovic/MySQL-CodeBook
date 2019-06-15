/*

!!BASIC - MySQL-BASED PROGRAMS - CONNECTING, SELECTING A DATABASE & DISCONNECTING!!

> You need to establish a connection to the database server and shut down the 
connection when you’re done

> The connection routines require that you provide parameters specifying the 
host on which the MySQL server is running and the MySQL account to use. 
> You can also select a default database


> PHP actually has multiple extensions that enable the use of MySQL
	>> mysqli, the “MySQL improved” extension
	>> MySQL driver for the PDO (PHP Data Objects) interface


	
EXAMPLE:
> The following PHP script, connect.php, connects to the MySQL server, selects 
cook book as the default database, and disconnects
*/
<?php
# connect.php: connect to the MySQL server

try {
	$dsn = "mysql:host=localhost;dbname=cookbook";
	$dbh = new PDO ($dsn, "cbuser", "cbpass");
	print ("Connected\n");
} catch (PDOException $e) {
	die ("Cannot connect to server\n");
}

$dbh = NULL;
print ("Disconnected\n");
?>

/*
> $dsn is the data source name (DSN) that indicates how to connect to the database server.
> It has this general syntax
	> The driver value is the PDO driver type. For MySQL, this is mysql
*/
driver:name=value;name=value ...

/*
> To establish the connection, invoke the new PDO() class constructor, passing to it the
appropriate arguments. 
	>> The DSN is required. 
	>> The other arguments are optional, although usually it’s necessary to supply a 
	username and password. 
> If the connection attempt succeeds, new PDO() returns a database-handle object that is 
used to access other MySQL-related methods. 
> PHP scripts in this book conventionally use $dbh to signify a database handle.
> If the connection attempt fails, PDO raises an exception. 
	>> To handle this, put the connection attempt within a try block and use a catch block 
	that contains the errorhandling code, or just let the exception terminate your script
> To disconnect, set the database handle to NULL. 
	>> There is no explicit disconnect call
*/


/*
ADDITIONAL CONNECTION PARAMETERS
> To specify the path to a socket file for localhost connections on Unix, 
provide a unix_socket option in the DSN

> To specify the port number for non-localhost (TCP/IP) connections, 
provide a port option
*/
$dsn = "mysql:host=localhost;dbname=cookbook"
	. ";unix_socket=/var/tmp/mysql.sock";
	
$dsn = "mysql:host=127.0.0.1;database=cookbook;port=3307";

