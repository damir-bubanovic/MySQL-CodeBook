/*

!!SELECTING DATA FROM TABLES - WHAT TO DO WHEN LIMIT REQUIRES THE WRONG SORT ORDER!!

> LIMIT usually works best in conjunction with an ORDER BY clause that sorts rows. 
	>> But sometimes that sort order differs from what you want for the final result

> Use LIMIT in a subquery to retrieve the desired rows, then use the outer query to 
sort them.

*/

/*
EXAMPLE:
1) Use LIMIT in a subquery to retrieve the desired rows, then use the outer query to 
sort them.
	>> returns the names and birth dates for the four people in the profile table who 
	were born most recently

2) What if you want the output rows to appear in ascending order instead
	>> Use the SELECT as a subquery of an outer statement that re-sorts the rows in the 
	desired final order
		>>> AS t is used here because any table referred to in the FROM clause must have a name
*/
1)
mysql> SELECT name, birth FROM profile ORDER BY birth DESC LIMIT 4;

2)
mysql> SELECT * FROM
	-> (SELECT name, birth FROM profile ORDER BY birth DESC LIMIT 4) AS t
	-> ORDER BY birth;