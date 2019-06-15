/*

!!VALIDATING & REFORMATING DATA - USING THE SQL MODE TO REJECT BAD INPUT VALUES!!

> By default, MySQL is forgiving about accepting data values that are invalid, out of range,
or otherwise unsuitable for the data types of the columns into which you insert them.
	>> But you want the server to be more restrictive and not accept bad data
	
> Set the SQL mode. 
	>> Several mode values are available to control how strict the server is.
	>> Some modes apply generally to all input values. Others apply to specific data types 
	such as dates

*/

/*
STRATEGY:
1) One way to prevent these warnings is to check the input data on the client side to make
sure that it’s legal
2) Let the server check data values on the server side and reject them with an error if 
they’re invalid
	>> To do this, set the sql_mode system variable to enable server restrictions on input 
	data acceptance.
	
> You can read more about the various SQL modes in the MySQL Reference Manual
*/