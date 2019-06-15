/*

!!STORED ROUTINES, TRIGGERS & SCHEDULED EVENTS - USING STORED PROCEDURES TO RETURN MULTIPLE VALUES!!

> An operation produces two or more values, but a stored function can return only a
single value

> Use a stored procedure that has OUT or INOUT parameters, and pass user-defined variables
for those parameters when you invoke the procedure. 
> A procedure does not “return” a value the way a function does, but it can assign values 
to those parameters so that the user-defined variables have the desired values when the 
procedure returns

*/

/*
> Unlike stored function parameters, which are input values only, a stored procedure
parameter can be any of three types:
	• An IN parameter is for input only. This is the default if you specify no type.
	• An INOUT parameter is used to pass a value in, and can also pass a value out.
	• An OUT parameter is used to pass a value out.

	
EXAMPLE:
> mail_sender_stats(), runs a query on the mail table to retrieve mailsending
statistics about a given username, which is the input value. 
1) The procedure determines how many messages that user sent, and the total and average 
sizes of the messages in bytes, which it returns through three OUT parameters

2) To use the procedure, pass a string containing the username, and three user-defined
variables to receive the OUT values. After the procedure returns, access the variable 
values
*/
1)
CREATE PROCEDURE mail_sender_stats(IN user VARCHAR(8),
OUT messages INT,
OUT total_size INT,
OUT avg_size INT)

BEGIN
# Use IFNULL() to return 0 for SUM() and AVG() in case there are
# no rows for the user (those functions return NULL in that case).
SELECT COUNT(*), IFNULL(SUM(size),0), IFNULL(AVG(size),0)
INTO messages, total_size, avg_size
FROM mail WHERE srcuser = user;
END;

2)
mysql> CALL mail_sender_stats('barb',@messages,@total_size,@avg_size);
mysql> SELECT @messages, @total_size, @avg_size;