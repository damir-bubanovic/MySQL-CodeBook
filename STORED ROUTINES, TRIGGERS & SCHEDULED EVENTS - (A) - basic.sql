/*

!!STORED ROUTINES, TRIGGERS & SCHEDULED EVENTS - BASIC!!

*/

/*
> This chapter discusses stored database objects, which come in several varieties

Stored functions and procedures
	> A stored function or procedure object encapsulates the code for performing an
	operation, enabling you to invoke the object easily by name rather than repeat all
	its code each time it’s needed. 
	> A stored function performs a calculation and returns a value that can be used in 
	expressions just like a built-in function such as RAND(), NOW(), or LEFT(). 
	> A stored procedure performs operations for which no return value is needed. 
	> Procedures are invoked with the CALL statement, not used in expressions.
	> A procedure might update rows in a table or produce a result set that is
	sent to the client program.
	
Triggers
	> A trigger is an object that activates when a table is modified by an INSERT, UPDATE,
	or DELETE statement. 
		>> npr. you can check values before they are inserted into a table, or specify that 
		any row deleted from a table should be logged to another table that serves as a 
		journal of data changes. 
	> Triggers automate these actions so that you need not remember to do them yourself 
	each time you modify a table.
	
Scheduled events
	> An event is an object that executes SQL statements at a scheduled time or times.
	> Think of a scheduled event as something like a Unix cron job that runs within MySQL. 
		>> npr. events can help you perform administrative tasks such as deleting old 
		table rows periodically or creating nightly summaries.
*/