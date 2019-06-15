/*

!!SECURITY - CHECKING PASSWORD STRENGTH!!

> You want to assign or change a password but verify first that it’s not weak

> Use the VALIDATE_PASSWORD_STRENGTH() function.

*/

/*
> VALIDATE_PASSWORD_STRENGTH(), that enables strength testing
of prospective passwords. Uses for this function include
	• An administrator wants to check passwords to be assigned to new accounts.
	• An individual user wants to choose a new password but seeks assurance in advance
	how strong it is.
	
> To use VALIDATE_PASSWORD_STRENGTH(), the validate_password plug-in must be enabled


EXAMPLE:
1) VALIDATE_PASSWORD_STRENGTH() returns a value from 0 (weak) to 100 (strong)
*/
1) 
mysql> SELECT VALIDATE_PASSWORD_STRENGTH('abc') ;

mysql> SELECT VALIDATE_PASSWORD_STRENGTH('weak-password');

mysql> SELECT VALIDATE_PASSWORD_STRENGTH('Str0ng-Pa33w@rd');