/*

!!SECURITY - UNDERSTANDING THE mysql.user TABLE!!

> MySQL stores user account information in tables in the mysql system database
1) To see its structure:

*/
1) 
SHOW CREATE TABLE mysql.user;

/*
> The user table columns that concern us here specify account names and authentication
information

	• The User and Host columns identify the account. MySQL account names comprise
	a combination of username and hostname values
		1) Example
		
	• The plugin, Password, and authentication_string columns store authentication
	credentials.
		> server computes a hash value from the password and stores the hash string
			>> Look this up because the methods below are not so secure by my opinion
		
		Plug-in 					Authentication method
		mysql_native_password 		Native password hashing
		mysql_old_password 			“Old” native password hashing (deprecated)
		sha256_password 			SHA-256 password hashing (MySQL 5.6.6 or later)
*/
1)
'cbuser'@'localhost'