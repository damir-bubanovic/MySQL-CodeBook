/*

!!VALIDATING & REFORMATING DATA - VALIDATING & TRANSFORMING DATA!!

> You must make sure that the data values in a file are legal

> Check them, possibly rewriting them into a more suitable format

*/

/*
> Sometimes you must focus on the data content of a file, not only its structure:
	• It’s often a good idea to validate data values to make sure they’re legal for the data
	types into which you store them. 
	• Data values may need reformatting. 
		> You might store credit card values as a string of digits but permit users of a web 
		application to separate blocks of digits by spaces or dashes. 
			>> These values must be rewritten before storing them. 
			>> Rewriting dates from one format to another is especially common

> Techniques covered here for checking values include pattern matching and validation against 
information in a database.

> By packaging validation operations as library routines, it is easier to write utilities 
based on them, and the utilities make it easier to perform command-line operations on entire 
files so that you can avoid editing them yourself
	>> To avoid writing your own library routines, look around to see if someone else has
	already written suitable routines that you can use
*/

/*
WRITING AN INPUT-PROCESSING LOOP
> The general framework for such a file-processing utility looks like this
1) The while() loop reads each input line. 
2) Within the loop, each line is broken into fields.
3) The inner for() loop iterates through the fields, enabling each to be processed in sequence
4) If you don’t apply a given test uniformly to all the fields, replace the for() loop with 
separate column-specific tests

> This loop assumes tab-delimited, linefeed-terminated input, an assumption shared by
most of the utilities discussed throughout this chapter
*/

/*
PUTTING COMMON TESTS IN LIBRARIES
> It may be useful to package a test that you perform often as a library function. 
	>> This makes the operation easy to perform and also gives it a name that’s likely to 
	make the meaning of the operation clearer than the comparison code itself
		>>> npr. pattern match
*/