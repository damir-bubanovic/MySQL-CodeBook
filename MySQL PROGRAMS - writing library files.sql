/*

!!BASIC - MySQL-BASED PROGRAMS - WRITING LIBRARY FILES!!

> You notice that you’re repeating code to perform common operations in 
multiple programs

> Write routines to perform those operations, put them in a library file, and arrange for
your programs to access the library. 
	>> This enables you to write the code only once. 
	>> You might need to set an environment variable so that your scripts can find the library

	
> This section describes how to put code for common operations in library files. 
> Encapsulation (or modularization) isn’t really a “recipe” so much as a programming technique.
	>> Its principal benefit is that you need not repeat code in each program you write, Instead,
	simply call a routine that’s in the library
	
> Library files have other benefits besides making it easier to write programs, such as
promoting portability

> Code encapsulation can also improve security. 
	>> If you make a private library file readable only to yourself, only scripts run by you 
	can execute routines in the file

	
> ALERT < 
	Be aware that if you install a library file to be readable by your web
	server, you don’t have much security if other developers use the same
	server. 
	
	Any of those developers can write a web script to read and display your 
	library file because, by default, the script runs with the permissions 
	of the web server and thus will have access to the library
	
	For PHP library files, I recommend that you place them somewhere outside the document
	tree, especially if (like Cookbook.php) they contain a username and password

*/

/*
CHOOOSING A LIBRARY-FILE INSTALLATION LOCATION
> If you install a library file in a directory that a language processor searches by default,
programs written in that language need do nothing special to access the library. 
> if you install a library file in a directory that the language processor does not search
by default, you must tell your scripts how to find it. 

> There are two common ways to do this:
	• Most languages provide a statement that can be used within a script to add directories
	to the language processor search path
	• You can set an environment or configuration variable that changes the language
	processor search path. Alternatively, if the language processor has a configuration file, 
	you might be able to set a parameter in the file that affects scripts globally for all users.
	
EXAMPLE:
> PHP installation directory. To determine the location, run this commmand
*/
% php --ini
/*
> Define the value of include_path in php.ini with a line like this
	include_path = "value"

> if you want PHP to look for include files in the current directory and C:\lib\mcb, 
set include_path like this:
	include_path = ".;C:\lib\mcb"
*/


/*
EXAMPLE:
> Cookbook.php file that implements a Cookbook class with a connect() method looks like this
*/
<?php

# Cookbook.php: library file with utility method for connecting to MySQL
# using the PDO module
class Cookbook {

	public static $host_name = "localhost";
	public static $db_name = "cookbook";
	public static $user_name = "cbuser";
	public static $password = "cbpass";
	
	# Establish a connection to the cookbook database, returning a database
	# handle. Raise an exception if the connection cannot be established.
	# In addition, cause exceptions to be raised for errors.
	public static function connect () {
		$dsn = "mysql:host=" . self::$host_name . ";dbname=" . self::$db_name;
		$dbh = new PDO ($dsn, self::$user_name, self::$password);
		$dbh->setAttribute (PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		return ($dbh);
	}
}

?>

/*
> test harness script, harness.php (for Cookbook.php )
*/
<?php

# harness.php: test harness for Cookbook.php library
require_once "Cookbook.php";
try {
	$dbh = Cookbook::connect ();
	print ("Connected\n");
} catch (PDOException $e) {
	print ("Cannot connect to server\n");
	print ("Error code: " . $e->getCode () . "\n");
	print ("Error message: " . $e->getMessage () . "\n");
	exit (1);
}

$dbh = NULL;
print ("Disconnected\n");

?>