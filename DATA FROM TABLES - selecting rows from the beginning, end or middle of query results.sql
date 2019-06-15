/*

!!SELECTING DATA FROM TABLES - SELECTING ROWS FROM THE BEGINNING, END OR MIDDLE OF QUERY RESULTS!!

> You want only certain rows from a result set, such as the first one, the last five, or rows
21 through 40

> Use a LIMIT clause, perhaps in conjunction with an ORDER BY clause

*/

/*
Typical LIMIT uses include the following kinds of problems:
	• Answering questions about first or last, largest or smallest, newest or oldest, least
	or most expensive, and so forth.
	• Splitting a result set into sections so that you can process it one piece at a time. 
		>> This technique is common in web applications for displaying a large search result 
		across several pages. 
		>> Showing the result in sections enables display of smaller, easier-tounderstand
		pages.
*/

/*
EXAMPLE:

1) To see the first row of a SELECT result, add LIMIT n to the end of the statement

2) To see the first 3 rows of a SELECT result, add LIMIT n to the end of the statement

3) ORDER BY - find the row with the minimum (earliest) birth date, sort by the birth column, 
then add LIMIT 1 to retrieve the first row

4) Obtain rows from the end of a result set, sort them in the opposite order

5) Find the earliest or latest birthday within the calendar year, sort by the month and
day of the birth values
*/
1)
mysql> SELECT * FROM profile LIMIT 1;

2)
mysql> SELECT * FROM profile LIMIT 3;

3)
mysql> SELECT * FROM profile ORDER BY birth LIMIT 1;

4)
mysql> SELECT * FROM profile ORDER BY birth DESC LIMIT 1;

5)
mysql> SELECT name, DATE_FORMAT(birth,'%m-%d') AS birthday
	-> FROM profile ORDER BY birthday LIMIT 1;

	
	
/*
EXAMPLE:
1) pull rows from the middle of a result set, use the two-argument form of LIMIT, which
enables you to pick an arbitrary section of rows. 
	>> The arguments indicate how many rows to skip and how many to return.

2) partition a result set into smaller sections
	>> npr. retrieve 20 rows at a time from a result, issue a SELECT statement repeatedly, 
	but vary its LIMIT clause
*/
1)
mysql> SELECT * FROM profile ORDER BY birth LIMIT 2,1;

mysql> SELECT * FROM profile ORDER BY birth DESC LIMIT 2,1;

2)
SELECT ... FROM ... ORDER BY ... LIMIT 0, 20;
SELECT ... FROM ... ORDER BY ... LIMIT 20, 20;
SELECT ... FROM ... ORDER BY ... LIMIT 40, 20;


/*
> To determine the number of rows in a result set so that you can determine the number
of sections, issue a COUNT() statement first
*/
mysql> SELECT COUNT(*) FROM profile;
