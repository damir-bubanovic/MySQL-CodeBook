/*

!!STORED ROUTINES, TRIGGERS & SCHEDULED EVENTS - HANDLING ERRORS WITHIN STORED PROGRAMS!!

> Within stored programs, you can catch errors or exceptional conditions using condition
handlers. 
	>> A handler activates under specific circumstances, causing the code associated
	with it to execute. 
	>> The code takes suitable action such as performing cleanup processing or setting a 
	variable that can be tested elsewhere in the program to determine whether the condition 
	occurred. 
	>> A handler might even ignore an error if it occurs under certain permitted conditions 
	and you want to catch it rather than have it terminate your program.
> Stored programs can also produce their own errors or warnings to signal that something
has gone wrong

*/

/*
DETECTING END-OF-DATA CONDITIONS
> common use of condition handlers is to detect “no more rows” conditions

> To process a query result one row at a time, use a cursor-based fetch loop in conjunction
with a condition handler that catches the end-of-data condition. 
> The technique has these essential elements
	• A cursor associated with a SELECT statement that reads rows. 
		>> Open the cursor to start reading, and close it to stop.
	• A condition handler that activates when the cursor reaches the end of the result set
	and raises an end-of-data condition (NOT FOUND). 
	• A variable that indicates loop termination. 
		>> Initialize the variable to FALSE, then set it to TRUE within the condition handler 
		when the end-of-data condition occurs.
	• A loop that uses the cursor to fetch each row and exits when the loop-termination
	variable becomes TRUE.


EXAMPLE:
1) Example implements a fetch loop that processes the states table row by
row to calculate the total US population

2) Check on whether the fetch loop calculates the correct value
*/
1)
CREATE PROCEDURE us_population()
BEGIN
DECLARE done BOOLEAN DEFAULT FALSE;
DECLARE state_pop, total_pop BIGINT DEFAULT 0;
DECLARE cur CURSOR FOR SELECT pop FROM states;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
OPEN cur;
fetch_loop: LOOP
FETCH cur INTO state_pop;
IF done THEN
LEAVE fetch_loop;
END IF;
SET total_pop = total_pop + state_pop;
END LOOP;
CLOSE cur;
SELECT total_pop AS 'Total U.S. Population';
END;

2)
mysql> CALL us_population();

mysql> SELECT SUM(pop) AS 'Total U.S. Population' FROM states;


/*
CATCHING & IGNORING ERRORS
> If you consider an error benign, you can use a handler to ignore it

> Many DROP statements in MySQL have an IF EXISTS clause to suppress errors if objects to be
dropped do not exist
> But some DROP statements have no such clause and thus no way to suppress errors

EXAMPLE:
1) DROP USER error

2) To prevent errors from occurring for nonexistent users, invoke DROP USER within a stored
procedure that catches code 1396 and ignores it

3) If the user does not exist, drop_user() writes a message within the condition handler,
but no error occurs

4) To ignore the error completely, write the handler using an empty BEGIN … END block
*/
1) 
mysql> DROP USER 'bad-user'@'localhost';
ERROR 1396 (HY000): Operation DROP USER failed for 'bad-user'@'localhost'

2)
CREATE PROCEDURE drop_user(user TEXT, host TEXT)
BEGIN
	DECLARE account TEXT;
	DECLARE CONTINUE HANDLER FOR 1396
	SELECT CONCAT('Unknown user: ', account) AS Message;
	SET account = CONCAT(QUOTE(user),'@',QUOTE(host));
	CALL exec_stmt(CONCAT('DROP USER ',account));
END;

3)
mysql> CALL drop_user('bad-user','localhost');

4)
DECLARE CONTINUE HANDLER FOR 1396 BEGIN END;


/*
RAISING ERRORS & WARNINGS
> To produce your own errors within a stored program when you detect something awry,
use the SIGNAL statement

EXAMPLE:
1) division by zero produces only a warning

2) To ensure a divide-by-zero error in any context, write a function that performs the
division but checks the divisor first and uses SIGNAL to raise an error if the “can’t happen”
condition occurs

3) Test the function in a nonmodification context to verify that it produces an error


> SIGNAL can also raise warning conditions, not just errors
> The following routine, drop_user_warn() generates a warning that can be displayed
with SHOW WARNINGS
4) Look

5) Give it a test
*/
1)
mysql> SET sql_mode = 'ERROR_FOR_DIVISION_BY_ZERO,STRICT_ALL_TABLES';
mysql> SELECT 1/0;

1 row in set, 1 warning (0.00 sec)
mysql> SHOW WARNINGS;

2)
CREATE FUNCTION divide(numerator FLOAT, divisor FLOAT)
RETURNS FLOAT DETERMINISTIC
BEGIN
IF divisor = 0 THEN
SIGNAL SQLSTATE '22012'
SET MYSQL_ERRNO = 1365, MESSAGE_TEXT = 'unexpected 0 divisor';
END IF;
RETURN numerator / divisor;
END;

3)
mysql> SELECT divide(1,0);
ERROR 1365 (22012): unexpected 0 divisor


4)
CREATE PROCEDURE drop_user_warn(user TEXT, host TEXT)
BEGIN
DECLARE account TEXT;
DECLARE CONTINUE HANDLER FOR 1396
BEGIN
DECLARE msg TEXT;
SET msg = CONCAT('Unknown user: ', account);
SIGNAL SQLSTATE '01000' SET MYSQL_ERRNO = 1642, MESSAGE_TEXT = msg;
END;
SET account = CONCAT(QUOTE(user),'@',QUOTE(host));
CALL exec_stmt(CONCAT('DROP USER ',account));
END;

5)
mysql> CALL drop_user_warn('bad-user','localhost');
Query OK, 0 rows affected, 1 warning (0.00 sec)
mysql> SHOW WARNINGS;
