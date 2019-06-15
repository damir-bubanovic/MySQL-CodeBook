/*

!!BASIC - MySQL-BASED PROGRAMS - HANDLING SPECIAL CHARACTERS & NULL VALUES IN STATEMENTS!!

> You need to construct SQL statements that refer to data values containing special characters
such as quotes or backslashes, or special values such as NULL. 
> Or you are constructing statements using data obtained from external sources and want to 
prevent SQL injection attacks

> Use your API’s placeholder mechanism or quoting function to make data safe for insertion


> You have two means at your disposal for dealing with special characters such as quotes
and backslashes, and with special values such as NULL:
	• Use placeholders in the statement string to refer to data values symbolically, then
	bind the data values to the placeholders when you execute the statement. 
		>> preferred method because the API itself does all or most of the work for you of
		providing quotes around values as necessary, quoting or escaping special characters
		within the data value, and possibly interpreting a special value to map onto NULL
		without enclosing quotes.
	• Use a quoting function (if your API provides one) for converting data values to a
	safe form that is suitable for use in statement strings.

*/


/*
USING PLACEHOLDERS
> Placeholders enable you to avoid writing data values literally in SQL statements
	>> common parameter marker is ?

> Then pass the statement string to the database server and supply the data values separately.
	>> The API binds the values to the placeholders to replace them, resulting in a statement 
	that contains the data values

BENEFITS OF PLACEHOLDERS:
1) benefit of placeholders is that parameter-binding operations automatically handle
escaping of characters such as quotes and backslashes. 
	>> This is especially useful for inserting binary data such as images into your database
	or using data values with unknown content such as input submitted by a remote user through 
	a form in a web page
2) benefit of placeholders is that you can “prepare” a statement in advance, then reuse it by 
binding different values to it each time it’s executed. 
3) benefit is that code that uses placeholder-based statements can be easier to read
	
EXAMPLE:
*/
INSERT INTO profile (name,birth,color,foods,cats)
VALUES(?,?,?,?,?)


/*
USING A QUOTING FUNCTION
> Some APIs provide a quoting function that takes a data value as its argument and returns
a properly quoted and escaped value suitable for safe insertion into an SQL statement
*/


/*
> USEse placeholders with the PDO extension, pass a statement string to prepare() to
get a statement object
> Use this object to invoke execute(), passing to it the array of data values to bind to 
the placeholders
> Use the PHP NULL value to bind an SQL NULL value to a placeholder

1) Add the profile table row for De’Mont

2) The resulting statement includes a properly escaped quote and a properly unquoted NULL value
*/
1)
$sth = $dbh->prepare ("INSERT INTO profile (name,birth,color,foods,cats) VALUES(?,?,?,?,?)");
$sth->execute (array ("De'Mont","1973-01-12",NULL,"eggroll",4));

2)
INSERT INTO profile (name,birth,color,foods,cats)
VALUES('De\'Mont','1973-01-12',NULL,'eggroll','4')
