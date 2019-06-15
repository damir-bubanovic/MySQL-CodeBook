/*

!!WORKING WITH STRINGS - CONVERTING THE LETTERCASE OF A STRING!!

> You want to convert a string to uppercase or lowercase

> Use the UPPER() or LOWER() function. 
	>> If they don’t work, you’re probably trying to convert a binary string. 
	>> Convert it to a nonbinary string that has a character set and collation 
	and is subject to case mapping

> If you’re not sure whether a string expression is binary or nonbinary, use the 
CHARSET() function to find out

*/

/*
EXAMPLE:
1) The UPPER() and LOWER() functions convert the lettercase of a string

2) some strings are “stubborn” and resist lettercase conversion
	> This problem occurs for strings that have a BINARY or BLOB data type. 
	> These are binary strings that have no character set or collation. 
	> Lettercase does not apply, and UPPER() and LOWER() do nothing

3) To map a binary string to a given lettercase, convert it to a nonbinary string, 
choosing a character set that has uppercase and lowercase characters. 
	> The case-conversion functions then work as you expect because the collation 
	provides case mapping
	
4) To convert the lettercase of only part of a string, break it into pieces, convert the 
relevant piece, and put the pieces back together
	> npr. convert only the initial character of a string to uppercase
	4.1) Define a stored function
	4.2) Then you can capitalize initial characters more easily
*/
1)
mysql> SELECT thing, UPPER(thing), LOWER(thing) FROM limbs;

2)
mysql> CREATE TABLE t (b BLOB) SELECT 'aBcD' AS b;
mysql> SELECT b, UPPER(b), LOWER(b) FROM t;

3)
mysql> SELECT b,
	-> UPPER(CONVERT(b USING latin1)) AS upper,
	-> LOWER(CONVERT(b USING latin1)) AS lower
	-> FROM t;
	
4.1) 
mysql> CREATE FUNCTION initial_cap (s VARCHAR(255))
	-> RETURNS VARCHAR(255) DETERMINISTIC
	-> RETURN CONCAT(UPPER(LEFT(s,1)),MID(s,2));
4.2) 
mysql> SELECT thing, initial_cap(thing) FROM limbs;	
	