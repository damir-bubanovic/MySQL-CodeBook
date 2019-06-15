/*

!!SORTING QUERY RESULTS - DISPLAYING ONE SET OF VALUES WHILE SORTING BY ANOTHER!!

> You want to sort a result set using values that don’t appear in the output column list

> The ORDER BY clause can refer to columns you don’t display

*/

/*
> This technique is commonly used when you have values that can be represented different
ways and you want to display one type of value but sort by another
	1) npr. you may want to display mail message sizes not in terms of bytes, but as strings 
	such as 103K for 103 kilobytes. You can convert a byte count to that kind of value using this
	expression
	
2) However, such values are strings, so they sort lexically, not numerically. To achieve the 
desired output order, display the string, but use actual numeric size for sorting

> You have to store numbers 0 or 00 (football). 
3) Store jersey numbers as strings

4) Add zero to the jersey_num values to force a string-to-number conversion
*/
1)
CONCAT(FLOOR((size+1023)/1024),'K')

2)
mysql> SELECT t, srcuser,
	-> CONCAT(FLOOR((size+1023)/1024),'K') AS size_in_K
	-> FROM mail WHERE size > 50000
	-> ORDER BY size;

3)
CREATE TABLE roster
(
name CHAR(30), # player name
jersey_num CHAR(3) # jersey number
);

4)
mysql> SELECT name, jersey_num FROM roster ORDER BY jersey_num+0;


/*
> If you want to treat the hostname as more significant than the username
1) Sort the results using the underlying column values rather than the displayed 
composite values

2) To display rows sorted by last name first, the query is straightforward when the 
columns are displayed separately


3) If instead you want to display each name as a single string composed of the first name,
a space, and the last name, begin the query like this
4) Display composite names, but refer to the constituent values in the ORDER BY clause
*/
1)
mysql> SELECT t, CONCAT(srcuser,'@',srchost) AS sender, size
	-> FROM mail WHERE size > 50000
	-> ORDER BY srchost, srcuser;

2)
mysql> SELECT last_name, first_name FROM name
	-> ORDER BY last_name, first_name;	
	
	
3)
SELECT CONCAT(first_name,' ',last_name) AS full_name FROM name ...
4)
mysql> SELECT CONCAT(first_name,' ',last_name) AS full_name
	> FROM name
	-> ORDER BY last_name, first_name;
	


