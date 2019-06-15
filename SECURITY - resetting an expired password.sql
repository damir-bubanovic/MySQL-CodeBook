/*

!!SECURITY - RESETTING AN EXPIRED PASSWORD!!

> You cannot use MySQL because your DBA expired your password

> Assign yourself a new password

*/

/*
1) If the MySQL administrator has expired your password, MySQL will let you connect,
but not do much of anything else

2) If you see that message, reset your password so that you can work normally again
*/
1)
% mysql --user=cbuser --password
Enter password: ******
mysql> SELECT CURRENT_USER();
ERROR 1820 (HY000): You must SET PASSWORD before executing this statement

2)
mysql> SET PASSWORD = PASSWORD('my-new-password');
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT CURRENT_USER(); -- now you can work again