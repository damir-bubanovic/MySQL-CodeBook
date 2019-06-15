/*

!!WORKING WITH STRINGS - CHECKING OR CHANGING A STRINGS CHARACTER SET OR COLLATION!!

> You want to know the character set or collation of a string, or change a string to some
other character set or collation

> To check a string’s character set or collation, use the CHARSET() or COLLATION() function.
	>> To change its character set, use the CONVERT() function. 
	>> To change its collation, use the COLLATE operator

*/

/*
EXAMPLE:
> For a table created as follows, you know that values stored in the column c have a
character set of utf8 and a collation of utf8_danish_ci
*/
CREATE TABLE t (c CHAR(10) CHARACTER SET utf8 COLLATE utf8_danish_ci);


/*
EXAMPLE:
1) To determine a string’s character set or collation, use the CHARSET() or COLLATION()
function

2) String values that take their character set and collation from the current configuration
may change properties if the configuration changes. This is true for literal strings

> For a binary string, the CHARSET() or COLLATION() functions return a value of binary,
which means that the string is compared and sorted based on numeric byte values, not
character collation values
*/
1)
mysql> SELECT USER(), CHARSET(USER()), COLLATION(USER());

2)
mysql> SET NAMES 'latin1';
mysql> SELECT CHARSET('abc'), COLLATION('abc');

mysql> SET NAMES utf8 COLLATE 'utf8_bin';
mysql> SELECT CHARSET('abc'), COLLATION('abc');


/*
EXAMPLe:
1) To convert a string from one character set to another, use the CONVERT() function

2) To change the collation of a string, use the COLLATE operator

3) The new collation must be legal for the character set of the string. 
	> npr. you can use the utf8_general_ci collation with utf8 strings, but not with 
	latin1 strings

4) To convert both the character set and collation of a string, use CONVERT() to 
change the character set, and apply the COLLATE operator to the result

5) The CONVERT() function can also convert binary strings to nonbinary strings and vice
versa. 
	> To produce a binary string, use binary; any other character-set name produces
	a nonbinary string
	
6) Alternatively, produce binary strings using the BINARY operator, which is equivalent 
to CONVERT(str USING binary)
*/
1)
mysql> SET @s1 = _latin1 'my string', @s2 = CONVERT(@s1 USING utf8);
mysql> SELECT CHARSET(@s1), CHARSET(@s2);

2)
mysql> SET @s1 = _latin1 'my string', @s2 = @s1 COLLATE latin1_spanish_ci;
mysql> SELECT COLLATION(@s1), COLLATION(@s2);

3) mysql> SELECT _latin1 'abc' COLLATE utf8_bin;
ERROR 1253 (42000): COLLATION 'utf8_bin' is not valid for
CHARACTER SET 'latin1'

4) 
mysql> SET @s1 = _latin1 'my string';
mysql> SET @s2 = CONVERT(@s1 USING utf8) COLLATE utf8_spanish_ci;
mysql> SELECT CHARSET(@s1), COLLATION(@s1), CHARSET(@s2), COLLATION(@s2);

5)
mysql> SET @s1 = _latin1 'my string';
mysql> SET @s2 = CONVERT(@s1 USING binary);
mysql> SET @s3 = CONVERT(@s2 USING utf8);
mysql> SELECT CHARSET(@s1), CHARSET(@s2), CHARSET(@s3);

6)
mysql> SELECT CHARSET(BINARY _latin1 'my string');

