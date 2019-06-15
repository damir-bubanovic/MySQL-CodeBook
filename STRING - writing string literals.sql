/*

!!WORKING WITH STRINGS - WRITING STRING LITERALS!!

> You need to write literal strings in SQL statements

> Learn the syntax rules that govern string values

*/

/*
EXAMPLE:
> You can write strings several ways:
1) Enclose the text of the string within single quotes or double quotes
	> When the ANSI_QUOTES SQL mode is enabled, you cannot use double quotes 
	for quoting strings
	
2) Use hexadecimal notation
	> abcd can be written using any of these formats
*/
1)
'my string'
"my string"

2)
0x61626364
X'61626364'
x'61626364'


/*
EXAMPLE:
To specify a character set for interpretation of a literal string, use an 
introducer consisting of a character-set name preceded by an underscore
*/
1)
_latin1 'abcd'
_ucs2 'abcd'


/*
> A quoted string that includes the same quote character produces a syntax error
	> You have several ways to deal with this
	
EXAMPLE:
1) Enclose a string containing single quotes within double quotes or enclose a 
string containing double quotes within single quotes

2) To include a quote character within a string quoted by the same kind of quote,
double the quote or precede it with a backslash. 
	> When MySQL reads the statement, it strips the extra quote or the backslash

3) To write a literal backslash within a string, double it	
*/
ERROR)
mysql> SELECT 'I'm asleep';
ERROR 1064 (42000): You have an error in your SQL syntax near 'asleep''

1)
mysql> SELECT "I'm asleep", 'He said, "Boo!"';

2)
/*
mysql> SELECT 'I''m asleep', 'I\'m wide awake';
OR
mysql> SELECT "He said, ""Boo!""", "And I said, \"Yikes!\"";
*/

3)
mysql> SELECT 'Install MySQL in C:\\mysql on Windows';
