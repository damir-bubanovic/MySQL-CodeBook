/*

!!WORKING WITH STRINGS - SETTING THE CLIENT CONNECTION CHARACTER SET!!

> You’re executing SQL statements or producing query results that don’t use the default
character set

> Use SET NAMES or an equivalent method to set your connection to the proper character
set

*/

/*
> When you send information back and forth between your application and the server,
you may need to tell MySQL the appropriate character set.
> You have several ways to do this

EXAMPLE:
1) Issue a SET NAMES statement after you connect
1.2.) SET NAMES permits the connection collation to be specified as well
1.3) If your client program supports the --default-character-set option
	> Put the option in an option file so that it takes effect 
	each time you connect to the server
1.4) If you set the environment for your working environment using code page setting 
on Windows, MySQL client programs automatically detect which character set to use
*/
1) 
mysql> SET NAMES 'utf8';
1.2)
mysql> SET NAMES 'utf8' COLLATE 'utf8_general_ci';
1.3)
[mysql]
default-character-set=utf8
