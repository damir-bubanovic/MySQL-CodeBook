/*

!!SECURITY - FINDING & REMOVING ANONYMOUS ACCOUNTS!!

> You want to ensure that your MySQL server can be used only by accounts associated
with specific usernames

> Identify and remove anonymous accounts

*/

/*
> An “anonymous” account is one that has an empty user part in the account name, such
as ''@'localhost'
> Security implications
	• Such accounts often are given no password, enabling their use with no authentication
	at all.
	• You cannot associate database activity with specific users (for example, by checking
	the server query log or examining SHOW PROCESSLIST output), making it more difficult
	to tell who is doing what.
	
> Use the following instructions to identify and remove them
EXAMPLE:
1) The User column is empty in the mysql.user rows for anonymous accounts, so
you can identify them like this

2) The SELECT output shows two anonymous accounts. Remove each using a DROP
USER statement with the corresponding account name
*/
1)
mysql> SELECT User, Host FROM mysql.user WHERE User = '';

2)
mysql> DROP USER ''@'localhost';
mysql> DROP USER ''@'%.example.com';