/*

!!SECURITY - EXPIRING PASSWORDS!!

> You want users to pick a new MySQL password

> The ALTER USER statement expires passwords

*/

/*
EXAMPLE
1) MySQL 5.6.7 and up provides an ALTER USER statement that enables an administrator
to expire an account’s password

Here are some uses for password expiration:
	• You can implement a policy that new users must select a new password when first
	connecting: immediately expire the password for each new account you create.
	• If you impose a stricter policy on acceptable passwords (see Recipe 23.3), you can
	expire all existing passwords to require each user to choose a new one that meets
	the more stringent requirements.
	
2) ALTER USER affects a single account. It works by setting the password_expired column to Y 
for the appropriate mysql.user row. To “cheat” and expire passwords for all nonanonymous
accounts at once, do this

3) Alternatively, to affect all accounts but avoid modifying the grant tables directly, use a
stored procedure that loops through all accounts and executes ALTER USER for each
*/
1)
ALTER USER 'cbuser'@'localhost' PASSWORD EXPIRE;

2)
UPDATE mysql.user SET password_expired = 'Y' WHERE User <> '';
FLUSH PRIVILEGES;

3)
CREATE PROCEDURE expire_all_passwords()
BEGIN
DECLARE done BOOLEAN DEFAULT FALSE;
DECLARE account TEXT;
DECLARE cur CURSOR FOR
SELECT CONCAT(QUOTE(User),'@',QUOTE(Host)) AS account
FROM mysql.user WHERE User <> '';
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
OPEN cur;
expire_loop: LOOP
FETCH cur INTO account;
IF done THEN
LEAVE expire_loop;
END IF;
CALL exec_stmt(CONCAT('ALTER USER ',account,' PASSWORD EXPIRE'));
END LOOP;
CLOSE cur;
END;




