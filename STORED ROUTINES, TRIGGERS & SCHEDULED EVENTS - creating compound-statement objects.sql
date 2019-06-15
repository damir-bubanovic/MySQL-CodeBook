/*

!!STORED ROUTINES, TRIGGERS & SCHEDULED EVENTS - CREATING COMPOUND-STATEMENT OBJECTS!!

> You want to define a stored program, but its body contains instances of the ; statement
terminator. 
	>> The mysql client program uses the same terminator by default, so mysql misinterprets 
	the definition and produces an error

> Redefine the mysql statement terminator with the delimiter command
	
*/

/*
> Each stored program is an object with a body that must be a single SQL statement.
	>> However, these objects often perform complex operations that require several statements.
	>> To handle this, write the statements within a BEGIN … END block that forms a compound 
	statement
	

EXAMPLE:
> The following example uses a stored function to illustrate how to change the delimiter,
but the principles apply to defining any type of stored program
1) Create a stored function that calculates and returns the average size in bytes of 
mail messages listed in the mail table
	>> In mysql, you can enter that statement as shown and there is no problem
	
2) But suppose instead that you want the function to take an argument naming a user that
it interprets as follows:
	• If the argument is NULL, the function returns the average size for all messages 
	(as	before).
	• If the argument is non-NULL, the function returns the average size for messages 
	sent by that user.

>If you try to define the function within mysql by entering that definition as just shown,
mysql improperly interprets the first semicolon in the function body as ending the definition.
3) Instead, use the delimiter command to change the mysql delimiter, then restore
the delimiter to its default value

4) After defining the stored function, invoke it the same way as a built-in function
*/
1)
CREATE FUNCTION avg_mail_size()
RETURNS FLOAT READS SQL DATA
RETURN (SELECT AVG(size) FROM mail);

2)
CREATE FUNCTION avg_mail_size(user VARCHAR(8))
RETURNS FLOAT READS SQL DATA
BEGIN
DECLARE avg FLOAT;
IF user IS NULL
THEN # average message size over all users
SET avg = (SELECT AVG(size) FROM mail);
ELSE # average message size for given user
SET avg = (SELECT AVG(size) FROM mail WHERE srcuser = user);
END IF;
RETURN avg;
END;

3)
mysql> delimiter $$
mysql> CREATE FUNCTION avg_mail_size(user VARCHAR(8))
	-> RETURNS FLOAT READS SQL DATA
	-> BEGIN
	-> DECLARE avg FLOAT;
	-> IF user IS NULL
	-> THEN # average message size over all users
	-> SET avg = (SELECT AVG(size) FROM mail);
	-> ELSE # average message size for given user
	-> SET avg = (SELECT AVG(size) FROM mail WHERE srcuser = user);
	-> END IF;
	-> RETURN avg;
	-> END;
	-> $$
Query OK, 0 rows affected (0.02 sec)
mysql> delimiter ;

4)
mysql> SELECT avg_mail_size(NULL), avg_mail_size('barb');
