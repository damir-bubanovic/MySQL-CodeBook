/*

!!WORKING WITH STRINGS - STRING PROPERTIES!!

> One string property is whether it is binary or nonbinary:
	• A binary string is a sequence of bytes. 
		>> It can contain any type of information, such	as images, MP3 files, or compressed 
		or encrypted data. 
		>> A binary string is not associated with a character set, even if you store a value 
		such as abc that looks like	ordinary text. 
		>> Binary strings are compared byte by byte using numeric byte values.
	• A nonbinary string is a sequence of characters. 
		>> It stores text that has a particular	character set and collation. 
		>> The character set defines which characters can be stored	in the string. 
		>> The collation defines the character ordering, which affects comparison and sorting 
		operations.

*/

/*
EXAMPLE:
> To see which character sets are available for nonbinary strings, use this statement
*/
mysql> SHOW CHARACTER SET;


/*
> The default character set in MySQL is latin1. If you must store characters from several
languages in a single column, consider using one of the Unicode character sets ( such as
utf8 or ucs2 ) because they can represent characters from multiple languages


> To determine whether a given string contains multibyte characters, use the LENGTH()
and CHAR_LENGTH() functions, which return the length of a string in bytes and characters,
respectively. 
	>> If LENGTH() is greater than CHAR_LENGTH() for a given string, multibyte characters 
	are present

	
EXAMPLE:
1) The utf8 Unicode character set has multibyte characters, but a given utf8 string
might contain only single-byte characters, as in the following example

2) For the ucs2 Unicode character set, all characters are encoded using two bytes, 
even if they are single-byte characters in another character set such as latin1. 
Thus, every ucs2 string contains multibyte characters
*/
1)
mysql> SET @s = CONVERT('abc' USING utf8);
mysql> SELECT LENGTH(@s), CHAR_LENGTH(@s);

2)
mysql> SET @s = CONVERT('abc' USING ucs2);
mysql> SELECT LENGTH(@s), CHAR_LENGTH(@s);


/*
> Another property of nonbinary strings is collation, which determines the sort order of
characters in the character set


EXAMPLE:
1) Use SHOW COLLATION to see all available collations; add a LIKE clause to see the 
collations for a particular character set


> In contexts where no collation is specified explicitly, strings in a given character set 
use the collation with Yes in the Default column

> A collation can be case sensitive (a and A are different), case insensitive (a and A are the
same), or binary (two characters are the same or different based on whether their numeric
values are equal). 
	>> A collation name ending in _ci, _cs, or _bin is case insensitive, case sensitive, 
	or binary, respectively

> Binary string comparisons are always based on single-byte units, whereas a binary collation 
compares nonbinary strings using character numeric values; depending on the character set, 
some of these might be multibyte values

2) Suppose that a table contains a latin1 string column and has the following rows
*/
1)
mysql> SHOW COLLATION LIKE 'latin1%';

2)
mysql> CREATE TABLE t (c CHAR(3) CHARACTER SET latin1);
mysql> INSERT INTO t (c) VALUES('AAA'),('bbb'),('aaa'),('BBB');
mysql> SELECT c FROM t;


/*
> By applying the COLLATE operator to the column, you can choose which collation 
to use for sorting and thus affect the order of the result

EXAMPLE:
1) A case-insensitive collation sorts a and A together, placing them before b and B.

2) A case-sensitive collation puts A and a before B and b, and sorts uppercase 
before lowercase

3) A binary collation sorts characters using their numeric values. Assuming that 
uppercase letters have numeric values less than those of lowercase letters, a binary
collation results in the following ordering
*/
1)
mysql> SELECT c FROM t ORDER BY c COLLATE latin1_swedish_ci;

2)
mysql> SELECT c FROM t ORDER BY c COLLATE latin1_general_cs;

3)
mysql> SELECT c FROM t ORDER BY c COLLATE latin1_bin;


/*
> If you require that comparison and sorting operations use the sorting rules of a 
particular language, choose a language-specific collation


EXAMPLE:
1) To use the traditional Spanish ordering that treats ch and ll as single
characters that follow c and l, respectively, specify the utf8_spanish2_ci collation
	> The two collations produce different results, as shown here (1.1, 1.2)
*/
1.1)
mysql> CREATE TABLE t (c CHAR(2) CHARACTER SET utf8);
mysql> INSERT INTO t (c) VALUES('cg'),('ch'),('ci'),('lk'),('ll'),('lm');
mysql> SELECT c FROM t ORDER BY c COLLATE utf8_general_ci;

1.2)
mysql> SELECT c FROM t ORDER BY c COLLATE utf8_spanish2_ci;
