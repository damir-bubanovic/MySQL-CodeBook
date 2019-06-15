/*

!!USING MySQL-BASED WEB SESSION MANAGEMENT - USING MySQL-BASED STORAGE WITH THE PHP SESSION MANAGER!!

> You want to use session storage for PHP scripts

> PHP includes session management. By default, it uses temporary files for backing store,
but you can configure it to use MySQL instead

> Session variables are available as elements of the $_SESSION superglobal array.

*/

/*
THE PHP SESSION MANAGEMENT INTERFACE
	+) session_start ()
		> Opens a session and extracts any variables previously stored in it, making them
		available in the script’s global namespace. 
			>> npr. a session variable named x becomes available as $_SESSION["x"].
	+) session_write_close ()
		> Writes the session data and closes the session. 
			>> To be safe, call this function to save your changes.
	+) session_destroy ()
		> Removes the session and any data associated with it.
*/

/*
SPECIFYING A USER-DEFINED STORAGE MODULE
> To override the default storage method and store session data in MySQL, do this:
	1. Set up a table to hold session records, and write the routines that implement the
	storage module. 
	2. Tell PHP that you’re supplying a user-defined storage manager. Do this globally in
	php.ini (in which case you make the change once), or within individual scripts (in
	which case it’s necessary to declare your intent in each script).
	3. Register the storage module routines within each script that uses the module.
*/

/*
CREATING THE SESSION TABLE
1) Create a table named php_session defined as follows

> A small number of statements suffice to manage the contents of the php_session table
as we have defined it
2) To retrieve a session’s data, use a simple SELECT based on the session identifier

3) To write session data, a REPLACE updates an existing row, or creates a new one if no
such row exists
	>> Some storage manager implementations use a combination of INSERT and a fallback
	to UPDATE if the INSERT fails because a row with the given session ID already exists
	(or an UPDATE with a fallback to INSERT if the UPDATE fails because a row with the
	ID does not exist)
	
4) To destroy a session, delete the corresponding row

5) To perform garbage collection, remove old rows. The following statement deletes
rows that have a timestamp value more than sess_life seconds old
*/
1)
CREATE TABLE php_session
(
id CHAR(32) NOT NULL,
data LONGBLOB,
update_time TIMESTAMP NOT NULL,
PRIMARY KEY (id),
INDEX (update_time)
);

2)
SELECT data FROM php_session WHERE id = 'sess_id';

3)
REPLACE INTO php_session (id,data) VALUES('sess_id','sess_data');

4)
DELETE FROM php_session WHERE id = 'sess_id';

5)
DELETE FROM php_session
WHERE update_time < NOW() - INTERVAL sess_life SECOND;


/*
WRITING THE STORAGE MANAGEMENT ROUTINES
> user-defined session storage module is implemented as a set of handler routines. 
1) To register them with PHP’s session manager, call session_set_save_handler(), where 
each argument is a handler routine name specified as a string

> They need not necessarily be named mysql_sess_open(), mysql_sess_close(), and so forth
Write the routines according to the following specifications:
	+) mysql_sess_open ($save_path, $sess_name)
		> Performs any actions necessary to begin a session. $save_path is the name of the
		location where sessions should be stored. $sess_name indicates the name of the session 
		identifier (for example, PHPSESSID).

	+) mysql_sess_close ()
		> Closes the session, returning TRUE for success or FALSE for failure.
		
	+) mysql_sess_read ($sess_id)
		> Retrieves the data associated with the session identifier and returns it as a string. If
		there is no such session, the function returns an empty string. 
		
	+) mysql_sess_write ($sess_id, $sess_data)
		> Saves the data associated with the session identifier, returning TRUE for success or
		FALSE for failure. PHP itself takes care of serializing and unserializing the session
		contents, so the read and write functions need deal only with serialized strings.
		
	+) mysql_sess_destroy ($sess_id)
		> Destroys the session and any data associated with it, returning TRUE for success or
		FALSE for failure. For MySQL-based storage, destroying a session amounts to deleting
		the row from the php_session table associated with the session ID.

	+) mysql_sess_gc ($gc_maxlife)
		> Performs garbage collection to remove old sessions. This function is invoked on a
		probabilistic basis. 
		> npr. if the probability value is 1 (that is, 1%), PHP calls the collector approximately 
		once every hundred requests.

		
> The default storage management method is defined by the session.save_handler configuration variable. 
> You can change the method globally by modifying the php.ini initialization file, or within individual 
scripts
2) To change the storage method globally, edit php.ini

3) Modify this to indicate that sessions will be handled by a user-level mechanism

> If you use PHP as an Apache module, restart Apache after modifying php.ini so that
PHP notices the changes


> If you use PHP as an Apache module, restart Apache after modifying php.ini so that
PHP notices the changes
4) The outline of the file looks like this
*/
1)
session_set_save_handler (
	"mysql_sess_open", # function to open a session
	"mysql_sess_close", # function to close a session
	"mysql_sess_read", # function to read session data
	"mysql_sess_write", # function to write session data
	"mysql_sess_destroy", # function to destroy a session
	"mysql_sess_gc" # function to garbage-collect old sessions
);

2)
session.save_handler = files;

3)
session.save_handler = user;

4)
<?php
# Cookbook_Session.php: MySQL-based session storage module
require_once "Cookbook.php";
# Define the handler routines
function mysql_sess_open ($save_path, $sess_name) ...
function mysql_sess_close () ...
function mysql_sess_read ($sess_id) ...
function mysql_sess_write ($sess_id, $sess_data) ...
function mysql_sess_destroy ($sess_id) ...
function mysql_sess_gc ($gc_maxlife) ...
# Initialize the connection identifier, select user-defined
# session handling, and register the handler routines
$mysql_sess_dbh = NULL;
ini_set ("session.save_handler", "user");
session_set_save_handler (
"mysql_sess_open",
"mysql_sess_close",
"mysql_sess_read",
"mysql_sess_write",
"mysql_sess_destroy",
"mysql_sess_gc"
);
?>


/*
OPENING A SESSION
> PHP passes two arguments to this function: the save path and the session name

1) The function therefore does nothing but open a connection to MySQL
*/
1)
function mysql_sess_open ($save_path, $sess_name) {
	global $mysql_sess_dbh;
	
	# open connection to MySQL if its not already open
	if ($mysql_sess_dbh === NULL) {
		try {
			$mysql_sess_dbh = Cookbook::connect ();
		} catch (PDOException $e) {
			$mysql_sess_dbh = NULL;
			return (FALSE);
		}
	}
	return (TRUE);
}


/*
CLOSING A SESSION
1) The close handler checks whether a connection to MySQL is open and closes it if so
*/
1)
function mysql_sess_close () {
	global $mysql_sess_dbh;
	
	if ($mysql_sess_dbh !== NULL) # close connection if its open
	$mysql_sess_dbh = NULL;
	return (TRUE);
}


/*
READING SESSION DATA
1) The mysql_sess_read() function uses the session ID to look up the data for the corresponding 
session record and returns it
*/
1)
function mysql_sess_read ($sess_id) {
	global $mysql_sess_dbh;
	
	try	{
		$stmt = "SELECT data FROM php_session WHERE id = ?";
		$sth = $mysql_sess_dbh->prepare ($stmt);
		$sth->execute (array ($sess_id));
		list ($data) = $sth->fetch (PDO::FETCH_NUM);
		if (isset ($data))
		return ($data);
	} catch (PDOException $e) { 
		/* do nothing */ 
	}
	return ("");
}


/*
WRITING SESSION DATA
1) mysql_sess_write() creates a new record if there is none for the session yet, or replaces 
the existing record if there is one
*/
1)
function mysql_sess_write ($sess_id, $sess_data) {
	global $mysql_sess_dbh;
	
	try	{
		$stmt = "REPLACE php_session (id, data) VALUES(?,?)";
		$sth = $mysql_sess_dbh->prepare ($stmt);
		$sth->execute (array ($sess_id, $sess_data));
		return (TRUE);
	} catch (PDOException $e) {
		return (FALSE);
	}
}


/*
DESTROYING A SESSION
1) When a session is no longer needed, mysql_sess_destroy() removes the corresponding record
*/
1)
function mysql_sess_destroy ($sess_id) {
	global $mysql_sess_dbh;
	
	try {
		$stmt = "DELETE FROM php_session WHERE id = ?";
		$sth = $mysql_sess_dbh->prepare ($stmt);
		$sth->execute (array ($sess_id));
		return (TRUE);
	} catch (PDOException $e) {
		return (FALSE);
	}
}


/*
PERFORMING GARBAGE COLLECTION
> The TIMESTAMP column update_time in each session record indicates when the session was last updated. 
> mysql_sess_gc() uses this value to implement garbage collection. 
> The argument $sess_maxlife specifies how old sessions can be (in seconds)
1) Older sessions are considered expired and candidates for removal
*/
1)
function mysql_sess_gc ($sess_maxlife) {
	global $mysql_sess_dbh;
	
	try	{
		$stmt = "DELETE FROM php_session
		WHERE update_time < NOW() - INTERVAL ? SECOND";
		$sth = $mysql_sess_dbh->prepare ($stmt);
		$sth->execute (array ($sess_maxlife));
	} catch (PDOException $e) { 
		/* do nothing */ 
	}
	return (TRUE); # ignore errors
}


/*
USING THE STORAGE MODULE
> Install the Cookbook_Session.php file in a public library directory accessible to your scripts. 
> On my system, I put PHP library files in /usr/local/lib/mcb and modify php.ini so that the 
include_path variable names that directory

1) To try the storage module, install the following example script, sess_track.php
*/
1)
<?php
# sess_track.php: session request counting/timestamping demonstration
require_once "Cookbook_Session.php";
require_once "Cookbook_Webutils.php"; # for make_ordered_list()
$title = "PHP Session Tracker";

# Open session and extract session values
session_start ();
$count = $_SESSION["count"];
$timestamp = $_SESSION["timestamp"];

# If the session is new, initialize the variables
if (!isset ($count))
$count = 0;
if (!isset ($timestamp))
$timestamp = array ();

# Increment counter, add current timestamp to timestamp array
++$count;
$timestamp[] = date ("Y-m-d H:i:s T");

if ($count < 10) # save modified values into session {
	$_SESSION["count"] = $count;
	$_SESSION["timestamp"] = $timestamp;
	session_write_close (); # save session changes
} else # destroy session after 10 invocations {
	session_destroy ();
}

# Produce the output page
?>
<html>
<head><title><?php print ($title); ?></title></head>
<body>

<?php
print ("<p>This session has been active for $count requests.</p>");
print ("<p>The requests occurred at these times:</p>");
print make_ordered_list ($timestamp);
print ("<p>Reload page to send next request.</p>");
?>

</body>
</html>
