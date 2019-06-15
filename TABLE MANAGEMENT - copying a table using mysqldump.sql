/*

!!TABLE MANAGEMENT - COPYING A TABLE USING MYSQLDUMP!!

> You want to copy a table or tables, either among the databases managed by a
MySQL server, or from one server to another

> Use the mysqldump program

*/

/*
EXAMPLE:
1) The mysqldump program makes a backup file that can be reloaded to re-create the
original table or tables

2) The output file mail.sql consists of a CREATE TABLE statement to create the mail table
and a set of INSERT statements to insert its rows. 
	>> You can reload the file to re-create the table should the original be lost
	
> This method also makes it easy to deal with any triggers the table has. 
> By default, mysqldump writes the triggers to the dump file, so reloading the file 
copies the triggers along with the table with no special handling.
> In addition to restoring tables, mysqldump can be used to make copies of them, by
reloading the output into a different database

*/
1)
% mysqldump cookbook mail > mail.sql

2)
% mysql cookbook < mail.sql


/*
COPYING TABLES WITHIN A SINGLE MySQL SERVER

EXAMPLE
1) Copy a single table to a different database
	> To dump multiple tables, name them all following the database name argument

2) Copy all tables in a database to a different database

> When you name no tables after the database name, mysqldump dumps them all. To
also include stored routines and events, add the --routines and --events options
to the mysqldump command

3) Copy a table, using a different name for the copy
	3.1) Dump the table:
	3.2) Reload the table into a different database that does not contain a table with 
	that name:
	3.3) Rename the table
		3.3.1) Or, to move the table into another database at the same time, 
		qualify the new name with the database name
		
4) To perform a table-copying operation without an intermediary file, use a pipe 
to connect the mysqldump and mysql commands
*/
1)
% mysqldump cookbook mail > mail.sql
% mysql other_db < mail.sql

2)
% mysqldump cookbook > cookbook.sql
% mysql other_db < cookbook.sql

3.1)
% mysqldump cookbook mail > mail.sql
3.2)
% mysql other_db < mail.sql
3.3) 
% mysql other_db
mysql> RENAME mail TO mail2;
	3.3.1) 
	% mysql other_db
	mysql> RENAME mail TO cookbook.mail2;

4) 
% mysqldump cookbook mail | mysql other_db
% mysqldump cookbook | mysql other_db


/*
COPYING TABLES BETWEEN MySQL SERVERS
> use mysqldump to copy tables among the databases managed
by a single MySQL server

EXAMPLE:
1) copy the mail table from the cook book database on the local host to the 
other_db database on the host otherhost.example.com.
2) Then copy mail.sql to other-host.example.com, and run the following command there
to load the table into that MySQL server’s other_db database

3) To accomplish this without an intermediary file, use a pipe to send the output of 
mysqldump directly over the network to the remote MySQL server. 
	> If you can connect to both servers from your local host, use this command
	
4) If you cannot connect directly to the remote server using mysql from your local host,
send the dump output into a pipe that uses ssh to invoke mysql remotely on otherhost.
example.com
*/
1)
% mysqldump cookbook mail > mail.sql
2) 
% mysql other_db < mail.sql

3) 
% mysqldump cookbook mail | mysql -h other-host.example.com other_db

4)
% mysqldump cookbook mail | ssh other-host.example.com mysql other_db
