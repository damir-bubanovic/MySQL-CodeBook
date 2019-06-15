/*

!!WORKING WITH STRINGS - PATTERN MATCHING WITH REGULAR EXPRESSIONS!!

> You want to perform a pattern match, not a literal comparison

> Use the REGEXP operator and a regular expression pattern
	> Or use an SQL pattern

*/

/*
LIST OF REGEXP operators

Pattern 	What the pattern matches
^ 			Beginning of string
$ 			End of string
. 			Any single character
[...] 		Any character listed between the square brackets
[^...] 		Any character not listed between the square brackets
p1|p2|p3 	Alternation; matches any of the patterns p1, p2, or p3
* 			Zero or more instances of preceding element
+ 			One or more instances of preceding element
{n} 		n instances of preceding element
{m,n} 		m through n instances of preceding element

*/


/*
> regular expressions

EXAMPLE:
1) Strings that begin with a particular substring

2) Strings that end with a particular substring

3) Strings that contain a particular substring at any position

4) Strings that contain a particular substring at a specific position
*/
1)
mysql> SELECT name FROM metal WHERE name REGEXP '^me';

2)
mysql> SELECT name FROM metal WHERE name REGEXP 'd$';

3)
mysql> SELECT name FROM metal WHERE name REGEXP 'in';

4)
mysql> SELECT name FROM metal WHERE name REGEXP '^..at';


/*
> regular expressions can contain character classes, which match any 
character in the class
	• To write a character class, use square brackets and list the characters you want the
	class to match inside the brackets. 
		> Thus, the pattern [abc] matches a, b, or c.
	• Classes can indicate ranges of characters; use a dash between the beginning and
	end of the range. [a-z] matches any letter, [0-9] matches digits, and [a-z0-9]
	matches letters or digits.
	• To negate a character class (“match any character but these”), begin the list with a
	^ character. 
		> npr. [^0-9] matches anything but digits.
*/


/*
> MySQL’s regular-expression capabilities also support POSIX character classes

POSIX class 	What the class matches
[:alnum:] 		Alphabetic and numeric characters
[:alpha:] 		Alphabetic characters
[:blank:] 		Whitespace (space or tab characters)
[:cntrl:] 		Control characters
[:digit:] 		Digits
[:graph:] 		Graphic (nonblank) characters
[:lower:] 		Lowercase alphabetic characters
[:print:] 		Graphic or space characters
[:punct:] 		Punctuation characters
[:space:] 		Space, tab, newline, carriage return
[:upper:] 		Uppercase alphabetic characters
[:xdigit:] 		Hexadecimal digits (0-9, a-f, A-F)
*/


/*
> The following expression matches values that contain any hexadecimal digit
character
*/
mysql> SELECT name, name REGEXP '[[:xdigit:]]' FROM metal;


/*
> An alternation is similar to a character class in the sense that it matches if any of the
alternatives match. 
	>> unlike a character class, the alternatives are not limited to single characters. 
	>> They can be multiple-character strings or even patterns. 

EXAMPLE:
1) Alternation matches strings that begin with a vowel or end with er

2) Parentheses can be used to group alternations
	> to match strings that consist entirely of digits or entirely of letters, 
	you might try this pattern, using an alternation
	
> Regular expressions do not match NULL values. This is true both for REGEXP 
and for NOT REGEXP
*/
1)
mysql> SELECT name FROM metal WHERE name REGEXP '^[aeiou]|d$';

2)
mysql> SELECT '0m' REGEXP '^[[:digit:]]+|[[:alpha:]]+$';
