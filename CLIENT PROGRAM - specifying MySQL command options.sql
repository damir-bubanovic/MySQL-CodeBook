/*

!!BASIC - CLIENT PROGRAM - SPECIFYING MySQL COMMAND OPTIONS!!

> When you invoke the mysql program without command options, it 
exits immediately with an “access denied” message

> You must specify connection parameters. Do this on the command line, 
in an option file, or using a mix of the two


EXAMPLE:
> If you invoke mysql with no command options, the result may be an “access denied”
error. To avoid that, connect to the MySQL server as shown
*/

% mysql -h localhost -u cbuser -p
Enter password: cbpass

/*
> Each option is the single-dash “short” form: -h and -u to specify the hostname and
username, and -p to be prompted for the password. 
> There are also corresponding double-dash “long” forms: --host, --user, and --password
*/

% mysql --host=localhost --user=cbuser --password
Enter password: cbpass

/*
To see all options that mysql supports, use this command
*/

% mysql --help

/*
> npr. to generate a dump file named cookbook.sql that contains a backup of the 
tables in the cookbook database, execute mysqldump like this
*/

% mysqldump -h localhost -u cbuser -p cookbook > cookbook.sql
Enter password: cbpass

/*
> npr. to stop the server, invoke mysqladmin as follows
*/

% mysqladmin -h localhost -u root -p shutdown
Enter password: ← enter MySQL root account password here

/*
> To find out which options the mysql program will read from option files, 
use this command
*/

% mysql --print-defaults

/*
> npr. mysqldump looks in both the [client] and [mysqldump] groups for options. 
To check which option-file settings are in those groups, use this command
*/

% my_print_defaults client mysqldump
