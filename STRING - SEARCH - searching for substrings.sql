/*

!!WORKING WITH STRINGS - SEARCHING FOR SUBSTRINGS!!

> You want to know whether a given string occurs within another string

> Use LOCATE() or a pattern match

*/

/*
1) The LOCATE() function takes two arguments representing the substring that you’re
looking for and the string in which to look for it. 
	>> The return value is the position at which the substring occurs, or 0 if it’s 
	not present.
	
2) To determine only whether the substring is present if you don’t care about its 
position, an alternative is to use LIKE or REGEXP
*/
1)
mysql> SELECT name, LOCATE('in',name), LOCATE('in',name,3) FROM metal;

2)
mysql> SELECT name, name LIKE '%in%', name REGEXP 'in' FROM metal;