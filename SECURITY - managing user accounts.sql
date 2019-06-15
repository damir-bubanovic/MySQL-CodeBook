/*

!!SECURITY - MANAGING USER ACCOUNTS!!

> You are responsible for setting up accounts on your MySQL server

> Learn to use the account-management SQL statements

*/

/*
> It’s possible to modify the grant tables in the mysql database directly with SQL statements
such as INSERT or UPDATE, but the MySQL account-management statements are more convenient
	• Creating accounts (CREATE USER, SET PASSWORD)
	• Assigning and checking privileges (GRANT, REVOKE, SHOW GRANTS)
	• Removing and renaming accounts (DROP USER, RENAME USER)
*/

/*
CREATING ACCOUNTS
> To create an account, use the CREATE USER statement, which creates a row in the
mysql.user table. But before you do so, decide these three things
	• The account name, expressed in 'user_name'@'host_name' format naming the
	user and the host from which the user will connect
	• The account password
	• The authentication plug-in the server should execute when clients attempt to use
	the account

> Authentication plug-ins use hashing to encrypt passwords for storage and transmission.
MySQL has several built-in plug-ins from which to choose (earlier described)

EXAMPLE:
1) The CREATE USER statement is commonly used in one of these forms
*/
1)
CREATE USER 'user_name'@'host_name' IDENTIFIED BY 'password';
CREATE USER 'user_name'@'host_name' IDENTIFIED WITH 'auth_plugin';


/*
WRITING AN ACCOUNT-CREATION HELPER PROCEDURE
> write a helper stored procedure named create_user() that does all the work, given the 
account username, hostname, password, and authentication plug-in

EXAMPLE:
1) To use the procedure, invoke it like this

2) The procedure definition is shown following. It requires the helper routines exec_stmt() 
and server_version()
*/
1)
CALL create_user('user_name','host_name','password','auth_plugin');

2)
CREATE PROCEDURE create_user(user TEXT, host TEXT,
password TEXT, plugin TEXT)
BEGIN
DECLARE account TEXT;
SET account = CONCAT(QUOTE(user),'@',QUOTE(host));
CALL exec_stmt(CONCAT('CREATE USER ',account,
' IDENTIFIED WITH ',QUOTE(plugin)));
IF password IS NOT NULL THEN
BEGIN
DECLARE saved_old_passwords INT;
SET saved_old_passwords = @@old_passwords;
CASE plugin
WHEN 'mysql_native_password' THEN SET old_passwords = 0;
WHEN 'mysql_old_password' THEN SET old_passwords = 1;
WHEN 'sha256_password' THEN SET old_passwords = 2;
ELSE SIGNAL SQLSTATE 'HY000'
SET MYSQL_ERRNO = 1525,
MESSAGE_TEXT = 'unhandled auth plugin';
END CASE;
CALL exec_stmt(CONCAT('SET PASSWORD FOR ',account,
' = PASSWORD(',QUOTE(PASSWORD),')'));
SET old_passwords = saved_old_passwords;
END;
END IF;
IF server_version() >= 50607 AND user <> '' THEN
CALL exec_stmt(CONCAT('ALTER USER ',account,' PASSWORD EXPIRE'));
END IF;
END;


/*
ASSIGNING & CHECKING PRIVILEGES
> Suppose that you have just created an account named 'user1'@'localhost'. You can
assign privileges to it with GRANT, remove privileges from it with REVOKE, and check its
privileges with SHOW GRANTS

EXAMPLE:
1) GRANT has this syntax


> The following examples illustrate the syntax for granting privileges at each level
2) Granting privileges globally enables the account to perform administrative operations
or operations on any database

3) Granting privileges at the database level enables the account to perform operations
on objects within the named database

4) Granting privileges at the table level enables the account to perform operations on
the named table

5) Granting privileges at the column level enables the account to perform operations
on the named table column

6) Granting privileges at the procedure level enables the account to perform operations
on the named stored procedure


7) To verify the privilege assignments, use SHOW GRANTS

8) To see your own privileges, omit the FOR clause

9) Thus, to remove the privileges just granted to 'user1'@'localhost', use these RE
VOKE statements (and SHOW GRANTS to verify that they were removed)
*/
1)
GRANT privileges ON scope TO account;


2)
GRANT FILE ON *.* TO 'user1'@'localhost';
GRANT CREATE TEMPORARY TABLES, LOCK TABLES ON *.* TO 'user1'@'localhost';

3)
GRANT ALL ON cookbook.* TO 'user1'@'localhost';

4)
GRANT SELECT ON mysql.user TO 'user1'@'localhost';

5)
GRANT SELECT(User,Host), UPDATE(password_expired)
ON mysql.user TO 'user1'@'localhost';

6)
GRANT EXECUTE ON PROCEDURE cookbook.exec_stmt TO 'user1'@'localhost';


7)
mysql> SHOW GRANTS FOR 'user1'@'localhost';

8)
REVOKE privileges ON scope FROM account;

9)
mysql> REVOKE FILE ON *.* FROM 'user1'@'localhost';
mysql> REVOKE CREATE TEMPORARY TABLES, LOCK TABLES
	-> ON *.* FROM 'user1'@'localhost';
mysql> REVOKE ALL ON cookbook.* FROM 'user1'@'localhost';
mysql> REVOKE SELECT ON mysql.user FROM 'user1'@'localhost';
mysql> REVOKE SELECT(User,Host), UPDATE(password_expired)
	-> ON mysql.user FROM 'user1'@'localhost';
mysql> REVOKE EXECUTE ON PROCEDURE cookbook.exec_stmt
	-> FROM 'user1'@'localhost';
mysql> SHOW GRANTS FOR 'user1'@'localhost';


/*
REMOVING ACCOUNTS
1) To get rid of an account, use the DROP USER statement
> The statement removes all rows associated with the account in all grant tables; you need
not use REVOKE to remove its privileges first. An error occurs if the account does not exist
*/
1)
DROP USER 'user1'@'localhost';


/*
RENAMING ACCOUNTS
1) To change an account name, use RENAME USER, specifying the current and new names
*/
1)
RENAME USER 'currentuser'@'localhost' TO 'newuser'@'localhost';
