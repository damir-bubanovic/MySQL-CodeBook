/*

!!GENERATING & USING SEQUENCES - MANAGING MULTIPLE AUTO-INCREMENT VALUES SIMULTANEOUSLY!!

> You’re executing multiple statements that generate AUTO_INCREMENT values, and it’s necessary
to keep track of them independently. 
	>> npr. you’re inserting rows into multiple tables, each of which has its own AUTO_INCREMENT 
	column

> Save the sequence values in variables for later use. 
> Alternatively, if you execute sequencegenerating statements from within a program, you might 
be able to issue the statements using separate connection or statement objects to keep them 
from getting mixed up
	
*/

/*
> What if you issue a statement that generates an AUTO_INCREMENT value, but you don’t want to 
refer to that value until after issuing a second statement that also generates an AUTO_INCREMENT value? 
> In this case, the original value is no longer accessible, either through LAST_INSERT_ID() or as a
client-side value. 
> To retain access to it, save the value first before issuing the second statement:

EXAMPLE:
> Several ways to do this:

	• At the SQL level, save the value in a user-defined variable after issuing a statement
	that generates an AUTO_INCREMENT value
	1) Like this
		>> Then you can issue other statements without regard to their effect on LAST_INSERT_ID(). 
		>> To use the original AUTO_INCREMENT value in a subsequent statement, refer to the 
		@saved_id variable.
		
	• At the API level, save the AUTO_INCREMENT value in an API language variable. 
		>> This	can be done by saving the value returned from either LAST_INSERT_ID() or any
		API-specific extension that is available.
		
	• Some APIs enable you to maintain separate client-side AUTO_INCREMENT values. 
*/
1)
INSERT INTO tbl_name (id,...) VALUES(NULL,...);
SET @saved_id = LAST_INSERT_ID();