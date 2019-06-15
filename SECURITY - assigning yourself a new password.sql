/*

!!SECURITY - ASSIGNING YOURSELF A NEW PASSWORD!!

> You want to change your password

> Use the SET PASSWORD statement

*/

/*
EXAMPLE:
1) To assign yourself a new password, use the SET PASSWORD statement and the 
PASSWORD() function

2) SET PASSWORD permits a FOR clause that enables you to specify which account 
gets the new password

> To check the strength of a password you’re considering, use the 
VALIDATE_PASSWORD_STRENGTH() function
*/
1)
SET PASSWORD = PASSWORD('my-new-password');

2)
SET PASSWORD FOR 'user_name'@'host_name' = PASSWORD('my-new-password');