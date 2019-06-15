/*

!!BASIC - SETTING UP A MYSQL USER ACCOUNT!!

> You need an account for connecting to your MySQL server

> Use CREATE USER and GRANT statements to set up the account. 
> Then use the account name and password to make connections to the server


EXAMPLE:
> how to use the mysql program to connect to the server and issue the statements 
that set up a user account with privileges for accessing a database named cookbook
*/

% mysql -h localhost -u root -p
Enter password: ******
mysql> CREATE USER 'cbuser'@'localhost' IDENTIFIED BY 'cbpass';
mysql> GRANT ALL ON cookbook.* TO 'cbuser'@'localhost';
Query OK, 0 rows affected (0.09 sec)
mysql> quit
Bye


/*
> If you plan to connect to the server from another host, substitute 
that host in the CREATE USER and GRANT statements
	>> npr. if you’ll connect to the server from a host named myhost.example.com, 
	the statements look like this
*/

mysql> CREATE USER 'cbuser'@'myhost.example.com' IDENTIFIED BY 'cbpass';
mysql> GRANT ALL ON cookbook.* TO 'cbuser'@'myhost.example.com';


/*
> After creating the cbuser account, verify that you can use it to connect to the MySQL
server. From the host that was named in the CREATE USER statement, run the following
command to do this
*/

% mysql -h localhost -u cbuser -p
Enter password: cbpass