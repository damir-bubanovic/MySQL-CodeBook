/*

!!SECURITY - IMPLEMENTING A PASSWORD POLICY!!

> You want to ensure that MySQL accounts do not use weak passwords

> Use the validate_password plug-in to implement a password policy. New passwords must 
satisfy the policy, whether those chosen by the DBA for new accounts or by existing
users changing their password

*/

/*
> When validate_password is enabled, it exposes a set of system variables that enable
you to configure it. 
1) These are the default values

2) Suppose that you want to implement a policy that enforces these requirements for passwords:
	• At least 10 characters long
	• Contains uppercase and lowercase characters
	• Contains at least two digits
	• Contains at least one special (nonalphanumeric) character
> To put that policy in place, start the server with options that enable the plug-in and set
the values of the system variables that configure the policy requirements

3) After starting the server, verify the settings
*/
1)
mysql> SHOW VARIABLES LIKE 'validate_password%';

2)
[mysqld]
plugin-load-add=validate_password.so
validate_password_length=10
validate_password_mixed_case_count=1
validate_password_number_count=2
validate_password_special_char_count=1

3)
mysql> SHOW VARIABLES LIKE 'validate_password%';


/*
> Control how the server tests passwords
	• MEDIUM enables tests for password length and the number of numeric, uppercase/
	lowercase, and special characters.
	
	• To be less rigorous, set the policy to LOW, which enables only the length test. To also
	permit shorter passwords, decrease the required length (validate_password_length).
	
	• To be more rigorous, set the policy to STRONG, which is like MEDIUM but also enables
	you to have passwords checked against a dictionary file, to prevent use of passwords
	that match any word in the file. Comparisons are not case sensitive.
	To use a dictionary file, set the value of validate_password_dictionary_file to
	the filename at server startup. The file should contain lowercase words, one per
	line. MySQL distributions include a dictionary.txt file in the share directory that
	you can use, and Unix systems often have a /usr/share/dict/words file.
*/
