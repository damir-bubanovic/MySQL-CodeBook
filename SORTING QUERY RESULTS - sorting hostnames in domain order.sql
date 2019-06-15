/*

!!SORTING QUERY RESULTS - SORTING HOSTNAMES IN DOMAIN ORDER!!

> You want to sort hostnames in domain order, with the rightmost parts of the names
more significant than the leftmost parts

> Break apart the names, and sort the pieces from right to left

*/

/*
> Hostnames are strings and therefore their natural sort order is lexical. 
> However, it’s often desirable to sort hostnames in domain order, where the rightmost 
segments of the hostname values are more significant than the leftmost segments

EXAMPLE:
1) To extract the pieces of the hostnames, begin by using SUBSTRING_INDEX().
	> The hostname values have a maximum of three segments, from which the pieces can be 
	extracted left to right like this
	
> These expressions work properly as long as all the hostnames have three components,
othervise we have a problem
2) add a sufficient number of periods at the beginning of the hostname values
to guarantee that they have the requisite number of segments

3) Expressions do serve to extract the substrings that are needed
for sorting hostname values correctly in right-to-left fashion
*/
1)
SUBSTRING_INDEX(SUBSTRING_INDEX(name,'.',-3),'.',1)
SUBSTRING_INDEX(SUBSTRING_INDEX(name,'.',-2),'.',1)
SUBSTRING_INDEX(name,'.',-1)

2)
mysql> SELECT name,
	-> SUBSTRING_INDEX(SUBSTRING_INDEX(CONCAT('..',name),'.',-3),'.',1)
	-> AS leftmost,
	-> SUBSTRING_INDEX(SUBSTRING_INDEX(CONCAT('.',name),'.',-2),'.',1)
	-> AS middle,
	-> SUBSTRING_INDEX(name,'.',-1) AS rightmost
	-> FROM hostname;
	
3)
mysql> SELECT name FROM hostname
	-> ORDER BY
	-> SUBSTRING_INDEX(name,'.',-1),
	-> SUBSTRING_INDEX(SUBSTRING_INDEX(CONCAT('.',name),'.',-2),'.',1),
	-> SUBSTRING_INDEX(SUBSTRING_INDEX(CONCAT('..',name),'.',-3),'.',1);