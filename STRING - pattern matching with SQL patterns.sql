/*

!!WORKING WITH STRINGS - PATTERN MATCHING WITH SQL PATTERNS!!

> You want to perform a pattern match, not a literal comparison

> Use the LIKE operator and an SQL pattern
> Use a regularexpression pattern match

*/

/*
> SQL pattern matching uses the LIKE and NOT LIKE operators rather than = and <> to
perform matching against a pattern string
	> % matches any sequence of characters, including the empty string

EXAMPLE:
1) Strings that begin with a particular substring

2) Strings that end with a particular substring

3) Strings that contain a particular substring at any position

4) Strings that contain a substring at a specific position 
(the pattern matches only if at occurs at the third position of the name column)

5) To reverse the sense of a pattern match, use NOT LIKE. 
	> The following statement finds strings that contain no i characters
	
6) SQL patterns do not match NULL values. This is true both for LIKE and for NOT LIKE
*/
1)
mysql> SELECT name FROM metal WHERE name LIKE 'me%';

2)
mysql> SELECT name FROM metal WHERE name LIKE '%d';

3)
mysql> SELECT name FROM metal WHERE name LIKE '%in%';

4)
mysql> SELECT name FROM metal where name LIKE '__at%';

5)
mysql> SELECT name FROM metal WHERE name NOT LIKE '%i%';

6)
mysql> SELECT NULL LIKE '%', NULL NOT LIKE '%';