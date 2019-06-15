/*

!!GENERATING SUMMARIES - BASIC SUMMARY TECHNIQUES!!

> You want to summarize a dataset in various ways, such as counting the number of rows
that match certain conditions, determining the smallest or largest of a set of values,
adding or averaging a set of numbers, or finding which unique values are present

> Use the appropriate aggregate function to summarize values, DISTINCT to select unique
values, or COUNT(DISTINCT) to count unique values

*/

/*
SUMMARIZING WITH COUNT()
> To count the number of rows in an entire table or that match particular conditions, use
the COUNT() function

EXAMPLE:
1) To display the rows in a table, use a SELECT * statement, but to count them instead, 
use SELECT COUNT(*)

2) If you don’t know how many US states there are (perhaps you think there are 57?), this
statement tells you

> To count only the number of rows that match certain conditions, include an appropriate
WHERE clause in a SELECT COUNT(*) statement
3) How many times did drivers travel more than 200 miles in a day

4) How many days did Suzi drive

5) How many of the United States joined the Union in the 19th century

6) To count the number of Saturday and Sunday trips in the driver_log table

7) Count weekend versus weekday trips
*/
1)
mysql> SELECT COUNT(*) FROM driver_log;

2)
mysql> SELECT COUNT(*) FROM states;

3)
mysql> SELECT COUNT(*) FROM driver_log WHERE miles > 200;

4)
mysql> SELECT COUNT(*) FROM driver_log WHERE name = 'Suzi';

5)
mysql> SELECT COUNT(*) FROM states
	-> WHERE statehood BETWEEN '1800-01-01' AND '1899-12-31';
	
6)
mysql> SELECT
	-> COUNT(IF(DAYOFWEEK(trav_date)=7,1,NULL)) AS 'Saturday trips',
	-> COUNT(IF(DAYOFWEEK(trav_date)=1,1,NULL)) AS 'Sunday trips'
	-> FROM driver_log;

7)
mysql> SELECT
	-> COUNT(IF(DAYOFWEEK(trav_date) IN (1,7),1,NULL)) AS 'weekend trips',
	-> COUNT(IF(DAYOFWEEK(trav_date) IN (1,7),NULL,1)) AS 'weekday trips'
	-> FROM driver_log;


/*
SUMMARIZING WITH MIN() & MAX()
> Finding smallest or largest values in a dataset is somewhat akin to sorting, except that
instead of producing an entire set of sorted values, you select only a single value at one
end or the other of the sorted range. 
	>> This operation applies to questions about smallest, largest, oldest, newest, 
	most expensive, least expensive, and so forth

> Because MIN() and MAX() determine the extreme values in a set, they’re useful for 
characterizing ranges


EXAMPLE:
1) What date range is represented by the rows in the mail table? What are the smallest
and largest messages sent

2) What are the smallest and largest US state populations

3) What are the first and last state names, lexically speaking? The shortest and longest
names
*/
1)
mysql> SELECT
	-> MIN(t) AS earliest, MAX(t) AS latest,
	-> MIN(size) AS smallest, MAX(size) AS largest
	-> FROM mail;

2)
mysql> SELECT MIN(pop) AS 'fewest people', MAX(pop) AS 'most people'
	-> FROM states;

3)
mysql> SELECT
	-> MIN(name) AS first,
	-> MAX(name) AS last,
	-> MIN(CHAR_LENGTH(name)) AS shortest,
	-> MAX(CHAR_LENGTH(name)) AS longest
	-> FROM states;


/*
SUMMARIZING WITH SUM() & AVG()
> SUM() and AVG() produce the total and average (mean) of a set of values


EXAMPLE:
1) What is the total amount of mail traffic in bytes and the average size of each message

2) How many miles did the drivers in the driver_log table travel? What was the
average number of miles traveled per day

3) What is the total population of the United States

> SUM() and AVG() are numeric functions, so they can’t be used with strings or temporal
values. But sometimes you can convert nonnumeric values to useful numeric forms
4) To compute the total elapsed time, use TIME_TO_SEC() to convert the values to seconds
before summing them. The resulting sum is also in seconds; pass it to SEC_TO_TIME()
to convert it back to TIME format
*/
1)
mysql> SELECT
	-> SUM(size) AS 'total traffic',
	-> AVG(size) AS 'average message size'
	-> FROM mail;

2)
mysql> SELECT
	-> SUM(miles) AS 'total miles',
	-> AVG(miles) AS 'average miles/day'
	-> FROM driver_log;

3)
mysql> SELECT SUM(pop) FROM states;
	
4)
mysql> SELECT SUM(TIME_TO_SEC(t1)) AS 'total seconds',
	-> SEC_TO_TIME(SUM(TIME_TO_SEC(t1))) AS 'total time'
	-> FROM time_val;


/*
USING DISTINCT TO ELIMINATE DUPLICATES
> A summary operation that uses no aggregate functions is determining the unique values
or rows in a dataset. 
	>> Do this with DISTINCT (or DISTINCTROW, a synonym)

> DISTINCT boils down a query result, and often is combined with ORDER BY to place values 
in more meaningful order


EXAMPLE:
1) This query lists in lexical order the drivers named in the driver_log table

2) To determine the number of different drivers, use COUNT(DISTINCT)

3) COUNT(DISTINCT) ignores NULL values. To count NULL as one of the values in the set if
it’s present, use one of the following expressions

> DISTINCT queries often are useful in conjunction with aggregate functions to more fully
characterize your data
> When used with multiple columns, DISTINCT shows the different combinations of values
in the columns and COUNT(DISTINCT) counts the number of combinations
4) Show the different sender/recipient pairs in the mail table and the
number of such pairs
*/
1)
mysql> SELECT DISTINCT name FROM driver_log ORDER BY name;

2)
mysql> SELECT COUNT(DISTINCT name) FROM driver_log;

3)
COUNT(DISTINCT val) + IF(COUNT(IF(val IS NULL,1,NULL))=0,0,1)
COUNT(DISTINCT val) + IF(SUM(ISNULL(val))=0,0,1)
COUNT(DISTINCT val) + (SUM(ISNULL(val))<>0)

4)
mysql> SELECT DISTINCT srcuser, dstuser FROM mail
	-> ORDER BY srcuser, dstuser;

mysql> SELECT COUNT(DISTINCT srcuser, dstuser) FROM mail;	
