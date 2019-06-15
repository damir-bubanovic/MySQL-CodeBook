/*

!!BASIC - MySQL-BASED PROGRAMS - TECHNIQUES FOR OBTAINING CONNECTION PARAMETERS!!

> You need to obtain connection parameters for a script so that it can connect to a 
MySQL server


> Any program that connects to MySQL specifies connection parameters such as the
username, password, and hostname

TECHNIQUES
1) Hardwire the parameters into the program
	The parameters can be given either in the main source file or in a library file used
	by the program. 
		>> This technique is convenient because users need not enter the values themselves, 
		but it’s also inflexible. 
		>> To change parameters, you must modify your program.
2) Ask for the parameters interactively
	In a command-line environment, you can ask the user a series of questions. In a
	web or GUI environment, you might do this by presenting a form or dialog. 
		>> Either way, this becomes tedious for people who use the application frequently, 
		due to the need to enter the parameters each time.
3) Get the parameters from the command line
	You can use this method either for commands run interactively or from within a
	script. 
		>> Like the method of obtaining parameters interactively, you must supply parameters
		for each command invocation. (A factor that mitigates this burden is that many shells 
		enable you to easily recall commands from your history list for reexecution.)
4) Get the parameters from the execution environment
	The most common way to do this is to set the appropriate environment variables
	in one of your shell’s startup files (such as .profile for sh, bash, ksh; or .login for csh
	or tcsh). 
		>> Programs that you run during your login session then can get parameter values 
		by examining their environment.
5) Get the parameters from a separate file
	With this method, store information such as the username and password in a file
	that programs can read before connecting to the MySQL server. 
		>> Reading parameters from a file that’s separate from your program gives you the 
		benefit of not having to enter them each time you use the program, without hardwiring 
		the values into it.
		>> Also, storing the values in a file enables you to centralize parameters for use by
		multiple programs, and for security purposes you can set the file access mode to
		keep other users from reading the file.
6) Use a combination of methods
	It’s often useful to combine methods, to give users the flexibility of providing parameters
	different ways. 
		>> npr. MySQL clients such as mysql and mysqladmin look for option files in several locations 
		and read any that are present. They then check the command-line arguments for further parameters. 
		This enables users to specify connection parameters in an option file or on the command line.

		These methods of obtaining connection parameters do involve security issues:
			• Any method that stores connection parameters in a file may compromise your
			system’s security unless the file is protected against access by unauthorized users.
			This is true whether parameters are stored in a source file, an option file, or a script
			that invokes a command and specifies the parameters on the command line. (Web
			scripts that can be read only by the web server don’t qualify as secure if other users
			have administrative access to the server.)
			• Parameters specified on the command line or in environment variables are not
			particularly secure. While a program is executing, its command-line arguments and
			environment may be visible to other users who run process status commands such
			as ps -e. In particular, storing the password in an environment variable perhaps is
			best limited to those situations in which you’re the only user on the machine or you
			trust all other users.

*/


/*
> PDO MySQL driver does not necessarily support using MySQL option files 
(it does not if you use mysqlnd as the underlying library)
> To work around that limitation, use a function that reads an option file, 
such as the read_mysql_option_file() function

EXAMPLE:
*/
/*NISAM SIGURAN DA LI JE OVA FUNKCIJA OK*/
function read_mysql_option_file ($filename, $group_list = "client") {

	if(is_string($group_list)) {
		# convert string to array
		$group_list = array ($group_list);
	}
	
	if(!is_array($group_list)) {
		# hmm ... garbage argument?
		return (FALSE);
	}
	
	$opt = array (); # option name/value array
	if(!@($fp = fopen($filename, "r"))) { # if file does not exist,
		return ($opt); # return an empty list
	}
	
	$in_named_group = 0; # set nonzero while processing a named group
	while($s = fgets($fp, 1024)) {
	
		$s = trim ($s);
		if(preg_match("/^[#;]/", $s)) {
			# skip comments
			continue;
		}
		
		if(preg_match("/^\[([^]]+)]/", $s, $arg)) { # option group line?
			# check whether we are in one of the desired groups
			$in_named_group = 0;
			
			foreach($group_list as $group_name) {
				if ($arg[1] == $group_name) {
					$in_named_group = 1; # we are in a desired group
					break;
				}
			}
			continue;
		}
		
		if(!$in_named_group) { # we are not in a desired
			continue; # group, skip the line
		}
		
		if(preg_match ("/^([^ \t=]+)[ \t]*=[ \t]*(.*)/", $s, $arg)) {
			$opt[$arg[1]] = $arg[2]; # name=value
		} else if(preg_match ("/^([^ \t]+)/", $s, $arg)) {
			$opt[$arg[1]] = ""; # name only
		} # else line is malformed
	}
	return ($opt);
}


/*
EXAMPLE:
> Here are two examples showing how to use read_mysql_option_file(). 
	1) The first reads a user’s option file to get the [client] group parameters 
	and uses them to connect to the server. 
	2) The second reads the system-wide option file, /etc/my.cnf, and prints the
	server startup parameters that are found there
*/
$opt = read_mysql_option_file ("/home/paul/.my.cnf");
$dsn = "mysql:dbname=cookbook";

if(isset($opt["host"])) {
	$dsn .= ";host=" . $opt["host"];
}
$user = $opt["user"];
$password = $opt["password"];

try {
	$dbh = new PDO($dsn, $user, $password);
	print ("Connected\n");
	$dbh = NULL;
	print ("Disconnected\n");
} catch(PDOException $e) {
	print ("Cannot connect to server\n");
}

$opt = read_mysql_option_file("/etc/my.cnf", array ("mysqld", "server"));
foreach($opt as $name => $value) {
	print ("$name => $value\n");
}

