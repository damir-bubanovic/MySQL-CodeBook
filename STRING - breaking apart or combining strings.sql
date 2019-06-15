/*

!!WORKING WITH STRINGS - BREAKING APART OR COMBINING STRINGS!!

> You want to extract a piece of a string or combine strings to form a larger string

> To obtain a piece of a string, use a substring-extraction function. 
> To combine strings, use CONCAT()

*/

/*
1) You can break apart strings by using appropriate substring-extraction functions. 
npr. LEFT(), MID(), and RIGHT() extract substrings from the left, middle, or right
part of a string

2) The SUBSTRING() function takes a string and a starting position, returning everything
to the right of the position. MID() acts the same way if you omit its third argument
because MID() is actually a synonym for SUBSTRING()

3) Use SUBSTRING_INDEX(str,c,n) to return everything to the right or left of a given
character. It searches into a string str for the n-th occurrence of the character c and
returns everything to its left. If n is negative, the search for c starts from the right and
returns everything to the right of the character

4) You can use substrings for purposes other than display, such as to perform comparisons.
	> npr. finds metal names having a first letter that lies in the last half of the alphabet
	
5) To combine rather than pull apart strings, use the CONCAT() function. 
	> It concatenates its arguments and returns the result
	
6) Concatenation can be useful for modifying column values “in place.” 
	> npr. UPDATE statement adds a string to the end of each name value in the metal table
	
7) To undo the operation, strip the last three characters 
(the CHAR_LENGTH() function returns the length of a string in characters)
*/
1)
mysql> SET @date = '2015-07-21';
mysql> SELECT @date, LEFT(@date,4) AS year,
	-> MID(@date,6,2) AS month, RIGHT(@date,2) AS day;
	
2)
mysql> SET @date = '2015-07-21';
mysql> SELECT @date, SUBSTRING(@date,6), MID(@date,6);

3)
mysql> SET @email = 'postmaster@example.com';
mysql> SELECT @email,
	-> SUBSTRING_INDEX(@email,'@',1) AS user,
	-> SUBSTRING_INDEX(@email,'@',-1) AS host;
	
4)
mysql> SELECT name from metal WHERE LEFT(name,1) >= 'n';

5)
mysql> SELECT CONCAT(name,' ends in "d": ',IF(RIGHT(name,1)='d','YES','NO'))
	-> AS 'ends in "d"?'
	-> FROM metal;
	
6)
mysql> UPDATE metal SET name = CONCAT(name,'ide');
mysql> SELECT name FROM metal;

7)
mysql> UPDATE metal SET name = LEFT(name,CHAR_LENGTH(name)-3);
mysql> SELECT name FROM metal;
