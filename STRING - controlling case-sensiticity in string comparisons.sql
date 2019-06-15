/*

!!WORKING WITH STRINGS - CONTROLLING CASE SENSITIVITY IN STRING COMPARISONS!!

> You want to know whether strings are equal or unequal, or which appears first 
in lexical order

> Use a comparison operator. 
	>> Remember that strings have properties such as case sensitivity that you must 
	take into account. 
	>> A string comparison might be case sensitive when you don’t want it to be, or 
	vice versa

*/

/*
> As for other data types, you can compare string values for equality, inequality, or relative
ordering
*/
mysql> SELECT 'cat' = 'cat', 'cat' = 'dog', 'cat' <> 'cat', 'cat' <> 'dog';

mysql> SELECT 'cat' < 'awk', 'cat' < 'dog', 'cat' BETWEEN 'awk' AND 'eel';

/*
> ALERT <
	> comparison and sorting properties of strings are subject to complications that
	don’t apply to other types of data
	> sometimes you must ensure that a string comparison is case sensitive that would not 
	otherwise be, or vice versa
*/

/*
> String comparison properties depend on whether the operands are binary or nonbinary
strings
	• A binary string is a sequence of bytes and is compared using numeric byte values.
	Because letters in different cases have different byte values, comparisons of binary 
	strings effectively are case sensitive
		>> To compare binary strings such that lettercase does not matter, convert them to 
		nonbinary strings that have a case-insensitive collation
	• A nonbinary string is a sequence of characters and is compared in character units.
		>> If the collation is case sensitive, and you want a case-insensitive collation 
		(or vice versa), convert the strings to use a collation with the desired case-comparison 
		properties
*/

/*
1) how two binary strings that compare as unequal can be handled so that they are equal when 
compared as case-insensitive nonbinary strings

2) because latin1_swedish_ci is the default collation for latin1, you can
omit the COLLATE operator

3) how to compare, in case-sensitive fashion, two strings that are
not case sensitive

4) If you compare a binary string with a nonbinary string, the comparison treats both
operands as binary strings

5) to compare two nonbinary strings as binary strings, apply the BINARY operator
to either one when comparing them
*/
1)
mysql> SET @s1 = BINARY 'cat', @s2 = BINARY 'CAT';
mysql> SELECT @s1 = @s2;

mysql> SET @s1 = CONVERT(@s1 USING latin1) COLLATE latin1_swedish_ci;
mysql> SET @s2 = CONVERT(@s2 USING latin1) COLLATE latin1_swedish_ci;
mysql> SELECT @s1 = @s2;

2)
mysql> SET @s1 = CONVERT(@s1 USING latin1);
mysql> SET @s2 = CONVERT(@s2 USING latin1);
mysql> SELECT @s1 = @s2;

3)
mysql> SET @s1 = _latin1 'cat', @s2 = _latin1 'CAT';
mysql> SELECT @s1 = @s2;

mysql> SELECT @s1 COLLATE latin1_general_cs = @s2 COLLATE latin1_general_cs
	-> AS '@s1 = @s2';

4)
mysql> SELECT _latin1 'cat' = BINARY 'CAT';

5)
mysql> SET @s1 = _latin1 'cat', @s2 = _latin1 'CAT';
mysql> SELECT @s1 = @s2, BINARY @s1 = @s2, @s1 = BINARY @s2;


/*
EXAMPLE:
> Suppose that this table stores news articles

> Here the article column is declared as a BLOB. That is a binary string type, 
so comparisons of text stored in the column are made without regard to character set
> If that’s not what you want, use ALTER TABLE to convert the
column to a nonbinary type that has a case-insensitive collation
*/

CREATE TABLE news
(
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
article BLOB,
PRIMARY KEY (id)
);


ALTER TABLE news
MODIFY article TEXT CHARACTER SET utf8 COLLATE utf8_general_ci;
